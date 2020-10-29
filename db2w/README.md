# DB2 Warehouse

## 1. How is DB2 Warehouse used in Maximo Application Suite

DB2 Warehouse forms the datasource for Monitor to store all the application metadata and analytics data provided by the Monitor KPI.

### 1.1 IoT Data Store Connector and DB2

The Data store connector (DSC) component in IoT is used to store device event and state data in DB2 warehouse.  Connecting IoT to a DB2 warehouse service allows you to store and access the device/state data.  When the Monitor application is deployed, the configured DB2 service is automatically connected to IoT as part of Monitor deployment procedure.

In IoT, the **destination** resource is used to represent tables in DB2. Creating/Deleting a destination in the platform will attempt to create/delete the table in the target DB2 service.

The configuration property on the **destination** resource will contain metadata that describes the structure of the DB2 table.  On a create of a destination resource, this metadata will be used to generate the `CREATE TABLE` SQL statement that will be executed against the target DB2 service. For example:

```
{
  "name": "TEMPSENSOR_LI",
  "type": "db2",
  "configuration": {
    "columns": [
      { "name": "temp", "type": "float", "nullable": true }, 
      { "name": "hum", "type": "float", "nullable": true }
    ]
  }
}
```

### 1.2 Data Structure in DB2

Monitor creates a dedicated schema for every workspace Id, schema is named as `<workspaceId>_MAM`. All the tables created for a workspace is created under its own schema.

#### Activated Logical Interface

The Monitor application is notified whenever a user configures device state model (schemas, event types, physical and logical interfaces) or activates a logical interface within IoT, on receiving this notification the Monitor application will create new tables and metadata configuration within DB2 Warehouse, and automatically configure forwarding rules in IoT to direct data flow into the table.

As a result, a table with name `IOT_<logical_interface_name>` is created in DB2. The properties of the activated logical interface is used as the metadata along with default information of the LI like device type ID, device ID and timestamps in UTC.

For example: In workspace `test`, for an activated logical interface `dt0_LI`'s schema as shown below for device type `dt0` and device `d0`, 

```
{
    "$schema": "http://json-schema.org/draft-04/schema#",
    "type": "object",
    "title": "schema-title-43702536",
    "description": "",
    "additionalProperties": false,
    "properties": {
        "temp": {
            "type": "number"
        }
    }
}
```

- Monitor creates a table with name `IOT_DT0_LI` in schema `TEST_MAM`.
- The Table's columns are based on the property of the LI schema, so in this case, `TEMP` with Integer type and other default properties like `DEVICEID`, `DEVICETYPE`, `RCV_TIMESTAMP_UTC` and `UPDATED_UTC` columns are created.
- Monitor also creates the forwarding rule to direct the events into this destination.
- So any state update received for this LI will be forwarded to the DB2 by the DSC component in the platform.
- When the device publishes temp reading 15 and 16, we can see two rows with those values in the below image.

![DB2 view for the logical interface dt0_LI](../media/db2.png)


#### Device Metadata
Similar to the above scenario, when a device's metadata/info is created or updated, Monitor is notified and a table `IOT_<logical_interface_name>_CTG` is created in the workspace's schema(`<workspaceId>_MAM`). Each metadata property will be a seperate column in the table. 


## 2. Supported Versions

The following DB2 Warehouse version releases are supported:

- `11.5.X`


## 3. Resource Requirements

Use the [online tool](https://www.ibm.com/links?url=http%3A%2F%2Fdashdb-configurator.stage1.mybluemix.net%2F) to calculate the cluster resource requirements


## 4. Installation

??? abstract "Prerequisite Actions"
    - [Install CloudPak for Data](../cp4d/README.md)

- `oc login` to your OpenShift cluster
- Go to the directory you placed the repo.yaml
- Run the cpd adm command: `./cpd-linux adm -r repo.yaml -a db2wh -n zen --apply --verbose --accept-all-licenses`
- Run the cpd install command: 

```
./cpd-linux -s repo.yaml \
  -a db2wh \
  -n zen \
  -c <storage_class> \
  --verbose \
  --target-registry-username openshift \
  --target-registry-password $(oc whoami -t) \
  --insecure-skip-tls-verify \
  --cluster-pull-prefix image-registry.openshift-image-registry.svc:5000/zen \
  --transfer-image-to image-registry.openshift-image-registry.svc/zen
```


## 5. Supported Storage

System and backup storage, and user storage both require a storage class that supports the ReadWriteOnce access policy.

### OpenShift Container Storage 4.3
- System and backup storage: `ocs-storagecluster-cephfs` (select 4K sector size)
- User storage: `ocs-storagecluster-ceph-rbd` (select 4K sector size and ReadWriteOnce)

### IBM Cloud
IBM Cloud File Storage (`ibmc-file-gold-gid` storage class) & Portworx:

- System and backup storage: `portworx-db2-rwx-sc` (select 4K sector size)
- User storage: `portworx-db2-rwo-sc` (select 4K sector size and ReadWriteOnce)
