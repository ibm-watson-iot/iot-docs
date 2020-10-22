### Messaging Frontend Group (mfgx)

---

**Dashboard**: Msproxy Overview
**Description**: Provides an overview of the mfgx msproxy component that handles MQTT/HTTP messaging

**Panel**: Incoming Connection Rates
**Description**: The number of new connections per second. Connection rates provided for all TCP connections, all MQTT connections and connections leveraging TLS 1.3, TLS 1.2 and TLS 1.1.

**Panel**: Connected Clients (MQTT Connections)
**Description**: The total number of connected MQTT clients.

**Panel**: Traffic
**Description**: Details various write bytes per second (egress) and read bytes per second (ingress).

**Panel**: Connected Clients (big delay in these stats)
**Description**: The total number of connected clients by type.

**Panel**: Incoming Message Rate (aggregate of all msproxy)
**Description**: The number of messages incoming (ingress) per second broken down by QoS0, QoS1, QoS2 and HTTP.

**Panel**: Outgoing Message Rate (aggregate of all msproxy)
**Description**: The number of messages outgoing (egress) per second broken down by QoS0, QoS1, and QoS2

**Panel**: Average Authentication Time
**Description**: The average time to authenticate a client. Detail provided for each msproxy instance.

**Panel**: Peak Authentication Response Time
**Description**: The peak or largest authentication time recorded over a given time period. Detail provided for each msproxy instance.

**Panel**: Peak Authentication Response Time (aggregate of all msproxy)
**Description**: The peak or largest authentication time recorded from any msproxy instance.

**Panel**: Average Authentication Time (aggregate of all msproxy)
**Description**: The average time to authenticate a client with respect to all msproxy instances.

**Panel**: Authentication Requests Count
**Description**: The number of authentication requests in a given time period.

**Panel**: Authentication Requests Rate
**Description**: The rate of authentication requests. Authentication requests per second.

**Panel**: Authentication Requests Rate (aggregate of all msproxy)
**Description**: The rate of authentication requests for all msproxy instances combined. Authentication requests per second.

**Panel**: MQTT Pending Authentication Requests
**Description**: The total number of pending MQTT authentication requests for a given msproxy instance.

**Panel**: MQTT Pending Authorization Requests
**Description**: The total number of pending MQTT authorization requests for all msproxy instances.

**Panel**: MQTT Pending Authentication Requests (aggregate of all msproxy)
**Description**: The total number of pending MQTT authentication requests for all msproxy instances.

**Panel**: MQTT Connection Rate
**Description**: The MQTT connection rate in connections per second for a given msproxy instance.

**Panel**: MQTT Connected Devices
**Description**: The total number of MQTT devices connected to a given msproxy instance.

**Panel**: MQTT Connected Gateways
**Description**: The total number of MQTT Gateways connected to a given msproxy instance.

**Panel**: MQTT Connected Applications
**Description**: The total number of MQTT applications connected to a given msproxy instance.

**Panel**: Connections by MQTT Version
**Description**: Total number of MQTT connections by MQTT protocol version to all msproxy instances.

**Panel**: HTTP Pending Authentication Requests
**Description**: The total number of pending HTTP authentication requests to a given msproxy instance.

**Panel**: HTTP Connections
**Description**: The total number of HTTP connections connected to a given msproxy instance.

**Panel**: HTTP Connected Applications
**Description**: The total number of HTTP applications connected to a given msproxy instance.

**Panel**: HTTP Connected Devices
**Description**: The total number of HTTP devices connected to a given msporxy instance.

**Panel**: Total Connections (TCP, MUX, MQTT)
**Description**: The total number of TCP and MQTT connections to all msproxy instances. MQTT connections are a subset of the TCP connections. And total number of virtual outbound connection (MUX) to MessageGateway.

---

**Dashboard**: Direct Publish to Kafka
**Description**: Provides an metrics on the publishing of events to the events topic on the configured Kafka used by other IoT components

**Panel**: Received Message Rate distribution across Kafka partitions
**Description**: The rate of messages sent per second from all msproxy instances to specific Kafka partitions.

**Panel**: Sent Message Rate distribution across Kafka partitions
**Description**: The rate of messages consumed per second from specifc Kafka partitions by all msproxy instances.

**Panel**: Received vs Sent rate
**Description**: A comparison of the messages sent to Kafka and received by Kafka

**Panel**: Message rate per MSProxy - Receive Rate
**Description**: The rate of messages received by specific msproxy instances from Kafka.

**Panel**: Message rate per MSProxy - Send Rate
**Description**: The rate of messages sent by specific msproxy instances to Kafka.

**Panel**: Avg Kafka Producer Latency per MSProxy
**Description**: The average latency per msproxy instance when producing a Kafka message.

**Panel**: Messages buffered for transmission to Kafka
**Description**: The number of messages buffered for transmission to Kafka per msproxy instance.

**Panel**: Total Message rate (accepted + skipped) - Cache connectors
**Description**: The message rate for messages sent to Cache connectors

**Panel**: Accept/Skip percentage - Cache connectors
**Description**: The percentage of messages skipped by cache connectors.

**Panel**: Active Partitions - Cache connectors
**Description**: Active Kafka partitions for cache connectors.

---

**Dashboard**: Msproxy - Usage Statistics - TCP
**Description**: Provides an the usage statistics at the TCP level for msproxy

**Panel**: Pending Outgoing Connections
**Description**: TCP connections (i.e. Message Gateway, Kafka, etc) that are in process or waiting for the connection to be established.

**Panel**: Incoming Connections (Current)
**Description**: Current number of established client connections to each msproxy instance.

**Panel**: Outgoing Connections (Current)
**Description**: The current number of established TCP connections (i.e. Message Gateway, Kafka, etc) per msproxy instance.

**Panel**: New Incoming Connections
**Description**: The total number of new TCP connections that have been established for a specific time period by msproxy instance.

**Panel**: New Incoming Connections Rate (New Connections/Sec)
**Description**: The rate of new TCP connections per second by msproxy instance.

**Panel**: Outgoing Connections Total
**Description**: The total number of established TCP connections (i.e. Message Gateway, Kafka, etc) over the lifetime of a given msproxy instance.

**Panel**: Outgoing Connections Rate (Connections/Sec)
**Description**: The TCP connection rate in connections per second to Message Gateway, Kafka, etc.

**Panel**: Virtual Connections Maximum
**Description**: The maximum or highest number of virtual (MUX) connections to Message Gateway per msproxy instance.

**Panel**: Virtual Connections Minimum
**Description**: The minimum or lowest number of virtual (MUX) connections to Message Gateway per msproxy instance.

**Panel**: Virtual Connections Average Per Physical Connection
**Description**: The average number of virtual (MUX) connections to Message Gateway per TCP connection.

**Panel**: Physical Connections
**Description**: The number of TCP connections from a given msproxy instance to Message Gateway. The TCP connection is utilized by virtual (MUX) connections.

---
****
**Dashboard**: Msproxy - Usage Statistics - MQTT
**Description**: Provides an the usage statistics at the MQTT level for msproxy

**Panel**: Pending Authentication Requests
**Description**: The total number of pending MQTT authentication requests for a given msproxy instance.

**Panel**: Pending Authorization Requests
**Description**: The total number of pending MQTT authorization requests for a given msproxy instance.

**Panel**: Connections
**Description**: The total number of MQTT connections a given msproxy instance.

**Panel**: Connected Applications
**Description**: The total number connected MQTT applications per msproxy instance.

**Panel**: Connected Devices
**Description**: The total number of connected MQTT devices per msproxy instance.

**Panel**: Connected Gateways
**Description**: The total number of connected MQTT gateways per msproxy instance

**Panel**: New Connections
**Description**: The total number of new MQTT connections that have been established for a specific time period by msproxy instance.

**Panel**: New Connections Rate (New Connections/Sec)
**Description**: The rate of new MQTT connections per second per msproxy instance.

**Panel**: Client2Proxy Msgs Received - QoS0
**Description**: The number of new MQTT QoS 0 messages received per msproxy instance.

**Panel**: Client2Proxy Msgs Received Rate (Msgs/Sec) - QoS0
**Description**: The rate of new MQTT QoS 0 messages per second per msproxy instance.

**Panel**: Client2Proxy Msgs Received - QoS1
**Description**: The number of new MQTT QoS 1 messages received per msproxy instance.

**Panel**: Client2Proxy Msgs Received Rate (Msgs/Sec) - QoS1
**Description**: The rate of new MQTT QoS 1 messages per second per msproxy instance.

**Panel**: Client2Proxy Msgs Received - QoS2
**Description**: The number of new MQTT QoS 2 messages received per msproxy instance.

**Panel**: Client2Proxy Msgs Received Rate (Msgs/Sec) - QoS2
**Description**: The rate of new MQTT QoS 2 messages per second per msproxy instance.

**Panel**: Client2Proxy Msgs Sent
**Description**: The number of MQTT messages sent to clients per msproxy instance

**Panel**: Client2Proxy Msgs Sent Rate (Msgs/Sec)
**Description**: The rate of MQTT messages per second sent to clients per msproxy instance.

**Panel**: Proxy2Server Msgs Received - QoS0
**Description**: The number of MQTT QoS 0 messages received from Message Gateway per msproxy instance.

**Panel**: Proxy2Server Msgs received Rate (Msgs/Sec) - QoS0
**Description**: The rate of MQTT QoS 0 messages per second received from Message Gateway per second per msproxy instance.

**Panel**: Proxy2Server Msgs Received - QoS1
**Description**: The number of MQTT QoS 1 messages received from Message Gateway per msproxy instance.

**Panel**: Proxy2Server Msgs received Rate (Msgs/Sec) - QoS1
**Description**: The rate of MQTT QoS 1 messages per second received from Message Gateway per second per msproxy instance.

**Panel**: Proxy2Server Msgs Received - QoS2
**Description**: The number of MQTT QoS 2 messages received from Message Gateway per msproxy instance.

**Panel**: Proxy2Server Msgs received Rate (Msgs/Sec) - QoS2
**Description**: The rate of MQTT QoS 2 messages per second received from Message Gateway per second per msproxy instance.

**Panel**: Proxy2Server Msgs Sent
**Description**: The number of MQTT messages sent to Message Gateway per msproxy instance.

**Panel**: Proxy2Server Msgs Sent Rate (Msgs/Sec)
**Description**: The rate of MQTT messages per second sent to Message Gateway per msproxy instance.

---

**Dashboard**: Msproxy - Usage Statistics - MQTT Message Sizes
**Description**: Provides an the usage statistics related to message sizes at the MQTT level for msproxy

**Panel**: Distribution of msg rates by msg size (across all msproxy instances)
**Description**: A breakdown by message payload size of the MQTT message rate from clients to all msproxy instances.

**Panel**: Distribution of msg rates by msg size (excluding quickstart)
**Description**: A breakdown by message payload size of the MQTT message rate from clients to all msproxy instances. This panel excludes quickstart proxy instances.

**Panel**: Client 2 Proxy 512B Messages
**Description**: The number of new MQTT messages sent from clients with a payload size 512 bytes and less.

**Panel**: Client 2 Proxy 1KB Messages
**Description**: The number of new MQTT messages sent from clients with a payload size between 512 bytes and 1KB.

**Panel**: Client 2 Proxy 4KB Messages
**Description**: The number of new MQTT messages sent from clients with a payload size between 1KB and 4KB.

**Panel**: Client 2 Proxy 16KB Messages
**Description**: The number of new MQTT messages sent from clients with a payload size between 4KB and 16KB.

**Panel**: Client 2 Proxy 64KB Messages
**Description**: The number of new MQTT messages sent from clients with a payload size between 16KB and 64KB.

**Panel**: Client 2 Proxy Large Messages
**Description**: The number of new MQTT messages sent from clients with a payload size greater than 64KB.

**Panel**: Proxy 2 Server 512B Messages
**Description**: The number of new HTTP messages sent from a proxy instance to Message Gateway with a payload size 512 bytes and less.

**Panel**: Proxy 2 Server 1KB Messages
**Description**: The number of new MQTT messages sent from a proxy instance to Message Gateway with a payload size between 16KB and 64KB.

**Panel**: Proxy 2 Server 4KB Messages
**Description**: The number of new MQTT messages sent from a proxy instance to Message Gateway with a payload size between 16KB and 64KB.

**Panel**: Proxy 2 Server 16KB Messages
**Description**: The number of new MQTT messages sent from a proxy instance to Message Gateway with a payload size between 16KB and 64KB.

**Panel**: Proxy 2 Server 64KB Messages
**Description**: The number of new MQTT messages sent from a proxy instance to Message Gateway with a payload size between 16KB and 64KB.

**Panel**: Proxy 2 Server Large Messages
**Description**: The number of new MQTT messages sent from a proxy instance to Message Gateway with a payload size greater than 64KB.

---

**Dashboard**: Msproxy - Usage Statistics - HTTP
**Description**: Provides an the usage statistics at the HTTP level for msproxy

**Panel**: Pending Authentication Requests
**Description**: The total number of pending HTTP authentication requests for all msproxy instances.

**Panel**: Pending Authorization Requests
**Description**: The total number of pending HTTP authorization requests for all msproxy instances.

**Panel**: Connections
**Description**: The total number of HTTP connections combined for all msproxy instances.

**Panel**: Connected Applications
**Description**: The total number of connected HTTP applications combined for all msproxy instances.

**Panel**: Connected Devices
**Description**: The total number of connected HTTP devices combined for all msproxy instances.

**Panel**: Connected Gateways
**Description**: The total number of connected HTTP gateways combined for all msproxy instances.

**Panel**: Connections Total
**Description**: The total number of HTTP connections combined for all msproxy instances.

**Panel**: Connections Total Rate (Connections/Sec)
**Description**: The HTTP connection rate in connections per second aggregated for all msproxy instances.

**Panel**: Client2Proxy Msgs Received
**Description**: The number of HTTP messages sent from clients to all msproxy instances.

**Panel**: Client2Proxy Msgs Received Rate (Msgs/Sec)
**Description**: The rate of HTTP messages per second sent from clients to all msproxy instances.

**Panel**: Proxy2Server Msgs Sent
**Description**: The number of HTTP messages sent to Message Gateway per msproxy instance.

**Panel**: Proxy2Server Msgs Sent Rate (Msgs/Sec)
**Description**: The rate of HTTP messages in messages per second to Message Gateway aggregated for all msproxy instances.

---

**Dashboard**: Msproxy - Usage Statistics - HTTP Message Sizes
**Description**: Provides an the usage statistics related to message sizes at the HTTP level for msproxy

**Panel**: Client 2 Proxy 512B Messages
**Description**: The number of new HTTP messages sent from clients with a payload size 512 bytes and less.

**Panel**: Client 2 Proxy 1KB Messages
**Description**: The number of new HTTP messages sent from clients with a payload size between 512 bytes and 1KB.

**Panel**: Client 2 Proxy 4KB Messages
**Description**: The number of new HTTP messages sent from clients with a payload size between 1KB and 4KB.

**Panel**: Client 2 Proxy 16KB Messages
**Description**: The number of new HTTP messages sent from clients with a payload size between 4KB and 16KB.

**Panel**: Client 2 Proxy 64KB Messages
**Description**: The number of new HTTP messages sent from clients with a payload size between 16KB and 64KB.

**Panel**: Client 2 Proxy Large Messages
**Description**: The number of new HTTP messages sent from clients with a payload size greater than 64KB.

**Panel**: Proxy 2 Server 512B Messages
**Description**: The number of new HTTP messages sent from a proxy instance to Message Gateway with a payload size 512 bytes and less.

**Panel**: Proxy 2 Server 1KB Messages
**Description**: The number of new HTTP messages sent from a proxy instance to Message Gateway with a payload size between 512 bytes and 1KB.

**Panel**: Proxy 2 Server 4KB Messages
**Description**: The number of new HTTP messages sent from a proxy instance to Message Gateway with a payload size between 1KB and 4KB.

**Panel**: Proxy 2 Server 16KB Messages
**Description**: The number of new HTTP messages sent from a proxy instance to Message Gateway with a payload size between 4KB and 16KB.

**Panel**: Proxy 2 Server 64KB Messages
**Description**: The number of new HTTP messages sent from a proxy instance to Message Gateway with a payload size between 16KB and 64KB.

**Panel**: Proxy 2 Server Large Messages**Description**:
**Description**: The number of new HTTP messages sent from a proxy instance to Message Gateway with a payload size greater than 64KB.