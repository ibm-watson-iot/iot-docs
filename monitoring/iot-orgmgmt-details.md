### Organisation Management (orgmgmt)

---

**Dashboard**: Organizations Overview
**Description**: Provides an overview of the Organizations (workspaces) and users of IoT

**Panel**: IoT Users
**Description**: Shows the number of users configured in IoT

**Panel**: Organizations
**Description**: Shows the number of organizations (workspaces) configured in IoT
Legend:

- active: number of active orgs
- archived: number of orgs disabled but not deleted
- invalid: number of orgs that are classed as invalid
- suspended: number of orgs suspended by an admin

**Panel**: Ready Pool - Clean
**Description**: Shows the number of pre-configured orgs ready to be activated

**Panel**: Ready Pool - Dirty
**Description**: Shows the number of pre-configured orgs ready to be activated by internal monitoring

---

****Dashboard****: Org-store Internal API
**Description**: Show metrics on the internal org-store api used by other components of IoT

**Panel**: org-store getorganizations API calls
**Description**: Shows the number of calls to the getorganizations API (regardless of success/failure)

**Panel**: org-store getorganizations returncodes
**Description**: Shows the percentage of each returncode of calls to the getorganizations API

**Panel**: org-store getorganization API calls
**Description**: Shows the number of calls to the getorganization API (regardless of success/failure)

**Panel**: org-store getorganization returncodes
**Description**: Shows the percentage of each returncode of calls to the getorganization API. Failures here will have effects on many components in IoT that call this API to get organization data

**Panel**: org-store getprovisions API calls
**Description**: Shows the number of calls to the getprovisions API (regardless of success/failure). This API is used to obtain new organization (workspace) provision requests.

**Panel**: org-store getprovisions returncodes
**Description**: Shows the percentage of each returncode of calls to the getprovisions API

**Panel**: org-store updateprovisionagentstate API calls
**Description**: Shows the number of calls to the updateprovisionagentstate API (regardless of success/failure). This API updates the provision-agent state for each agent in IoT

**Panel**: org-store updateprovisionagentstate returncodes
**Description**: Shows the percentage of each returncode of calls to the updateprovisionagentstate API

**Panel**: org-store updateprovisionstate API calls
**Description**: Shows the number of calls to the updateprovisionstate API (regardless of success/failure). This API updates the overall provision state of a provision request that each agent has executed on.

**Panel**: org-store updateprovisionstate returncodes
**Description**: Shows the percentage of each returncode of calls to the updateprovisionstate API

**Panel**: org-store updatermconfig API calls
**Description**: Shows the number of calls to the updatermconfig API (regardless of success/failure). This API updates the RM (Risk Management) part of an organization during provisioning.

**Panel**: org-store updatermconfig returncodes
**Description**: Shows the percentage of each returncode of calls to the updatermconfig API

**Panel**: org-store getdeprovisions API calls
**Description**: Shows the number of calls to the getdeprovisions API (regardless of success/failure). This API gets any deprovision requests for an organization. Deprovision occurs when an IoT instance is deactivated in a workspace.

**Panel**: org-store getdeprovisions returncodes
**Description**: Shows the percentage of each returncode of calls to the getdeprovisions API

---

**Dashboard**: Config-store Internal API
**Description**: Show metrics on the internal config-store api used by other components of IoT

**Panel**: Config-store createorgcomponentconfig API calls
**Description**: Shows the number of calls to the createorgcomponentconfig API (regardless of success/failure). This API is called when a new organization is created and its component configuration needs to be stored.

**Panel**: Config-store createorgcomponentconfig returncodes
**Description**: Shows the percentage of each returncode of calls to the createorgcomponentconfig API

**Panel**: Config-store getcomponentconfigs API calls
**Description**: Shows the number of calls to the getcomponentconfigs API (regardless of success/failure). This API is called retrieve the component configuration for all organizations.

**Panel**: Config-store getcomponentconfigs returncodes
**Description**: Shows the percentage of each returncode of calls to the getcomponentconfigs API

**Panel**: Config-store getorgcomponentconfig API calls
**Description**: Shows the number of calls to the getorgcomponentconfig API (regardless of success/failure). This API is called retrieve the component configuration for an organization.

**Panel**: Config-store getorgcomponentconfig returncodes
**Description**: Shows the percentage of each returncode of calls to the getorgcomponentconfig API. Depending on the features of the organization this call might return 404 as not all component features will be enabled for an organization.