
### DataStore Connectors (DSC)

---

**Dashboard**: DSC - HistConnector
**Description**: Provides metrics on the Historian Connectors in IoT.

**Panel**: Message Rates
**Description**: Shows the rate of the events that the connectors are handling for each state.
**Legend**:

- events received: rate of events received by the historian connector
- events accepted: rate of events that match a forwarding rule
- events submitted: rate of events that match a forwarding rule and have been submitted to the downstream destination
- events forwarded: rate of events that match a forwarding rule and have been succesfully forwarded to the downstream destination
- events failed: rate of events that match a forwarding rule but have failed to be sent to the downstream destination
- events dropped: rate of events that match a forwarding rule but have been dropped from IoT and not sent to the downstream destination. Events are dropped when the because of destination buffering limits have been reached for an organization.

**Panel**: EventStreams ack latency
**Description**: The min, max and avg for the latency between the historian connector submitting an event to the eventstreams destination and the eventstreams destination acknowledging it

**Panel**: EventStreams e2e latency (proxy->ack)
**Description**: The min, max and avg for the latency between the historian connector receiving the event from the mfgx msproxy (via the kafka instance) and the eventstreams destination acknowledging the event

**Panel**: DB2 batch insert latency
**Description**: The min, max and avg for the latency between the historian connector submitting an event to the DB2 destination and the DB2 destination acknowledging it

**Panel**: DB2 e2e latency (evt source timestamp->inserted)
**Description**: The min, max and avg for the latency between the historian connector receiving the event from the mfgx msproxy (via the kafka instance) and the DB2 destination acknowledging the event

**Panel**: Message Counts
**Description**: The total number of events

**Panel**: Consumer Event Queue Bytes
**Description**: Number of bytes in the event queue that have not been processed yet. These are events that might or might not match a forwarding rule. An increase here might indicate a problem with processing events.

**Panel**: Bytes Buffered
**Description**: Number of bytes buffered currently in the historian connector that are ready to be forwarded to a destination after being processed by the event router. An increase here might indicate a problem with forwarding events to a destination.

**Panel**: Events Buffered
**Description**: Number of events buffered currently in the historian connector that are ready to be forwarded to a destination after being processed by the event router. An increase here might indicate a problem with forwarding events to a destination.

**Panel**: Accepted events distribution
**Description**: The currently distribution of events being accepted by each historian connector.

**Panel**: Active Instances
**Description**: Current number of dsc historian connector pods running in the IoT namespace.

**Panel**: Forwarded events rate
**Description**: The current rate of forwarded events for each historian connector instance. These are events that have matched a forwarding rule.

**Panel**: Partition Assignments
**Description**: The number of kafka partitions that each historian connector is currently assigned. Each connector should have an equal number of partitions.