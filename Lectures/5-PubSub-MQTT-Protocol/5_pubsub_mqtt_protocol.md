<!-- omit in toc -->
# Lecture 4 - Pub/Sub Introduction & MQTT Protocol

<!-- omit in toc -->
## Lecture Information

| **Master's Degree** | Digital Automation Engineering (D.M.270/04)                                      |
|---------------------|----------------------------------------------------------------------------------|
| **Curriculum**      | Digital Infrastructure                                                           |
| **Course**          | Distributed IoT Software Architectures                                           |
| **Lecture Title**   | Pub/Sub Introduction & MQTT Protocol                                             |
| **Author**          | Prof. Marco Picone (marco.picone@unimore.it)                                     |
| **License**         | [Creative Commons Attribution 4.0](https://creativecommons.org/licenses/by/4.0/) | 


<!-- omit in toc -->
# Table of Contents

- [5.1 Publish/Subscribe (Pub/Sub) Messaging Pattern](#51-publishsubscribe-pubsub-messaging-pattern)
- [5.2 Pub/Sub Protocols Idea \& Brokers/Queues Concepts](#52-pubsub-protocols-idea--brokersqueues-concepts)
- [5.3 Pub/Sub Additional Requirements 1/2](#53-pubsub-additional-requirements-12)
- [5.4 Pub/Sub Additional Requirements 2/2](#54-pubsub-additional-requirements-22)
- [5.5 Pub/Sub Benefits \& Drawbacks](#55-pubsub-benefits--drawbacks)
- [5.6 (Some) Pub/Sub Protocols Examples](#56-some-pubsub-protocols-examples)
  - [5.6.1 ZeroMQ](#561-zeromq)
  - [5.6.2 DDS](#562-dds)
  - [5.6.3 Kafka](#563-kafka)
  - [5.6.4 MQTT \& AMQP (Brief Overview)](#564-mqtt--amqp-brief-overview)
- [5.7 The MQTT Protocol](#57-the-mqtt-protocol)
  - [5.7.1 Single Level Topic Wildcard](#571-single-level-topic-wildcard)
  - [5.7.2 Multi Level Topic Wildcard](#572-multi-level-topic-wildcard)
  - [5.7.3 Quality of Service (QoS) Concepts \& Levels](#573-quality-of-service-qos-concepts--levels)
- [References](#references)
  
# 5.1 Publish/Subscribe (Pub/Sub) Messaging Pattern

A **publish/subscribe (pub/sub) system** is a type of **Message-oriented Middleware (MoM)** designed to enable **distributed**, **asynchronous**, and **loosely coupled** communication between **message producers** (publishers) and **message consumers** (subscribers).

**Key Decoupling Features of Pub/Sub Middleware:**

- **Time Decoupling**:  
  - Publishers and subscribers do **not need to be connected simultaneously**.  
  - **Example:** An IoT sensor can publish temperature data even if the monitoring dashboard is offline; the dashboard will receive the data when it reconnects.

- **Space Decoupling**:  
  - Messages are sent to a **symbolic address** (such as a **channel** or **topic**) rather than to specific consumers.  
  - **Example:** Multiple smart thermostats publish to the topic `/home/temperature`, and any device subscribed to this topic receives updates, regardless of the publisher's identity.

- **Synchronization Decoupling**:  
  - Communication is **asynchronous** and **non-blocking**; publishers do not wait for subscribers to process messages.  
  - **Example:** An IoT device can quickly send alerts to a topic without waiting for confirmation from all subscribers.

**Core Building Block: Publisher-Subscriber Matching**

- **Matching** is performed by **message brokers**, which route messages from publishers to subscribers based on filtering rules.
- **Filtering Types**:
  - **Topic-based filtering**: Subscribers receive messages published to specific topics (e.g., `/iot/devices/alerts`).
  - **Content-based filtering**: Subscribers receive messages that match certain content criteria (e.g., only alerts with severity `high`). This requires more complex processing by the broker and it is not widely used in IoT scenarios and/or available in all pub/sub systems and protocols.

> **In IoT deployments**, pub/sub systems are ideal for handling large numbers of devices and dynamic communication patterns, such as sensors publishing data and applications subscribing to relevant updates.

---

# 5.2 Pub/Sub Protocols Idea & Brokers/Queues Concepts

![](images/pubsub_idea_broker_queue.png)

**Figure 5.1:** Schematic comparison between Pub/Sub idea and Broker/Queue concepts.

A **trending communication approach** for the Internet of Things (IoT) and many modern applications is the **Publish/Subscribe (Pub/Sub) pattern**.

**Core Concepts of Pub/Sub Architectures:**

- **Entities:**
  - **Publishers**: Generate and send information (messages).
    - *Example*: An IoT temperature sensor publishing readings.
  - **Subscribers**: Register to receive information, often filtered by specific interests or policies.
    - *Example*: A smart thermostat subscribing to temperature updates.

- **Message Dispatching:**
  - Messages are delivered to subscribers based on their **“class”** or **interest** (e.g., topic or content).
  - *Example*: Devices subscribing to the topic `/home/alerts` receive only alert messages.

- **Broker:**
  - **Definition**: A **broker** is an intermediary that manages message distribution between publishers and subscribers.
  - A **broker** acts as an intermediary, responsible for **dispatching messages**:
    - **Publishers** post messages to the broker.
    - **Subscribers** register their interests with the broker.
    - The broker **matches messages** to subscribers’ interests and forwards relevant messages.
      - *Example*: In an IoT home automation system, the broker sends motion sensor alerts only to devices subscribed to motion events.

> **Summary:**  
> The Pub/Sub pattern enables **scalable**, **flexible**, and **loosely coupled** communication in IoT systems, allowing devices to efficiently share and receive information without direct connections.

---

# 5.3 Pub/Sub Additional Requirements 1/2

Furthermore, pub/sub systems should address additional requirements that typically characterize those class of protocols and systems and that are particularly relevant in the IoT domain:

**Filtering:**  
- Interested parties typically want to receive **only relevant information**, not all published messages.
- The **filtering capabilities** of the middleware determine how expressive and selective subscriptions can be.
- **Topic-based filtering:**  
  - Suitable for basic subscriptions to specific sensors or device types.
  - *Example:* Subscribing to `/iot/weather/neighborhood1` to receive weather data only from sensors in a particular area.
- **Hierarchical topic structure:**  
  - Enables monitoring groups of related resources.
  - *Example:* Subscribing to `/iot/home/temperature` to receive temperature updates from all sensors in a smart home.
- **Content-based filtering:**  
  - Allows subscriptions based on message content or specific events.
  - *Example:* Receiving alerts only when a sensor reading exceeds a threshold, such as temperature > 30°C.
  - Requires more advanced processing, sometimes involving **complex event processing**. This is not widely used in IoT scenarios and/or available in all pub/sub systems and protocols.

**Quality of Service (QoS) Semantics:**  

- Some applications can tolerate **loss of data messages**, while others require **guaranteed delivery**.
- The middleware should support **annotating subscriptions and messages** with QoS requirements.
  - *Example:* Critical alerts from fire sensors may require guaranteed delivery, while periodic temperature readings may tolerate occasional loss.
- For devices with **low sampling rates**, the system should provide subscribers with the **latest available value** while waiting for the next update.
  - *Example:* A dashboard displays the most recent humidity reading until a new value is published.

---

# 5.4 Pub/Sub Additional Requirements 2/2

**Topology:**  
Pub/sub systems can be deployed using different topologies, depending on application requirements and target architecture:

- **Centralized Topology:**  
  - A single logical **broker** manages message forwarding and filtering.  
  - The broker itself may be distributed across multiple physical or virtual machines for scalability and reliability.  
  - *Example (IoT):* All smart home devices publish sensor data to a central broker, which forwards relevant updates to subscribed dashboards or apps.

- **Distributed Topology:**  
  - **Producers** and **consumers** communicate directly, reducing the load on a central broker.  
  - This approach requires mechanisms for **resource discovery** so devices can find each other.  
  - *Example (IoT):* Environmental sensors in a factory directly send alerts to nearby actuators without passing through a central broker.

- **Hybrid Topology:**  
  - Devices use a central broker for **subscription management** and **message routing**, but the actual **payload** is transferred directly between endpoints.  
  - *Example (IoT):* A broker notifies a device of a new firmware update, and the device downloads the update directly from the source.

**Message Format:**  
Pub/sub solutions must be flexible to handle the diversity of connected devices and data types:

- **Payload Agnostic:**  
  - The system should make **no assumptions** about the format of the message payload, supporting both structured and unstructured data.
- **Binary Payload Support:**  
  - Support for **binary data** enables efficient serialization using frameworks like **Protocol Buffers** or **CBOR** (Concise Binary Object Representation).
  - *Example (IoT):* A camera sensor publishes compressed image data as a binary payload, which is processed by subscribers without format restrictions.

**Note:** Some pub/sub systems may also support **semantic annotations** to enhance interoperability and enable advanced filtering based on the meaning of the data and/or can use header fields to associate and describe the specific payload format (e.g., JSON, XML, CBOR, etc.) used in the message body in order to allow the subscribers to correctly interpret the payload.

> **Summary:**  
> Flexible topologies and payload-agnostic message formats are essential for scalable, interoperable pub/sub systems in IoT environments.

---

# 5.5 Pub/Sub Benefits & Drawbacks

**Advantages of the Pub/Sub Model**

- **Loose Coupling:**  
  - Publishers do **not need to know** which subscribers receive their messages, or even if any subscribers exist.  
  - *Example (IoT):* A temperature sensor publishes readings to a topic; any dashboard or app subscribed to that topic receives updates automatically.
- **Scalability:**  
  - **Brokers** can be **replicated** or distributed to handle large volumes of data and many devices.  
  - *Example (IoT):* A smart city deployment with thousands of sensors can scale by adding more brokers to route messages efficiently.
- **Flexibility:**  
  - New devices or applications can **join or leave** the system without disrupting existing communication.  
  - *Example (IoT):* Adding a new air quality sensor to a building only requires subscribing to the relevant topic.

**Main Disadvantages and Challenges of the Pub/Sub Model**

- **No Content-Type Negotiation:**  
  - Any change in the **message format** directly impacts all receivers, requiring coordinated updates.  
  - *Example (IoT):* Switching from JSON to binary payloads means all dashboards and apps must update their parsers.
- **Difficult Long-Term Evolution:**  
  - Evolving the system over time can be challenging, especially as the number of devices and message types grows.
- **Managing Heterogeneous Semantics:**  
  - Complex, open systems with **diverse data formats and meanings** are hard to manage and integrate.  
  - *Example (IoT):* Different sensors may use different units or formats for temperature, complicating data aggregation.
- **End-to-End Security Limitations (Centralized Approach):**  
  - In centralized pub/sub systems, the **broker sits between publishers and subscribers**, making true end-to-end security difficult to achieve.  
  - *Example (IoT):* Sensitive health data published by a wearable device may be exposed at the broker unless additional security measures are implemented.
- **Debugging and Monitoring Complexity:**  
  - Asynchronous and decoupled communication can make it harder to trace message flows and diagnose issues as for other distributed systems.

**Note:** Nevertheless, the **advantages** of the pub/sub model often outweigh its disadvantages, especially in **dynamic**, **large-scale IoT deployments** where flexibility and scalability are crucial combined with a **decoupled architecture**.

---

# 5.6 (Some) Pub/Sub Protocols Examples

![](images/pub_sub_protocols_examples.jpg)

**Figure 5.2:** Some Pub/Sub Protocols Examples.

In this section, we provide a brief overview of some popular Pub/Sub protocols used in IoT and distributed systems. Each protocol has its own features, strengths, and use cases.

The following table summarizes the key characteristics of each protocol:

| Protocol | Message Type | Architecture | Transport Protocol | Payload Type | QoS Management | Load Balancing | Security | Authentication | Authorization | Standardization | Open Source |
|----------|--------------|--------------|-------------------|--------------|---------------|---------------|----------|----------------|--------------|-----------------|-------------|
| **MQTT** | Pub/Sub | Broker | TCP | Binary (user-defined) | At least once, At most once, Exactly once | Yes | TLS | SASL PLAIN | ACL | Yes (ISO/IEC 20922) | Yes |
| **AMQP** | Pub/Sub, Request/Reply, Point-to-Point | Broker | TCP | Binary (user-defined) | Exactly once | Yes | TLS | SASL (challenge-response) | ACL | Yes (ISO/IEC 19464) | Yes |
| **Kafka** | Pub/Sub | Broker | TCP | Binary (user-defined) | At least once, At most once, Exactly once | Yes | SSL | SASL PLAIN, Kerberos | ACL | - | Yes |
| **ZeroMQ** | Pub/Sub, Request/Reply | Brokerless, Point-to-Point | Multiple (TCP, IPC, etc.) | Binary (user-defined) | - | - | CurveZMQ over TCP | SASL full | - | - | Yes |
| **DDS** | Pub/Sub, Request/Reply | Distributed | UDP/IP (TCP/IP for specific cases) | Self-describing messages, DDS Data Types | Yes (durability, lifespan, reliability, deadlines, etc.) | Yes | TLS, DTLS, DDS Security | Yes | ACL | OMG | Open DDS |

> **Note:** The choice of a Pub/Sub protocol depends on the specific requirements of the application, including factors such as scalability, latency, security, and ease of integration with existing systems. A key consideration for the IoT domain is the **resource constraints** of devices, which may limit the use of more complex protocols and it is also related to energy consumption. In the IoT domain, multiple Pub/Sub protocols can be used depending on the specific use case, device capabilities, and network conditions and combined together in a multi-protocol architecture and/or integrated with other communication paradigms (e.g., RESTful APIs).

---

## 5.6.1 ZeroMQ

**ZeroMQ** is a lightweight, high-performance messaging library that enables distributed communication without requiring a mandatory broker. It is best described as a **framework** for building scalable and flexible messaging systems.

**Core Concepts and Features:**

- **Brokerless Architecture:**  
  - ZeroMQ does **not require a central broker**; communication can be direct (peer-to-peer) or brokered if needed.  
  - *Example (IoT):* Sensors in a smart factory can exchange data directly, reducing latency and central bottlenecks.

- **Flexible Communication Patterns:**  
  - Supports multiple patterns, including **Publish/Subscribe (Pub/Sub)** and **Request/Response**.  
  - Patterns can be **combined** to optimize for performance, reliability, or functionality.

- **Transport Protocols:**  
  - Works over various protocols such as **TCP** and **Unix Domain Sockets (IPC)**.  
  - *Example (IoT):* Devices on the same gateway may use IPC, while remote devices use TCP.

- **Generalized Sockets:**  
  - Messages are managed in **generalized sockets** above the transport layer, allowing for efficient message handling and queuing.

- **Small Footprint:**  
  - The stack is **minimal**, making ZeroMQ suitable for **embedded devices** and resource-constrained IoT nodes.

- **Peer Discovery:**  
  - All participants must **know each other’s endpoints** or use a central service for discovery (which can be distributed).

- **ZeroMQ Message Transport Protocol (ZMTP):**  
  - Handles communication between sockets, including a **handshake** for connection setup.
  - Supports **encryption** via **SASL** or **Kerberos** for secure messaging.

- **Message Framing:**  
  - Large payloads can be **split into multiple frames** if they exceed the maximum frame size.

**Example (IoT):**  
A network of environmental sensors uses ZeroMQ’s Pub/Sub pattern to broadcast air quality data to multiple monitoring dashboards. If a dashboard goes offline, it can reconnect and resume receiving updates without needing a central broker.

> **Summary:**  
> ZeroMQ offers a flexible, brokerless approach to messaging, making it ideal for dynamic IoT environments where direct, efficient, and secure communication is required.

---

## 5.6.2 DDS

**Data Distribution Service (DDS)** is a **data-centric publish/subscribe middleware** designed for **highly dynamic distributed systems** and **real-time applications**.

**Core Concepts and Features:**

- **Standardized by OMG:**  
  - DDS is an open standard maintained by the **Object Management Group (OMG)**, ensuring interoperability across vendors and platforms.

- **Data-Centric Architecture:**  
  - Data is published into a **DDS domain**.  
  - **Subscribers** can receive data from the domain **without knowing the source or internal structure**, as DDS uses **self-describing information packages**.
  - *Example (IoT):* Multiple sensors in a smart factory publish machine status updates; monitoring dashboards subscribe to relevant data types without needing to know each sensor’s details.

- **Optimized for Distributed Processing:**  
  - DDS enables **direct communication** between sensors, devices, and applications, **removing dependence on centralized IT infrastructure**.
  - *Example (IoT):* Autonomous vehicles exchange position and speed data directly for collision avoidance, without routing through a central server.

- **Rich Quality of Service (QoS) Parameters:**  
  - DDS supports an extensive set of **QoS policies**, including:
    - **Durability:** Retain data for late-joining subscribers.
    - **Lifespan:** Control how long data remains available.
    - **Presentation:** Manage data ordering and grouping.
    - **Reliability:** Ensure guaranteed delivery or best-effort.
    - **Deadlines:** Specify timing constraints for data delivery.
  - *Example (IoT):* Critical alerts from fire sensors use high reliability and durability, while periodic temperature readings may use best-effort delivery.

- **Dynamic Discovery:**  
  - Devices and applications can **discover each other automatically** within the DDS domain, **without a central broker or registry**.
  - *Example (IoT):* New sensors added to a building network are automatically detected and integrated into existing monitoring systems.

> **Summary:**  
> DDS is ideal for **large-scale, real-time IoT deployments** requiring **high reliability**, **dynamic discovery**, and **fine-grained control** over data delivery and quality of service. **The drawback is that it can be more complex to implement and manage compared to simpler pub/sub protocols like MQTT.**

---

## 5.6.3 Kafka

![](images/kafka.jpg)

**Figure 5.3:** Simple and Schematic representation of Kafka Architecture.

**Apache Kafka** is an **open source distributed messaging system** developed by the Apache Software Foundation. Kafka is designed around the **Publish/Subscribe (Pub/Sub) pattern** and is widely used for building scalable, high-throughput data pipelines.

**Core Concepts and Features:**

- **Broker-Based Architecture:**  
  - Kafka uses a **broker** to manage message distribution.  
  - The broker is **highly scalable** and runs on distributed systems, leveraging **Apache Zookeeper** for clustering and coordination.

- **Topic Partitioning and Replication:**  
  - Each **topic** is divided into **partitions**, which are **replicated** across multiple broker instances.  
  - This enables **high availability**, **parallelization**, and **increased throughput**.  
  - *Example (IoT):* Sensor data from thousands of devices can be published to different partitions, allowing real-time processing and analytics.

- **Persistent Storage:**  
  - Kafka **persists every message** to the local disk using a **log-based storage** model.  
  - Each partition is stored in multiple log files with fixed sizes.  
  - Messages can be **retained indefinitely**, regardless of whether they have been consumed.  
  - *Example (IoT):* Historical temperature readings from smart thermostats can be replayed for trend analysis or machine learning.

- **Consumer Offset Management:**  
  - Each **consumer** maintains its own **offset**, which tracks the position in the partition log.  
  - Consumers can **re-read historical data** or resume from where they left off after a disconnect.  
  - *Example (IoT):* A dashboard application can recover and process missed sensor events after downtime.

- **Security and Reliability:**  
  - Kafka supports **secure messaging** with features like **SSL encryption**, **SASL authentication**, and **access control lists (ACLs)**.  
  - It is **widely adopted** in industry for reliable, scalable messaging.

> **Summary:**  
> Kafka is ideal for **large-scale IoT deployments** requiring **high throughput**, **durable storage**, and **flexible data consumption**. Its partitioned, persistent architecture makes it suitable for scenarios where historical data replay and robust scalability are essential. It can be integrated with other systems for real-time analytics and processing and with other lower-level protocols (e.g., MQTT) for device communication while leveraging Kafka for backend data processing and storage.

---

## 5.6.4 MQTT & AMQP (Brief Overview)

In this section, we provide a brief overview of two widely used Pub/Sub protocols: **MQTT (Message Queue Telemetry Transport)** and **AMQP (Advanced Message Queueing Protocol)**. Both protocols are designed to facilitate efficient and reliable communication in distributed systems, particularly in the context of the Internet of Things (IoT). **These two protocols will be covered in more detail in the next sections.**

**MQTT (Message Queue Telemetry Transport)**

- **Open-source**, **lightweight**, and **TCP-based** protocol designed for **resource-constrained devices** and **low-bandwidth networks**.
- Supports **hierarchical topics** for organizing messages and subscriptions.
- **Standardized by OASIS** and **endorsed by the Eclipse Foundation**.
- **Publishers** send messages to **topics**; **subscribers** receive messages from topics they are interested in.
- **Quality of Service (QoS) levels** allow for flexible message delivery guarantees:
  - *At most once*, *at least once*, *exactly once*.
- **Example (IoT):**  
  - A temperature sensor publishes readings to the topic `/home/temperature`; smart thermostats subscribe to this topic to receive updates.
- More info: [mqtt.org](http://mqtt.org)

**AMQP (Advanced Message Queueing Protocol)**

- **Open standard** for **message-oriented middleware** supporting **topics**, **queues** (for message storage), and **exchanges** (for message routing).
- Enables **reliable**, **interoperable**, and **flexible messaging** between distributed applications.
- **Exchanges** route messages to **queues** based on rules, allowing for complex routing scenarios.
- **Implementations:**  
  - **RabbitMQ**, **Apache ActiveMQ**, among others.
- **Example (IoT):**  
  - Environmental sensors publish alerts to an exchange; the exchange routes messages to queues for different monitoring applications (e.g., `/alerts/fire`, `/alerts/flood`).
- More info: [amqp.org](https://www.amqp.org)

---

# 5.7 The MQTT Protocol

![](images/mqtt_topic_broker_example.png)

**Figure 5.4:** An example of MQTT topic and broker architecture with topic subscriptions.

**Message Queue Telemetry Transport (MQTT)** is a **lightweight**, **open-source**, and **TCP-based** **publish/subscribe (Pub/Sub) protocol** designed for environments with **resource-constrained devices** and **low-bandwidth networks**.

**Key Features and Concepts:**

- **Standardization:**  
  - MQTT is a standard of the **Organization for the Advancement of Structured Information Standards (OASIS)**.

- **Efficiency:**  
  - Optimized for scenarios where **protocol overhead** and **message size** must be minimal.
  - *Example (IoT):* Battery-powered sensors in remote locations use MQTT to send data efficiently without draining resources.

- **Topic-Based Messaging:**  
  - **Messages are published to topics** within a broker.
  - **Topics act as filters** for the message stream, organizing data by subject or device type.
  - *Example (IoT):* A temperature sensor publishes readings to `/home/livingroom/temperature`; multiple devices can subscribe to this topic.

- **Subscription and Filtering:**  
  - **Clients subscribe to topics** using **topic filters**.
  - A single client can receive messages from **multiple publishers** if they publish to the same topic.
  - **Hierarchical topic structure** allows clients to subscribe to specific segments of the topic tree.
  - *Example (IoT):* Subscribing to `/home/+/temperature` receives temperature updates from all rooms in a smart home.

- **Wildcard Support:**  
  - MQTT supports **wildcards** in topic filters for flexible and granular subscriptions:
    - `+` (single-level wildcard): Matches one segment in the topic path.
    - `#` (multi-level wildcard): Matches all remaining segments.
  - *Example (IoT):* Subscribing to `/home/#` receives all messages from any device in the home.

**Summary:**  
MQTT’s lightweight design, topic-based filtering, and support for wildcards make it ideal for **IoT applications** where devices need to communicate efficiently and flexibly in dynamic, constrained environments.

---

## 5.7.1 Single Level Topic Wildcard

The **single-level wildcard** in MQTT, represented by the `+` symbol, allows subscribers to match exactly **one topic level** in the hierarchy. This enables flexible subscriptions to multiple topics that share a common structure.

**Key Concepts:**

- The `+` wildcard **replaces one topic segment** in a subscription filter.
- It matches **any string** at that specific level, but **only one level**.
- Multiple `+` wildcards can be used in a topic filter to match multiple levels.

**Examples (IoT):**

- Subscribing to `myhome/groundfloor/+/temperature` 
- It does **MATCH**:
  - `myhome/groundfloor/livingroom/temperature`
  - `myhome/groundfloor/kitchen/temperature`
- It does **NOT** match:
  - `myhome/groundfloor/kitchen/fridge/temperature` (extra level)
  - `myhome/firstfloor/kitchen/temperature` (different second level)

**Summary:**

The single-level wildcard is ideal for **grouping devices or data types** at a specific hierarchy level, making it easier to manage subscriptions in dynamic IoT environments. 

---

## 5.7.2 Multi Level Topic Wildcard

The **multi-level wildcard** in MQTT, represented by the `#` symbol, enables subscribers to match **all topic levels** from a specific point in the hierarchy. This provides a powerful way to receive messages from a broad set of topics with a single subscription.

**Core Concepts:**

- The `#` wildcard **matches any number of topic levels**, including zero. With zero we mean that it can match the parent level only (e.g., `home/#` matches `home/`).
- It must be the **last character** in the topic filter and **preceded by a forward slash** (e.g., `home/#`).
- A subscription using `#` will receive **all messages** that start with the pattern before the wildcard, regardless of how many levels follow.

**Key Points:**

- **Flexible Subscriptions:**  
  - Ideal for monitoring all devices or events under a common topic prefix.
- **Simple Hierarchy Coverage:**  
  - Useful for aggregating data from multiple sources without specifying each topic individually.

**Examples (IoT):**

- Subscribing to `myhome/groundfloor/#` **MATCHES**:
  - `myhome/groundfloor/livingroom/temperature`
  - `myhome/groundfloor/kitchen/temperature`
  - `myhome/groundfloor/kitchen/brightness`
- It does **NOT** match:
  - `myhome/firstfloor/kitchen/temperature` (different first level)

**Summary:**

The multi-level wildcard is especially useful in **IoT scenarios** where you want to **monitor all events or sensor data** under a specific location or device group, simplifying subscription management and enabling scalable data collection.

---

## 5.7.3 Quality of Service (QoS) Concepts & Levels

**Quality of Service (QoS)** in MQTT defines the **delivery guarantee** for each message exchanged between clients and brokers. It is a crucial feature that allows clients to select the reliability level that best fits their **network conditions** and **application requirements**.

**Note:**The MQTT QoS levels and implementation work on top of the underlying **TCP/IP** transport protocol, which already provides a reliable connection. However, MQTT's QoS levels add an additional layer of control over message delivery semantics.

**Core Concepts:**

- **QoS Agreement:**  
  - The QoS level is an **agreement** between the **sender** and **receiver** about how reliably a message should be delivered.
  
- **Dual Path Consideration:**  
  - QoS applies to both:
    - **Publisher → Broker:** The publisher sets the QoS level when sending a message to the broker.
    - **Broker → Subscriber:** The subscriber sets the QoS level during subscription; the broker delivers messages using the **lower** of the publisher’s and subscriber’s QoS levels.

![](images/pubsub_dual_path.png)

**Figure 5.5:** A dual path representation of MQTT message flow with QoS levels taking into account both publisher and subscriber QoS levels.

**MQTT QoS Levels:**

1. **QoS 0 – At most once:**  
   - **No guarantee** of delivery; messages are delivered **once or not at all**.
   - **No acknowledgment** required.
   - **Example (IoT):**  
     - A temperature sensor sends periodic readings; occasional data loss is acceptable.

2. **QoS 1 – At least once:**  
   - **Guaranteed delivery**; messages are delivered **one or more times** (possible duplicates).
   - **Acknowledgment** required from the receiver.
   - **Example (IoT):**  
     - A smart door lock sends status updates; it’s important that the message arrives, even if duplicated.

3. **QoS 2 – Exactly once:**  
   - **Highest reliability**; messages are delivered **exactly once** (no duplicates).
   - Uses a **two-phase handshake** for confirmation.
   - **Example (IoT):**  
     - A payment terminal sends transaction data; duplicate or lost messages must be avoided.

**Key Points:**

- **QoS Selection:**  
  - Clients can choose the QoS level based on **network reliability** and **application logic**.
  - **Lower QoS** may be used for non-critical data to save bandwidth and reduce latency.
  - **Higher QoS** is preferred for critical operations where data loss or duplication is unacceptable.

- **Automatic Retransmission:**  
  - MQTT handles **retransmission** and **delivery guarantees** even if the underlying network is unreliable.

> **Summary:**  
> QoS in MQTT enables flexible, reliable communication in IoT environments, allowing devices to balance performance and reliability according to their needs.


# References

- Desai, Pratikkumar & Sheth, Amit & Anantharam, Pramod. (2014). Semantic Gateway as a Service Architecture for IoT Interoperability. 10.1109/MobServ.2015.51. [Link](https://doi.org/10.1109/MobServ.2015.51)
- REST Maturity Model - [Link](http://martinfowler.com/articles/richardsonMaturityModel.html)
- Jim Webber, Savas Parastatidis, Ian Robinson, “REST in Practice,” O'Reilly Media, September 2010 [Link](http://shop.oreilly.com/product/9780596805838.do)
- RFC5988 - [Link](https://tools.ietf.org/html/rfc5988)
- Web to Edge - [Link](https://www.w3.org/WoT/IG/wiki/images/d/de/WebToTheEdge-WoT.pdf)
- R. T. Fielding, “Architectural Styles and the Design of Network-based Software Architectures,” PhD thesis, University of California, 2000. Available: [Link](https://ics.uci.edu/~fielding/pubs/dissertation/top.htm)
- Roy T. Fielding and Richard N. Taylor. 2002. Principled design of the modern Web architecture. ACM Trans. Internet Technol. 2, 2 (May 2002), 115–150. https://doi.org/10.1145/514183.514185 [Link](https://dl.acm.org/doi/10.1145/514183.514185)
