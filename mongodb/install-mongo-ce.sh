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

if [ -z "$MONGO_VERSION" ]; then
  MONGO_VERSION="4.2.6"
fi

if [ -z "$MONGOD_CPU" ]; then
  MONGOD_CPU="1"
fi

if [ -z "$MONGOD_MEM_GB" ]; then
  MONGOD_MEM_GB="1G"
fi

if [ -z "$MONGOD_STORAGE_GB" ]; then
  MONGOD_STORAGE_GB="20Gi"
fi

if [ -z "$MONGOD_STORAGE_LOGS_GB" ]; then
  MONGOD_STORAGE_LOGS_GB="2Gi"
fi

if [ -z "$MONGODB_STORAGE_CLASS" ]; then
  echo "Please specify a valid storage class."
  exit 1
  #MONGODB_STORAGE_CLASS="ocs-storagecluster-ceph-rbd"
fi

if [ -z "$MONGO_PASSWORD" ]; then
  echo "Please set a 15 to 20 character alphanumeric MonogDB password."
  exit 1
fi

if [[ "$MONGO_PASSWORD" =~ [^a-zA-Z0-9] ]]; then
  echo "Please ensure the MongoDB admin password is alphanumeric"
  exit 1
fi
if [[ ${#MONGO_PASSWORD} -gt 20  || ${#MONGO_PASSWORD} -lt 15 ]]; then
  echo "Please ensure that the MongoDB admin password is between 15 and 20 characters"
  exit 1
fi

cp config/mas-mongo-ce/__mas_v1_mongodbcommunity_openshift_cr__.yaml config/mas-mongo-ce/__mas_v1_mongodbcommunity_openshift_cr__.yaml.working
sed -i.bak "s|\"{{MAS_MONGO_VERSION}}\"|\"${MONGO_VERSION}\"|g" config/mas-mongo-ce/__mas_v1_mongodbcommunity_openshift_cr__.yaml.working
sed -i.bak "s|{{MAS_MONGO_PASSWORD}}|${MONGO_PASSWORD}|g" config/mas-mongo-ce/__mas_v1_mongodbcommunity_openshift_cr__.yaml.working
sed -i.bak "s|{{MAS_MONGOD_CPU}}|${MONGOD_CPU}|g" config/mas-mongo-ce/__mas_v1_mongodbcommunity_openshift_cr__.yaml.working
sed -i.bak "s|{{MAS_MONGOD_MEM_GB}}|${MONGOD_MEM_GB}|g" config/mas-mongo-ce/__mas_v1_mongodbcommunity_openshift_cr__.yaml.working
sed -i.bak "s|{{MAS_MONGOD_STORAGE_GB}}|${MONGOD_STORAGE_GB}|g" config/mas-mongo-ce/__mas_v1_mongodbcommunity_openshift_cr__.yaml.working
sed -i.bak "s|{{MAS_MONGOD_STORAGE_LOGS_GB}}|${MONGOD_STORAGE_LOGS_GB}|g" config/mas-mongo-ce/__mas_v1_mongodbcommunity_openshift_cr__.yaml.working
sed "s|{{MONGODB_STORAGE_CLASS}}|${MONGODB_STORAGE_CLASS}|g" config/mas-mongo-ce/__mas_v1_mongodbcommunity_openshift_cr__.yaml.working > config/mas-mongo-ce/mas_v1_mongodbcommunity_openshift_cr.yaml
rm config/mas-mongo-ce/__mas_v1_mongodbcommunity_openshift_cr__.yaml.working
rm config/mas-mongo-ce/__mas_v1_mongodbcommunity_openshift_cr__.yaml.working.bak
sed "s|{{MONGO_NAMESPACE}}|${MONGO_NAMESPACE}|g" config/manager/__manager__.yaml > config/manager/manager.yaml


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


oc new-project ${MONGO_NAMESPACE}

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


