# Monitoring Guide

## Contents
1. [What is provided for monitoring in Maximo Application Suite](#1-what-is-provided-for-monitoring-in-maximo-application-suite)
2. [Example setup of Prometheus](#2-prometheus-setup)
3. [Example setup of Grafana](#3-grafana-setup)

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

### OpenShift 4.3 TechPreview 

OpenShift provides a Prometheus that is used to monitor the internals of OpenShift only. To install Prometheus to monitor workloads such as Maximo Application Suite and any other applications in the OpneShift cluster you can configure the OpenShift tech preview to monitor these services as described in https://docs.openshift.com/container-platform/4.3/monitoring/monitoring-your-own-services.html#enabling-monitoring-of-your-own-services_monitoring-your-own-services

In summary of the above link you would:

- Create/Update the configmap so that the `techPreviewUserWorkload` is enabled
- Wait for the Prometheus pods to be created in the `openshift-user-workload-monitoring` project

Customization of the user workload monitoring stack can be achieved by following https://docs.openshift.com/container-platform/4.3/monitoring/cluster_monitoring/configuring-the-monitoring-stack.html#configuring-the-cluster-monitoring-stack_configuring-monitoring but setting the relevant configmaps in the `openshift-user-workload-monitoring` project rather than `openshift-monitoring`

### Openshift 4.6 and onwards

Openshift promoted the tech preview to a full feature but the configuration is similar to how it was. Full details are here https://docs.openshift.com/container-platform/4.6/monitoring/enabling-monitoring-for-user-defined-projects.html.

Alternatively you can use the ansible mas_devops collection to configure the cluster monitoring. Details on this role are found here https://ibm-mas.github.io/ansible-devops/roles/cluster_monitoring/ and general details on this collection are here https://ibm-mas.github.io/ansible-devops/.

### IBM Common Services

As of version 1.9.0 of the IBM Common Services monitoring service (https://www.ibm.com/support/knowledgecenter/SSHKN6/monitoring/landing_monitoring.html) the Prometheus instance is provided by the Red Hat OpenShift user workload prometheus mentioned above.

If you have an existing IBM Common Services monitoring service then this will work as long as it is able to watch for ServiceMonitor resources in the IoT namespace.

## 3. Grafana Setup

### Red Hat Grafana Operator v4.4.x

It is recommended to to install andd configure the [Grafana Operator](https://operatorhub.io/operator/grafana-operator) v4 using the ansible mas_devops collection and the cluster_monitoring role. Details on this role are found here https://ibm-mas.github.io/ansible-devops/roles/cluster_monitoring/ and general details on this collection are here https://ibm-mas.github.io/ansible-devops/.

The role will install the grafana operator and make sure it can scan all namespaces for the MAS provided dashboards. 


### IBM Common Services

Alternatively to the Red Hat Grafana Operator you can install the IBM Common Services Monitoring service (https://www.ibm.com/support/knowledgecenter/SSHKN6/monitoring/landing_monitoring.html) which will install the IBM Common Services Grafana Operator. Similar to the Red Hat Grafana Operator this operator will be configured to scan all namespaces/projects to find GrafanaDashboards.

Please follow the details in https://www.ibm.com/support/knowledgecenter/SSHKN6/monitoring/landing_monitoring.html on how to install the IBM Common Services Monitoring service.