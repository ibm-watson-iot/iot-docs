#!/bin/bash

# -----------------------------------------------------------
# Licensed Materials - Property of IBM
# 5737-M66, 5900-AAA
# (C) Copyright IBM Corp. 2020-2021 All Rights Reserved.
# US Government Users Restricted Rights - Use, duplication, or disclosure
# restricted by GSA ADP Schedule Contract with IBM Corp.
# -----------------------------------------------------------

MONGO_NAMESPACE="mongo"

function h1 {
  echo ""
  echo "======================================================================"
  echo $1
  echo "======================================================================"
}

function h2 {
  echo ""
  echo $1
  echo "----------------------------------------------------------------------"
}


RED="\033[31m"
GREEN="\033[32m"
OFF="\033[0m"


# Pre-req checks
# - check oc command on path
command -v oc >/dev/null 2>&1 || { echo >&2 "Required executable \"oc\" not found on PATH.  Aborting."; exit 1; }

# Confirm user is logged in to the OpenShift cluster already
oc whoami &> /dev/null
if [[ "$?" == "1" ]]; then
  echo "You must be logged in to your OpenShift cluster to proceed (oc login)"
  exit 1
fi


h1 "MongoDB CE Uninstaller"


# =====================================================================================================================
# Uninstall
# =====================================================================================================================
h1 "1. MongoDB CE"
echo "This can take a number of minutes to complete.."
oc delete MongoDBCommunity mas-mongo-ce -n ${MONGO_NAMESPACE}
oc delete deployment mongodb-kubernetes-operator  -n ${MONGO_NAMESPACE}
oc delete CustomResourceDefinition mongodbcommunity.mongodbcommunity.mongodb.com -n ${MONGO_NAMESPACE} 
oc delete secrets --all -n ${MONGO_NAMESPACE}
oc delete configmaps --all -n ${MONGO_NAMESPACE}


h1 "10 OpenShift Project"
echo " - Deleting ${MONGO_NAMESPACE}"
oc delete project "${MONGO_NAMESPACE}"
if [ "$?" != 0 ]; then
  echo -e "    - ${RED}Deletion failed${OFF}"
fi

echo ""
echo -e "${GREEN}MongoDB CE uninstall complete${OFF}"