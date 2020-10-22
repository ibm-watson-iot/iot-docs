# Monitoring Guide

## Contents
1. [What is provided for monitoring in Maximo Application Suite](#1-what-is-provided-for-monitoring-in-maximo-application-suite)
2. [Exmaple setup of Prometheus](#2-prometheus-setup)
3. [Exmaple setup of Grafana](#3-grafana-setup)

## 1. What is provided for monitoring in Maximo Application Suite

From Maximo Application Suite 8.2.0 a number of components in the IoT tool, and the Suite Licensing Service now produce prometheus based metrics and a number of pre-defined grafana dashboards are available to help monitor the components of the IoT tool and licensing issues.

The licensing dashboard can be used to monitor token and license usage over time such as expiration, app points, and product usage. The api stats are also available for overall usage, duration, and calls made.

Maximo Application Suite does not provide the Prometheus or Grafana deployments and these must be provided outside of Maximo Application Suite to take advantage of this monitoring. The following sections will provide a guide as to how you can quickly get setup with a Prometheus and Grafana stack. There are various degrees of configuration that can be achieved based on your requirements (persistence, retention periods, security, etc)

### Prometheus metrics endpoints

One the Prometheus Operator is installed a number of ServiceMonitor kind resources are created by the AppSuite Operator and IoT Operator in the MAS core namespace/project and the IoT namespace/project. These will be read by the Prometheus Operator to indicate the service that provides the metrics endpoint that Prometheus should call to gather metrics.

As of Maximo Application Suite 8.2.0 the following IoT components provide metric endpoints:
- actions
- auth
- dm
- dsc
- guardian
- mfgx
- mbgx
- orgmgmt
- provision
- registry
- state
- webui

As of Maximo Application Suite 8.2.0 the following MAS core metric endpoints are provided:
 - api-licensing

### Grafana Dashboards

Once a Grafana Operator is installed then the IoT operator will ensure that the resources that represent the Grafana Dashboards are installed. If the Red Hat Grafana Operator is used then the resources will belong to the api group `integreatly.org/v1alpha1` and of kind `GrafanaDashboard`. If the IBM Common Services Monitoring service is used then the resource provided by IoT tool belong to the api group `monitoringcontroller.cloud.ibm.com/v1` and of kind `MonitoringDashboard`. Both kinds are automatically picked up by the Grafana Operator and installed into the Grafana Instance into a folder based on the namespace/project name.

As of Maximo Application Suite 8.2.0 the following Grafana dashboards are provided:

- MAS core
  - [Suite Licensing Service](mas-sls-details.md)
- IoT tool
  - [auth](iot-auth-details.md)
  - [dsc](iot-dsc-details.md)
  - [mfgx](iot-mfgx-details.md)
  - [orgmgmt](iot-orgmgmt-details.md)
 
  
## 2. Prometheus Setup

### OpenShift TechPreview 

OpenShift provides a Prometheus that is used to monitor the internals of OpenShift only. To install Prometheus to monitor workloads such as Maximo Application Suite and any other applications in the OpneShift cluster you can configure the OpenShift tech preview to monitor these services as described in https://docs.openshift.com/container-platform/4.3/monitoring/monitoring-your-own-services.html#enabling-monitoring-of-your-own-services_monitoring-your-own-services

In summary of the above link you would:

- Create/Update the configmap so that the `techPreviewUserWorkload` is enabled
- Wait for the Prometheus pods to be created in the `openshift-user-workload-monitoring` project

Customization of the user workload monitoring stack can be achieved by following https://docs.openshift.com/container-platform/4.3/monitoring/cluster_monitoring/configuring-the-monitoring-stack.html#configuring-the-cluster-monitoring-stack_configuring-monitoring but setting the relevant configmaps in the `openshift-user-workload-monitoring` project rather than `openshift-monitoring`

### IBM Common Services

As of version 1.9.0 of the IBM Common Services monitoring service (https://www.ibm.com/support/knowledgecenter/SSHKN6/monitoring/landing_monitoring.html) the Prometheus instance is provided by the Red Hat OpenShift tech preview mentioned above.

If you have an existing IBM Common Services monitoring service then this will work as long as it is able to watch for ServiceMonitor resources in the IoT namespace.

## 3. Grafana Setup

### Red Hat Grafana Operator

The following provides details on how to install and cofigure the [Grafana Operator](https://operatorhub.io/operator/grafana-operator) Red Hat via the OperatorHub into the `openshift-user-workload-monitoring` project.

From the OpenShift UI navigate to the Operators->OperatorHub and search for the "Grafana Operator" provided by Red Hat. Install the operator into the `openshift-user-workload-monitoring` namepsace.

Once the operator is installed update the grafana operators yaml file, via the yaml tab after clicking on the operator, to add the following:

```
args: 
    ['--scan-all']
```

The above property is set under:
```
install:
    spec:
        deployments:
            spec:
                template:
                    spec:
                        containers:
```

The yaml file show now look like this:
```
  install:
    spec:
      deployments:
        - name: grafana-operator
          spec:
            replicas: 1
            selector:
              matchLabels:
                name: grafana-operator
            strategy: {}
            template:
              metadata:
                creationTimestamp: null
                labels:
                  name: grafana-operator
              spec:
                containers:
                  - args:
                      - '--scan-all'
                    command:
                      - grafana-operator
                    ....
```

The above ensures that all projects are scanned for GrafanaDashboard resources. To ensure that the correct permission is set to scan these projects then you can run the following ansible playbook, located in the https://github.com/integr8ly/grafana-operator/tree/master/deploy/ansible repo, to setup the cluster role:

```
ansible-playbook grafana-operator-cluster-dashboards-scan.yaml -e k8s_host=https://api.yourcluster.com:6443 -e k8s_api_key=xxxxx -e k8s_validate_certs=false -e grafana_operator_namespace=openshift-user-workload-monitoring
```

The k8s_api_key is the login token used when you do an oc login. Alternatively you can use `k8s_password` and `k8s_username`.

#### Grafana Instance

Next step is to create the Grafana instance. Within the Grafana Operator UI in Installed Operators section of the OpenShift UI select the `Grafana` tab and click `Create Grafana`. Enter the following yaml:

```
apiVersion: integreatly.org/v1alpha1
kind: Grafana
metadata:
  name: mas-grafana
spec:
  ingress:
    enabled: true
  dataStorage:
    accessModes:
    - ReadWriteOnce
    size: 10Gi
    class: rook-ceph-block-internal
  config:
    log:
      mode: "console"
      level: "warn"
    security:
      admin_user: "root"
      admin_password: "secret"
    auth:
      disable_login_form: False
      disable_signout_menu: True
    auth.anonymous:
      enabled: True
  dashboardLabelSelector:
    - matchExpressions:
        - {key: app, operator: In, values: [grafana]}
```
The above will create will create a PVC using the `rook-ceph-block-internal` storage class and set a admin username of `root` and password of `secret`. These values should be changed to more secure values.

A route is also created and the public url can be located in that route definition in the `openshift-user-workload-monitoring` namespace/project.

Further customizations can be found in https://github.com/integr8ly/grafana-operator/blob/v3.5.0/documentation/deploy_grafana.md and also manual scripts to set the cluster role if ansible is not preferred.

#### Grafana Datasource

Next step is to create the GrafanaDatasource that will point to the prometheus instance installed eariler. Similar to the Grafana Instance choose the `Grafana Datasource` from the operator UI, and set the following yaml:

```
apiVersion: integreatly.org/v1alpha1
kind: GrafanaDataSource
metadata:
  name: mas-prom-grafanadatasource
  namespace: openshift-user-workload-monitoring
spec:
  datasources:
    - access: proxy
      editable: true
      isDefault: true
      jsonData:
        httpHeaderName1: Authorization
        timeInterval: 5s
        tlsSkipVerify: true
      name: prometheus
      secureJsonData:
        httpHeaderValue1: >-
          Bearer
          <TOKEN HERE>
      type: prometheus
      url: >-
        https://prometheus-operated.openshift-user-workload-monitoring.svc.cluster.local:9091/
      version: 1
  name: mas-datasources.yaml
```

The bearer token to be set where TOKEN HERE is set, can be retrieved by running:

```
oc -n openshift-user-workload-monitoring serviceaccounts get-token prometheus-user-workload
```

Further details on a Grafana Datasource can be seen here: https://github.com/integr8ly/grafana-operator/blob/v3.5.0/documentation/datasources.md

Note: the datasource name that is set above is `prometheus` and the provided GrafanaDashboards from Maximo Application Suite IoT tool are expecting this to be the datasource name.

### IBM Common Services

Alternatively to the Red Hat Grafana Operator you can install the IBM Common Services Monitoring service (https://www.ibm.com/support/knowledgecenter/SSHKN6/monitoring/landing_monitoring.html) which will install the IBM Common Services Grafana Operator. Similar to the Red Hat Grafana Operator this operator will be configured to scan all namespaces/projects to find GrafanaDashboards.

Please follow the details in https://www.ibm.com/support/knowledgecenter/SSHKN6/monitoring/landing_monitoring.html on how to install the IBM Common Services Monitoring service.