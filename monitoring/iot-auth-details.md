### Authentication and Authorization (auth)

---

**Dashboard**: Auth
**Description**: Show metrics on the api-authentication and api-authorization services plus the internal auth-store api used by other components of IoT

**Panel**: Internal Auth API
**Description**: Shows the mean and upper stats on the successful calls to the Authorization API (across all api-authorization services) called by Datapower for each HTTP API call of IoT.

**Panel**: Auth Store Subject Auth Request Rate
**Description**: Shows the rate of calls of calls to the subjectauthapi servlet in the auth-store pods.

**Panel**: Cache Hit Rate
**Description**: Whether the organization document requested during authorization was in the cache.

**Panel**: Cache Miss Rate
**Description**: Whether the organization document requested during authorization was not in the cache, and had to be retrieved from the database.

**Panel**: Cache Load Penalty
**Description**: The average time to retreive the organization document from the db when it was not in the cache.

**Panel**: Authorize Application
**Description**: Shows the mean and upper stats on the successful calls to the Authorization API (across all api-authorization services) called by the mfgx msproxy for each MQTT call of IoT by an application.

**Panel**: Authorize User
**Description**: Shows the mean and upper stats on the successful calls to the Authorization API (across all api-authorization services) called by the mfgx msproxy for each MQTT call of IoT by an user.

**Panel**: Authorize Device
**Description**: Shows the mean and upper stats on the successful calls to the Authorization API (across all api-authorization services) called by the mfgx msproxy for each MQTT call of IoT by an device.

**Panel**: Get Group Membership
**Description**: Shows the mean and upper stats on the successful calls to the getactivedevicesingroup call on the Authorization API (across all api-authorization services).