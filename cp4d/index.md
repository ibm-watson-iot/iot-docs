# CloudPak For Data

## 1. How is CP4D used in Maximo Application Suite

CP4D is the distributor of the DB2 Warehouse which is used as the datasource for Monitor to store all the application metadata and analytics data provided by the Monitor KPI.

## 2. Supported Versions

The following CP4D version releases are supported:

- `3.0.1`


## 3. Supported Deployment Details

### 3.1 Basic Cluster requirements

### 3.2 Cluster Resource requirements

#### 3.2.1 Master + infra Minimum Resource requirements per node
 
|                         | Developer / Small | Medium         |
|-------------------------|-------------------|----------------|
| **Master+infra CPU**    | `8vCPU`           | `8vCPU`        |
| **Master+infra Memory** | `32Gi`            | `32Gi`         |

#### 3.2.2 Workers/Compute Resource requirements per node

|                      | Developer / Small | Medium          |
|----------------------|-------------------|-----------------|
| **Worker CPU**       | `16vCPU`          | `16vCpu`        |
| **Worker Memory**    | `64Gi`            | `128Gi`         |

#### 3.2.2 Load Balancer Resource requirements per node

|                      | Developer / Small | Medium           |
|----------------------|-------------------|------------------|
| **Worker CPU**       | `--`              | `4vCPU`          |
| **Worker Memory**    | `--`              | `4Gi`            |

## 4. Pre-installation requirements

### 4.1 Setting up your registry

- To install Cloud Pak for Data, you must have a registry server where you can host the images for the Cloud Pak for Data control plane and the services that you want to install.

- Alternatively, you can use the internal Docker registry in your Red Hat OpenShift cluster. This option is recommended because it does not require you to manage pull secrets. See [Red Hat OpenShift Internal Registry Overview](https://docs.openshift.com/container-platform/3.11/install_config/registry/index.html) for details, and ensure that you can access the registry externally.

### 4.2 Obtaining Installation files

You will need a a Linux or Mac OS client workstation to run the installation from. The workstation does not have to be a node of the cluster, but must have internet access and be able to connect to the Red Hat OpenShift cluster.

Ensure that you have your entitlement license API key from the [Container software library on My IBM](https://myibm.ibm.com/products-services/containerlibrary) and your IBM ID.  After you order IBM® Cloud Pak for Data, an entitlement key for the software is associated with your My IBM account. To get the entitlement key:

- Log in to [Container software library on My IBM](https://myibm.ibm.com/products-services/containerlibrary) with the IBM ID and password that are associated with the entitled software.
- On the Get entitlement key tab, select Copy key to copy the entitlement key to the clipboard.
- Save the API key in a text file.

Download the appropriate file from [IBM Passport Advantage](https://www.ibm.com/software/passportadvantage/pao_customer.html), run run the BIN file: `./filename.bin`.  A cpd folder is created in the current directory, and the following files are downloaded to it:

- cloudpak4data*.tgz
- repo.yaml

In the cpd folder, extract the contents of `cloudpak4data*.tgz` which includes the cpd command binaries: `tar -xvf cloudpak4data*.tgz`.  After you extract the contents of the TAR file, you can delete it from your file system to free up space.

Set up the requirements for the cpd command:
- On the same workstation, download and extract either the Linux or Mac OS oc v3.11 client tools from the Download OKD web site.
- The oc command is required for the cpd command to succeed.

Edit the server definition file repo.yaml that you downloaded.

This file specifies the repositories for the cpd command to download the installation files from. Make the following changes to the file:

- `username` Specify cp.
- `apikey` Specify your entitlement license API key.

Save the file.


## 5. Installing
- `oc login` to your OpenShift cluster
- Go to the directory you placed the repo.yaml
- Run the cpd adm command:
`./cpd-linux adm -r repo.yaml -n zen --apply --verbose --accept-all-licenses`

- Run the cpd install command:
`./cpd-linux -s repo.yaml --verbose --target-registry-username openshift --target-registry-password $(oc whoami -t) --insecure-skip-tls-verify --cluster-pull-prefix image-registry.openshift-image-registry.svc:5000/zen --transfer-image-to image-registry.openshift-image-registry.svc/zen -n zen -c <storage_class>`

