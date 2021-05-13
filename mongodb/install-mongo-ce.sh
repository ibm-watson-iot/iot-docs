#!/bin/bash

# -----------------------------------------------------------
# Licensed Materials - Property of IBM
# 5737-M66, 5900-AAA
# (C) Copyright IBM Corp. 2021 All Rights Reserved.
# US Government Users Restricted Rights - Use, duplication, or disclosure
# restricted by GSA ADP Schedule Contract with IBM Corp.
# -----------------------------------------------------------

# Terminal colours
RED="\033[31m"
GREEN="\033[32m"
OFF="\033[0m"

if [ -z "$MONGO_NAMESPACE" ]; then
  MONGO_NAMESPACE="mongo"
fi


command -v oc >/dev/null 2>&1 || { echo >&2 "Required executable \"oc\" not found on PATH.  Aborting."; exit 1; }

oc whoami &> /dev/null
if [[ "$?" == "1" ]]; then
  echo "You must be logged in to your OpenShift cluster to proceed (oc login)"
  exit 1
fi

function showWorking {
  # Usage: run any command in the background, capture it's PID
  #
  # somecommand >> /dev/null 2>&1 &
  # showWorking $!
  #
  PID=$1

  sp='/-\|'
  printf ' '
  while s=`ps -p $PID`; do
      printf '\b%.1s' "$sp"
      sp=${sp#?}${sp%???}
      sleep 0.1s
  done
  printf '\b '
}


function waitForTheDeployment {
  echo -n " - Waiting for MongoDB CE Operator  "
  while [[ $(oc get deployment mongodb-kubernetes-operator -n ${MONGO_NAMESPACE} -o 'jsonpath={..status.conditions[?(@.type=="Available")].status}') != "True" ]];do sleep 5s; done &
  showWorking $!
}

function waitForTheStatefulSet {
  echo -n " - Waiting for MongoDB CE Stateful Set to initialize and start  "
  while [[ $(oc get statefulset mas-mongo-ce -n ${MONGO_NAMESPACE} -o 'jsonpath={..status.readyReplicas}') != "3" ]];do sleep 5s; done &
  showWorking $!
}


oc new-project mongo

oc apply -f config/crd/mongodbcommunity.mongodb.com_mongodbcommunity.yaml -n ${MONGO_NAMESPACE} 

oc apply -k config/rbac/.  -n ${MONGO_NAMESPACE} 

oc adm policy add-scc-to-user anyuid system:serviceaccount:${MONGO_NAMESPACE}:default
oc adm policy add-scc-to-user anyuid system:serviceaccount:${MONGO_NAMESPACE}:mongodb-kubernetes-operator   

oc create -f config/manager/manager.yaml -n ${MONGO_NAMESPACE}
waitForTheDeployment

cd certs
oc create configmap mas-mongo-ce-cert-map --from-file=ca.crt=ca.pem -n ${MONGO_NAMESPACE} 
oc create secret tls mas-mongo-ce-cert-secret --cert=server.crt --key=server.key -n ${MONGO_NAMESPACE}
cd ..

oc apply -f config/mas-mongo-ce/mas_v1_mongodbcommunity_openshift_cr.yaml -n ${MONGO_NAMESPACE} 
sleep 5s
waitForTheStatefulSet

oc rollout restart statefulset mas-mongo-ce -n ${MONGO_NAMESPACE}


