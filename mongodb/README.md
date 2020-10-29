# MongoDB Quick Start Guide

## Contents
1. How is MongoDB used in Maximo Application Suite
2. Supported Versions
3. Using MongoDB Community Edition

## 1. How is MongoDB used in Maximo Application Suite

Mutliple databases are created in Mongo, but both the core MAS runtimes and the IoT tool (if deployed):

| Database                            | Notes                      |
| ----------------------------------- | -------------------------- |
| mas_{instanceid}_core               | Primary datastore for MAS  |
| iot_{instanceid}_cs_activity_db     | Used by IoT                |
| iot_{instanceid}_d_actions          | Used by IoT                |
| iot_{instanceid}_d_core             | Used by IoT                |
| iot_{instanceid}_d_dashboard        | Used by IoT                |
| iot_{instanceid}_d_deviceregistry   | Used by IoT                |
| iot_{instanceid}_d_dmserver         | Used by IoT                |
| iot_{instanceid}_d_dsc              | Used by IoT                |
| iot_{instanceid}_d_infomgmt         | Used by IoT                |
| iot_{instanceid}_d_provision_s2s    | Used by IoT                |
| iot_{instanceid}_d_riskmgmtsecurity | Used by IoT                |
| iot_{instanceid}_organizations      | Used by IoT                |


## 2. Supported Versions

The followong MongoDB version releases are supported:
- `3.6.X`

## 3. Using MongoDB Community Edition
MongoDB Community Edition is fully supported by Maximo Application Suite, the following steps will allow you to:

- Build a docker image that includes MongoDB Community Edition.
- Deploy a standalone MongoDB Community Edition instance with TLS enabled.


??? abstract "Prerequisite Actions"
    - Install the following components:
        - [Docker](https://www.docker.com/products/docker-desktop)
        - [OpenShift Origin](https://github.com/openshift/origin/releases)
        - openssl (for generating certificates)
    - Expose the internal image registry in the target OpenShift cluster

!!! example "Creating a route to the internal image registry on IBM Cloud"
    See this [example](https://cloud.ibm.com/docs/openshift?topic=openshift-registry#route_internal_registry) for creating a route to the internal image registry on OpenShift in IBM Cloud.

### 3.1 Build the MongoDB Community Edition docker image

The Docker image sets up a containerized version of Mongo Community Edition with scripts helping it startup with setup provided by the user. 

Download and extract [mongo-ce.zip](mongo-ce.zip).  From your command line, run the following command:
```
docker build -t mongo-ce image/
```

In the documentation we're using the internal docker registry inside of OpenShift. You will need to create a route to the internal registry (example in prerequisites) in order for the install script to successfully push the image. 

### 3.2 Generate a certificate

Go into the certificate folder and edit `certificate/openssl.cnf` defaults as you see fit.  When done with the updates, run `generateSelfSignedCert.sh` from inside the certificate directory; this will generate the `mongodb.pem` certificate file used by Mongo.

### 3.3 Define a storage class

Before you can setup Mongo you need to first define a Storage Class that will be used for Persistant Volume Claims. The specific configuration of this Storage Class will be determined by the available Storage Providers in your OpenShift Cluster environment, however in order to be compatible with the subsequent example resources the Storage Class that you define should have the following name: mongodbsc

For example, the YAML defnition would start like this:

```
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: mongodbsc
```

For IBM cloud a storage class is already provided: `ibmcloud/mongodbsc.yaml`

```
oc apply -f ibmcloud/mongodbsc.yaml
```

### 3.4 Install MongoDB Community Edition

Installing automatically creates the `mongo` namespace and updates the Kubernetes context. It installs dependencies like the oc and kubectl client. It will use the information that you pass in via commandline to the kubernetes statefulset yaml and deploy it.

You will need to supply a keyfile secret which is used by Mongo internally to communicate with other replicaset nodes, while here we're only setting up a standlone Mongo it can be scaled to a larger cluster by setting the replicas to something other than 1. 

To install, from the `installer` directory, run the following commands:

```
oc login
bash install.sh -k keyfile_secret -a admin_password -d true
```

Alternatively you can confgure the script using environment variables as below:

```
export KEYFILE_SECRET=$(echo "secret" | base64)
export ADMIN_PASSWORD="password"

bash install.sh -d true
```

The installer uses a `statefulset-template.yaml` and replaces several variables with the provided inputs from the above commands and outputs a new file called `statefulset.yaml`

In addition, with `-d true` set the oc client deploys using the above variables and cleans up the created `statefulset.yaml` when done. For debugging you can leave off `-d true`. In this case a `statefulset.yaml` file is written to your current directory with the environment variables substituted. In this file, verify that secrets are defined with base64 values and that there are no lingering variables that were possibly unset, for example you could see `${KEYFILE_SECRET}` in the `statefulset.yaml`. This should be impossible.

**Optional: Clean up**
This script can clean up the existing `mongo` project if needed. This assumes you've already ran install at some point, do NOT run this if you have not already run install.

```
bash install.sh -c true
```