<!-- omit in toc -->
# Lecture 3 - The HTTP Protocol

<!-- omit in toc -->
## Lecture Information

| **Master's Degree** | Digital Automation Engineering (D.M.270/04)                                      |
|---------------------|----------------------------------------------------------------------------------|
| **Curriculum**      | Digital Infrastructure                                                           |
| **Lecture Title**   | The HTTP Protocol                                                                |
| **Author**          | Prof. Marco Picone (marco.picone@unimore.it)                                     |
| **License**         | [Creative Commons Attribution 4.0](https://creativecommons.org/licenses/by/4.0/) | 


<!-- omit in toc -->
# Table of Contents

- [3.1 Traditional Internet Protocol Stack (Overview)](#31-traditional-internet-protocol-stack-overview)
- [3.2 IoT Protocol Stack (Overview)](#32-iot-protocol-stack-overview)
- [3.3 Simple Comparison Between Traditional Internet Protocol Stack and IoT Protocol Stack](#33-simple-comparison-between-traditional-internet-protocol-stack-and-iot-protocol-stack)
- [3.4 IoT Application Layer Protocols](#34-iot-application-layer-protocols)
- [3.5 Main Protocols Interaction Models](#35-main-protocols-interaction-models)
- [3.6 Protocols Objectives - Towards Standardization and Interoperability](#36-protocols-objectives---towards-standardization-and-interoperability)
- [3.7 Using a Web-Based Approach for the Internet of Things](#37-using-a-web-based-approach-for-the-internet-of-things)
- [3.8 The HTTP Protocol](#38-the-http-protocol)
  - [3.8.1 The Structure of an HTTP Message - The Request Message - GET](#381-the-structure-of-an-http-message---the-request-message---get)
  - [3.8.2 The Structure of an HTTP Message - The Response Message - GET](#382-the-structure-of-an-http-message---the-response-message---get)
  - [3.8.3 The Structure of an HTTP Message - The Request Message - POST](#383-the-structure-of-an-http-message---the-request-message---post)
  - [3.8.4 The Structure of an HTTP Message - The Response Message - POST](#384-the-structure-of-an-http-message---the-response-message---post)
  - [3.9 The Web as a Platform](#39-the-web-as-a-platform)
- [3.10 REpresentational State Transfer (REST) Architectural Style](#310-representational-state-transfer-rest-architectural-style)
  - [3.10 REpresentational State Transfer (REST) Architectural Style](#310-representational-state-transfer-rest-architectural-style-1)
  - [3.10.1 The concept of Resource in REST](#3101-the-concept-of-resource-in-rest)
  - [3.10.2 Differences with Other Architectural Styles](#3102-differences-with-other-architectural-styles)
  - [3.10.3 A Simple Comparison Between REST and SOAP](#3103-a-simple-comparison-between-rest-and-soap)
  - [3.10.4 The Client Perspective REST vs. SOAP](#3104-the-client-perspective-rest-vs-soap)
  - [3.10.5 REST Main Characteristics](#3105-rest-main-characteristics)
  - [3.10.6 REST \& Resource Representation](#3106-rest--resource-representation)
  
# 3.1 Traditional Internet Protocol Stack (Overview)

![](images/traditional_protocol_stack_communication.png)

**Figure 3.1:** Traditional Internet Protocol Stack (Overview) with the different layers and their main protocols.

The **traditional protocol stack** is fundamental for modeling and understanding how digital communications work. By organizing network functions into **hierarchical layers**, each with specific responsibilities, the stack enables modular design and interoperability. The most common models are the **OSI** and **TCP/IP** stacks, which structure communication from the physical transmission of bits up to user-facing applications.

**OSI vs. TCP/IP: Quick Differences and Similarities**

- **OSI Model** has 7 layers (Physical, Data Link, Network, Transport, Session, Presentation, Application).
- **TCP/IP Model** has 4 layers (Link, Internet, Transport, Application).
- OSI separates presentation and session functions; TCP/IP combines them into the application layer.
- OSI is a theoretical reference model; TCP/IP is based on real-world protocols.
- Both models use layered architecture to promote modularity and interoperability.
- Each layer in both models serves specific functions and communicates with adjacent layers.
- Both models guide protocol design and troubleshooting in network engineering.

**Protocol Stack Layer Overview**

Each layer in the protocol stack abstracts and manages a distinct aspect of communication, relying on adjacent layers for data exchange. This layered modeling simplifies development, troubleshooting, and protocol evolution. In this overview, we focus on a simplified 5-layer model that captures the essential functions of both OSI and TCP/IP stacks:


| **Layer**           | **Main Function**                                   | **Common Protocols**           |
|---------------------|-----------------------------------------------------|-------------------------------|
| **Physical**        | Transmission of raw bits over physical medium       | Ethernet (PHY), Wi-Fi (PHY)   |
| **Data Link**       | Framing, error detection/correction, MAC addressing | Ethernet, Wi-Fi (MAC), PPP    |
| **Network**         | Routing, addressing, packet forwarding              | IP (Internet Protocol), ICMP  |
| **Transport**       | Reliable delivery, sequencing, flow control         | TCP, UDP                      |
| **Application**     | End-user services and protocols                     | HTTP, HTTPS, SMTP, SSH        |


- **Physical Layer**: The base layer, responsible for the actual transmission of data as electrical signals, light pulses, or radio waves over cables, fiber optics, or wireless channels.
- **Data Link Layer**: Handles framing, error detection/correction, and local addressing (MAC). It ensures reliable communication within a local network segment.
- **Network Layer**: Manages logical addressing and routing, enabling data packets to traverse multiple interconnected networks. The **IP protocol** is central here.
- **Transport Layer**: Provides end-to-end communication, reliability, and flow control. **TCP** ensures ordered, reliable delivery; **UDP** offers faster, connectionless transmission.
- **Application Layer**: Hosts protocols for user-facing services, such as **HTTP** for web, **SMTP** for email, and **SSH** for secure remote access.

**Protocol and Communication Flow**

Data originates at the **application layer**, then is **encapsulated** as it passes down through the transport, network, and data link layers, each adding its own header (and sometimes trailer) information. This encapsulation process is called **packet encapsulation**. At the sender, each layer wraps the data from the layer above, forming a protocol data unit (PDU) for transmission. The physical layer then transmits the bits over the medium.

On the receiving side, the process is reversed: each layer removes its header/trailer, passing the remaining data up to the next layer until the original application data is reconstructed.

**Encapsulation Example:**

```
Application Data
  ↓
Transport Layer (adds TCP/UDP header)
  ↓
Network Layer (adds IP header)
  ↓
Data Link Layer (adds Ethernet/Wi-Fi frame)
  ↓
Physical Layer (transmits bits)
```

This **layered encapsulation** ensures modularity, interoperability, and reliable communication across diverse networks and devices.

# 3.2 IoT Protocol Stack (Overview)

![](images/iot_protocol_stack_communication.png)

**Figure 3.2:** IoT Protocol Stack (Overview) with the different layers and their main protocols.

The **IoT protocol stack** builds upon the **traditional networking model** but introduces specialized layers, protocols, and adaptations to address the unique requirements of **resource-constrained devices**, **heterogeneous networks**, and **intermittent connectivity**. Modeling the IoT stack involves understanding how each layer is tailored for efficiency, scalability, and interoperability, while still maintaining the modularity and abstraction principles of classic protocol stacks.
**Key Layers and Protocols in IoT Stack Modeling**

- **Physical and Data Link Layers**: IoT networks often use low-power wireless technologies such as **ZigBee**, **LoRa**, **NB-IoT**, and **Bluetooth Low Energy (BLE)**, chosen for their energy efficiency, range, and suitability for large-scale deployments. Standards like **IEEE 802.15.4** provide the foundation for these technologies, supporting minimal energy consumption and cost-effective connectivity for battery-powered devices.

- **Network Layer**: To accommodate massive numbers of devices, IoT stacks typically adopt **IPv6** for its large address space. Protocols like **6LoWPAN** enable efficient transmission of IPv6 packets over constrained links, ensuring seamless integration with global networks while maintaining scalability and efficiency.

- **Transport Layer**: IoT environments require a balance between reliability and efficiency. While **TCP** and **UDP** are still used, adaptations such as **DTLS** (for secure UDP communication) are common to address low-latency and lossy network conditions, ensuring robust communication in challenging scenarios.

- **Application Layer**: Protocols like **MQTT**, **CoAP**, and **LwM2M** are designed for lightweight, efficient messaging, minimizing overhead and supporting intermittent connectivity. These protocols prioritize simplicity, low power consumption, and reliability, making them well-suited for resource-constrained IoT devices compared to traditional, heavier protocols like **HTTP**.


> Modeling the IoT protocol stack involves selecting and adapting layers and protocols to optimize for energy efficiency, scalability, and interoperability, addressing the unique requirements of diverse IoT environments.

**Interoperability and Ecosystem Integration**

- The IoT stack emphasizes **interoperability**, enabling seamless integration across diverse devices, vendors, and networks. **Protocol gateways** (e.g., ZigBee-to-IP converters) and **multi-stack solutions** facilitate communication between different technologies.
- **Open standards** and **unified APIs** are promoted to avoid vendor lock-in and foster ecosystem growth, ensuring that devices using specialized IoT protocols can participate in broader Internet-connected applications.

---

# 3.3 Simple Comparison Between Traditional Internet Protocol Stack and IoT Protocol Stack

**Comparison: IoT Protocol Stack vs. Traditional Internet Protocol Stack**

| **Layer**           | **Traditional Stack**                                   | **IoT Stack**                                                                 |
|---------------------|--------------------------------------------------------|--------------------------------------------------------------------------------|
| **Physical**        | Ethernet, Wi-Fi                                        | ZigBee, LoRa, NB-IoT, BLE, Ethernet, Wi-Fi                                     |
| **Data Link**       | Ethernet (MAC), Wi-Fi (MAC), PPP                       | IEEE 802.15.4, ZigBee, Thread, BLE                                             |
| **Network**         | IPv4, IPv6, ICMP                                       | IPv6, 6LoWPAN, RPL                                                             |
| **Transport**       | TCP, UDP                                               | UDP, TCP, DTLS (secure UDP), lightweight adaptations                           |
| **Application**     | HTTP, HTTPS, SMTP, SSH                                 | MQTT, CoAP, LwM2M, lightweight REST, custom IoT protocols                      |
| **Modeling Focus**  | High throughput, reliability, modularity               | Low power, scalability, interoperability, efficiency, resource constraints     |

The **IoT protocol stack** is modeled to optimize for **energy efficiency**, **scalability**, and **interoperability**, using lightweight protocols and specialized layers. In contrast, the **traditional stack** prioritizes **high throughput** and **reliability** for general-purpose computing and communication. Understanding these differences is essential for designing robust IoT systems that can seamlessly integrate with existing Internet infrastructure.

---

# 3.4 IoT Application Layer Protocols

![](images/protocols_words.png)

**Figure 3.3:** Some application layer protocols.

The **application layer** in networking models (OSI Levels 5, 6, and 7; TCP/IP application layer) is the **topmost layer** that interfaces between **end devices**, the **network**, and **user applications**. It is implemented via dedicated software at the device level and is responsible for **data formatting**, **presentation**, and **protocol-specific communication**. In traditional Internet services, protocols such as **HTTP**, **HTTPS**, **SMTP**, and **FTP** operate at this layer, enabling web browsing, secure transactions, email, and file transfers.

When **modeling IoT systems**, the application layer plays a crucial role in defining how devices interact, exchange data, and integrate with broader networks. However, **traditional protocols** are often **unsuitable for IoT environments** due to their **heavyweight nature** and **high parsing overhead**. IoT devices are typically **resource-constrained**—with limited CPU, memory, and energy—making it essential to use **lightweight protocols** that minimize computational and transmission demands.

**Key modeling considerations for IoT application layer protocols:**

- **CPU Processing:** IoT devices have **limited computational capabilities**, making it difficult to process large or complex messages. **Reducing processing requirements** leads to **lower energy consumption** and longer device lifespans.
- **Data Transmission:** Large messages result in more **fragments**, increasing **overhead** and the likelihood of **retransmissions**—especially in **Low-power and Lossy Networks (LLNs)**. This can cause **higher delays** and further drain energy resources.
- **Efficiency and Scalability:** Lightweight protocols such as **MQTT**, **CoAP**, and **LwM2M** are specifically designed for IoT, focusing on **minimal overhead**, **efficient parsing**, and **robustness** in unreliable network conditions.

> In summary, modeling the application layer for IoT involves selecting protocols that optimize for **efficiency**, **scalability**, and **interoperability**, ensuring reliable communication while respecting the constraints of IoT devices and networks.

---

# 3.5 Main Protocols Interaction Models

![](images/pattern_quick_comparison.png)

**Figure 3.4:** Quick comparison of main protocols interaction models among Request/Response and Publish/Subscribe.

When modeling IoT systems, **protocols** are designed around specific **communication paradigms** such as **request/response** and **publish/subscribe**. Each paradigm introduces distinct **requirements** that influence the selection of the most suitable protocol and **architectural style** for a given scenario.

- The **request/response** paradigm is commonly used in **RESTful architectures**, where a client sends a request and the server responds with the required data. This model is straightforward and fits well for scenarios where devices need to **retrieve or update resources** on demand.
- The **publish/subscribe** paradigm enables **asynchronous communication**, allowing devices to **publish data** to topics and other devices to **subscribe** and receive updates automatically. This model is ideal for **event-driven** IoT applications, such as sensor networks and real-time monitoring.

**Modeling the communication architecture** involves analyzing the specific needs of your scenario—such as **latency**, **scalability**, **energy efficiency**, and **data flow patterns**—to determine which paradigm and protocol best fit. While there is no universal solution, the **IoT ecosystem** is predominantly built around the **REST architectural style** (mirroring the traditional Internet) and **publish/subscribe approaches** for flexibility and scalability.

> **Key takeaway:** Select the communication paradigm and protocol that align with your application's requirements, considering factors like device constraints, network reliability, and integration needs. Both **REST** and **Pub/Sub** are foundational to modern IoT system modeling.

> **Note:** There are several protocols belonging to both paradigms, but in this lecture, we will focus on **HTTP** (request/response) and **MQTT** (publish/subscribe) as representative examples.
> Additionally, we will briefly mention **CoAP**, which, despite being a request/response protocol, is specifically designed for constrained environments. 
> We will not cover **AMQP** and **DDS** in this lecture, but they are also important protocols in the IoT landscape.

---

# 3.6 Protocols Objectives - Towards Standardization and Interoperability

![](images/iot_protocols_interoperable_standard_objective.png)

**Figure 3.5:** The objective of IoT application layer protocols is to achieve standardization and interoperability.

When **modeling IoT systems**, protocols such as **MQTT**, **AMQP**, **CoAP**, and **HTTP** are chosen for their **wide adoption** and **design principles** that enable **cross-device** and **cross-vendor communication**.

- **Interoperability**: Adopting **standard protocols** ensures that devices from different manufacturers and domains can interact seamlessly, which is essential for building unified IoT solutions and ecosystems. This interoperability is a key modeling objective, as it allows diverse devices to exchange data reliably and efficiently.
- **Standard Usage**: Relying on **established, well-documented protocols** helps prevent fragmentation and vendor lock-in, supporting **large-scale deployments** and **future-proof integration**. Modeling with these protocols provides a stable foundation for expanding and maintaining IoT systems over time.

> The success of IoT modeling depends on selecting **standard, interoperable protocols** to build robust, scalable, and maintainable connected systems. The figure below illustrates that the primary goal of IoT application layer protocols is to achieve **standardization** and **interoperability**, laying the groundwork for the "**Web of Things**" where diverse devices and platforms can communicate easily and reliably.

---

# 3.7 Using a Web-Based Approach for the Internet of Things

When **modeling IoT systems**, adopting a **web-based approach** offers several advantages:

- The **web ecosystem** has matured over decades, providing a wealth of **experience** and **best practices** for designing scalable, interoperable systems.
- **HTTP** is the **dominant application-layer protocol**, ensuring broad compatibility and simplifying integration with existing Internet infrastructure.
- A wide range of **software libraries** and **tools** for web protocols (such as **web servers** and **HTTP clients**) are available for virtually **every programming language**, accelerating development and reducing implementation effort.
- Well-established **design patterns** for **web applications** enable developers to model IoT solutions efficiently, leveraging familiar architectures and workflows.
- The **web architecture** has demonstrated exceptional **scalability**, which is crucial for supporting **billions of connected IoT devices**.

> By modeling IoT systems using **web standards** and protocols, developers benefit from proven technologies, enhanced interoperability, and the ability to scale solutions to meet the demands of large, heterogeneous device networks.

---

# 3.8 The HTTP Protocol

The **Hyper Text Transfer Protocol (HTTP)** is a **client-server network protocol** that has been the foundation of the **World-Wide Web** since the early 1990s. In the context of **modeling networked systems**, HTTP is notable for its **request-response paradigm**, where a **client** sends a request and a **server** returns a response. This interaction model is straightforward and highly adaptable, making HTTP a reference protocol for designing interoperable systems.

HTTP is built on the principle that "**everything is an extendable convention**." This means you can define **custom headers** and even **custom methods** to suit specific application needs. However, implementations are not required to support every method or header, which can introduce **heterogeneity** if not managed carefully.

To **avoid heterogeneity** and ensure **standardization**, the **RESTful HTTP** approach is widely adopted as a modeling reference. By following **RESTful conventions**, developers can create systems that are **interoperable**, **scalable**, and easy to integrate with other web-based solutions. RESTful HTTP emphasizes the use of standard methods (such as **GET**, **POST**, **PUT**, **DELETE**) and headers, promoting consistency and reliability across diverse platforms and devices.

> In summary, when modeling IoT or web-based systems, HTTP provides a flexible yet standardized foundation. Adhering to RESTful principles helps maintain compatibility and supports the development of robust, maintainable architectures.

---

## 3.8.1 The Structure of an HTTP Message - The Request Message - GET

![](images/http_get_request.png)

**Figure 3.6:** The structure of an HTTP request message (GET in this example).

The **HTTP request message** is a fundamental element when **modeling client-server communication** in web and IoT systems. It represents how a **client** (such as a browser, mobile app, or IoT device) initiates interaction with a **server** to **retrieve**, **update**, or **manipulate resources**. In IoT architectures, HTTP is commonly used for **RESTful APIs**, enabling standardized and efficient management of device data and services. The HTTP request message initiates a communication from a client (such as a browser or IoT device) to a server, asking for a specific resource or instructing the server to perform an action. In the context of IoT, HTTP is often used for RESTful APIs to manage and retrieve device information and other resources efficiently.

**Main Structure and Fields**

The figure breaks down the request into distinct parts:

- **Method**: Indicates the action to be performed by the server, such as `GET`, `POST`, `PUT`, or `DELETE`. In this example, `GET` requests data from the specified resource.
- **Resource Path**: Specifies the endpoint or location of the resource, here `/api/inventory/devices`, which typically points to device inventory data in an IoT platform.
- **Version**: States the version of HTTP being used, such as `HTTP/1.1`, which signals to the server the protocol features available.
- **Header Fields**: Include metadata and supplementary information about the request, such as:
  - `Accept`: Defines acceptable response content types.
  - `Accept-Language`: Sets preferred language (e.g., `en-gb`).
  - `User-Agent`: Identifies the client making the request.
  - `Host`: Indicates the domain of the server.
  - `Connection`: Manages session persistence (e.g., `Keep-Alive`).
- **Body**: The request body transmits additional data with the request, typically used with methods like `POST` or `PUT`. In a `GET` request such as this, the body is empty.

**Summary of HTTP Request Fields**

| Field            | Description                                         | Example Value                     |
|------------------|-----------------------------------------------------|-----------------------------------|
| Method           | Request operation (action)                          | GET                               |
| Resource Path    | Target resource on server                           | /api/inventory/devices            |
| HTTP Version     | Protocol version used                               | HTTP/1.1                          |
| Accept           | Acceptable response content types                   | */*                               |
| Accept-Language  | Preferred language for response                     | en-gb                             |
| User-Agent       | Client identity                                     | Mozilla/4.0 (compatible; MSIE 6.0)|
| Host             | Server domain                                       | www.myiotplatform.com             |
| Connection       | Session control                                     | Keep-Alive                        |
| Body             | Additional data (usually empty in GET)              |                                   |

---

## 3.8.2 The Structure of an HTTP Message - The Response Message - GET

![](images/http_get_response.png)

**Figure 3.7:** The structure of an HTTP response message (GET in this example).

The **HTTP response message** is a crucial component in **modeling client-server interactions** within web and IoT systems. It represents how a **server** responds to a **client's request**, providing the requested data, status information, and additional context. In IoT architectures, HTTP responses are often used in **RESTful APIs** to deliver device data, confirm actions, or report errors.
The HTTP response provides the client with the outcome of its request, including status information, metadata, and the actual requested content. In IoT and web applications, this enables clients to process results—such as resource data, error diagnostics, or service confirmations—in a standardized way.

**Main Structure and Fields**

The figure divides the response into these distinct elements:

- **Status Line & Status Code**: This line communicates the protocol version (`HTTP/1.0`), a numeric status code (`200`), and a brief message (`OK`). For example, `200 OK` means the request succeeded.
- **Headers**: These contain metadata about the response, such as:
  - `Content-Type`: Specifies the data format of the response body (e.g., `application/json; charset=utf-8`).
  - `Content-Length`: States the size of the response body in bytes.
  - `Server`: Identifies the software handling the response.
  - `Date`: Provides the timestamp when the response was issued.
- **Double CRLF (Return Line)**: This empty line marks the end of headers and the start of the content body.
- **Content Body**: Contains the actual data returned by the server for the request (here, a JSON object with a `location_info` field).

**Summary Table: HTTP Response Fields**

| Field Type           | Description                                           | Example Value                               |
|----------------------|-------------------------------------------------------|---------------------------------------------|
| Status Line          | Protocol version, status code, textual message        | HTTP/1.0 200 OK                             |
| Content-Type         | Format and encoding of returned content               | application/json; charset=utf-8             |
| Content-Length       | Size of response content body                         | 610                                         |
| Server               | Server software/version info                          | Werkzeug/1.0.1 Python/3.8.5                 |
| Date                 | Timestamp of response                                 | Fri, 02 Oct 2020 15:22:10 GMT               |
| Content Body         | Requested data or output (after headers)              | { "location_info": [...] }                  |

This structure ensures that client applications can reliably interpret server responses, validate results, and process returned data, enabling robust interactions in IoT and web platforms.

---

## 3.8.3 The Structure of an HTTP Message - The Request Message - POST

![](images/http_post_request.png)

**Figure 3.8:** The structure of an HTTP request message (POST in this example).

This figure illustrates the **structure** and **main fields** of an HTTP **POST request message**, which is essential for **modeling data submission** and **resource creation** in web and IoT systems.

In the context of **system modeling**, the **HTTP POST request** enables a **client** (such as an IoT device or web application) to **transmit data**—for example, **sensor readings** or **device status**—to a **server** for **processing**, **storage**, or further **computation**. Unlike a **GET request**, which is used to **retrieve data**, the **POST method** is designed to **actively send new information**, supporting scenarios where devices need to **create** or **update resources** on the server.

By clearly defining the **method**, **resource path**, **headers**, and **body**, the POST request provides a **standardized framework** for modeling **interoperable** and **scalable APIs**. This approach ensures that diverse clients can reliably submit structured data, facilitating robust integration and efficient management of resources in distributed IoT and web architectures.

**Main Structure and Fields**

The POST request, as shown, is made up of the following parts:

- **Method**: Specifies the action to be performed on the resource, here `POST`, indicating data submission or resource creation.
- **Resource Path**: Defines the target endpoint `/api/location/` where the server expects the new data.
- **HTTP Version**: Indicates the communication protocol version (e.g., `HTTP/1.1`).
- **Header Fields**: Provide metadata and control information about the request, such as:
  - `Content-Type`: Declares the format of the sent data (`application/json`).
  - `User-Agent`: Identifies the software client sending the request.
  - `Accept`: States the formats the client can handle in the response.
  - `Postman-Token`: Used for request tracking, especially in testing environments.
  - `Host`: The IP or domain of the target server.
  - `Accept-Encoding`: Indicates supported compression methods.
  - `Connection`: Manages session persistence (e.g., `keep-alive`).
  - `Content-Length`: Specifies the byte length of the accompanying body.
- **Body**: Contains the primary data payload being sent, such as:
  - A JSON object with location information (latitude and longitude).

**Summary Table: HTTP POST Request Fields**

| Field Name        | Purpose/About                              | Example Value                         |
|-------------------|--------------------------------------------|---------------------------------------|
| Method            | HTTP operation to execute                  | POST                                  |
| Resource Path     | API endpoint or target resource            | /api/location/                        |
| HTTP Version      | Protocol version                           | HTTP/1.1                              |
| Content-Type      | Format of sent data                        | application/json                      |
| User-Agent        | Client software identification             | PostmanRuntime/7.26.5                 |
| Accept            | Acceptable response formats                | */*                                   |
| Postman-Token     | Request tracking (testing tool)            | c99042fd-...-c28d0d62b6c0             |
| Host              | Server domain/IP and port                  | 127.0.0.1:7070                        |
| Accept-Encoding   | Supported compression                      | gzip, deflate, br                     |
| Connection        | Session persistence                        | keep-alive                            |
| Content-Length    | Size of the request body in bytes          | 199                                   |
| Body              | Data sent to server                        | {location_info:{...}}                 |

This structure enables flexible data communication in web and IoT systems, allowing clients to supply new or updated information to servers in a standardized, reliable manner.

---

## 3.8.4 The Structure of an HTTP Message - The Response Message - POST

![](images/http_post_response.png)

**Figure 3.9:** The structure of an HTTP response message (POST in this example).

When **modeling client-server interactions** in web and IoT systems, the **HTTP POST response** plays a crucial role in confirming the outcome of a **data submission** or **resource creation** operation. Upon successful creation, the server returns a **201 (Created) status code**, signaling that the client's request resulted in a new resource. The response includes the **Location header**, which provides the **URI of the newly created resource**, enabling clients to reference, retrieve, or further interact with it. Minimal metadata—such as the **Date** and **Content-Length**—is typically included, ensuring efficient communication. This standardized response structure supports **interoperability** and **robust modeling** of RESTful APIs, allowing diverse clients to reliably interpret the results of their POST operations.

**Main Structure and Fields**

The response consists of these vital parts:

- **Status Line & Status Code**: Communicates the HTTP protocol version (`HTTP/1.1`), a numeric status (`201`), and message (`CREATED`), indicating successful resource creation.
- **Headers**: Provide essential information about the response.
  - `Date`: Timestamp of response generation.
  - `Location`: Identifies the newly created resource’s endpoint (e.g., `/api/location/00001abc`), enabling clients to retrieve, update, or interact with this resource.
  - `Content-Length`: The size of the content body, usually `0` in simple POST responses without additional response data.
- **Body**: May be empty, as in this example, when the server does not return further content.

**Summary Table: HTTP POST Response Fields**

| Field Name       | Purpose/About                                   | Example Value                  |
|------------------|-------------------------------------------------|-------------------------------|
| Status Line      | Indicates outcome of the POST request           | HTTP/1.1 201 CREATED          |
| Date             | Server’s timestamp of response                  | Fri, 02 Oct 2020 15:22:10 GMT |
| Location         | URI of the created resource                     | /api/location/00001abc        |
| Content-Length   | Number of bytes in response body                | 0                             |
| Body             | Additional returned data (empty in this case)   | ...                           |

This response structure communicates to the client that the data sent was processed, a new resource was created, and where it can be accessed, supporting robust and standardized client-server interactions in RESTful and IoT environments.

> **Note:** In the previous sections we analyzed just two HTTP methods: **GET** and **POST**. However, there are other important methods such as **PUT**, **DELETE**, **PATCH**, and **OPTIONS** that are also widely used in RESTful APIs. Each method serves a specific purpose in resource management and manipulation, contributing to the overall functionality and flexibility of web and IoT applications. We will investigate these other methods in rest of the lecture and in particular with respect to the usage of the RESTful paradigm with HTTP.

---

## 3.9 The Web as a Platform

The **web** was originally designed as an **easy-to-use**, **distributed**, and **loosely coupled system** for sharing documents and information. Its **architecture** is intentionally **simple**, enabling rapid development of applications and straightforward management of content. The web relies on a **small set of core principles**—such as **uniform resource identification**, **stateless communication**, and **standardized protocols**—which have allowed it to **scale** and **evolve** to meet the demands of billions of users and devices.

Over time, the web has transformed into a **platform for building distributed systems**, supporting a wide range of applications beyond document sharing. **Distributed applications** leverage **HTTP** (RFC 2616) as their foundational protocol, enabling **interoperability**, **modularity**, and **scalability** across diverse environments.

When **modeling distributed applications** on the web, it is essential to address requirements such as **resource identification**, **stateless interactions**, **standardized communication patterns**, and **scalable integration**. These needs naturally lead to architectural approaches that support **flexibility**, **interoperability**, and **efficient resource management**—setting the stage for more advanced paradigms that address these requirements in a systematic way.

> There was the need for a more structured approach to designing web-based distributed systems, which led to the development of the **REST architectural style**. REST provides a set of guiding principles and constraints that help model scalable, maintainable, and efficient web services, making it easier to build applications that can grow and adapt over time.

---

# 3.10 REpresentational State Transfer (REST) Architectural Style

## 3.10 REpresentational State Transfer (REST) Architectural Style

**REST** is the **architectural style** that underpins the **World Wide Web**, providing a systematic approach for **modeling distributed systems** and **web applications**. Introduced by **Roy Fielding** in his 2000 Ph.D. dissertation, *"Architectural Styles and the Design of Network-based Software Architectures"*, REST establishes a set of **rules** and **principles** that guide the design of scalable, robust, and maintainable networked applications.

When **modeling web-based systems** using REST, you focus on:

- **Scalability**: Supporting a large number of **interacting clients** and devices efficiently.
- **Robustness**: Ensuring the system can **evolve** and **adapt** over time without breaking existing functionality.
- **Interoperability**: Facilitating seamless communication between **heterogeneous components** and platforms.
- **Simplicity**: Promoting **easy-to-understand** interactions and **stateless communication**.

**Key REST Modeling Principles:**

- **Uniform Interface**: Standardizes how clients interact with resources, simplifying integration and reducing coupling.
- **Statelessness**: Each request contains all necessary information, enabling scalability and reliability.
- **Resource-Based Modeling**: Everything is treated as a **resource** with a unique identifier (URI), making the system modular and extensible.
- **Representation**: Resources are exchanged using standard formats (e.g., JSON, XML), supporting flexible data modeling.
- **Layered System**: Components are organized in layers, improving scalability and security.

> By adhering to REST principles, you can **model web applications** that are **scalable**, **robust**, and **easy to maintain**, laying the foundation for modern distributed systems and IoT platforms.


---

## 3.10.1 The concept of Resource in REST

In **RESTful modeling**, the concept of a **resource** is fundamental. A **resource** represents any significant entity within an application's domain that is exposed and manipulated via the web. Resources are the building blocks of REST architectures, providing a standardized way to model and interact with application data.

**Key characteristics of resources in REST:**

- **Domain-Relevant Entity**: A resource can be anything meaningful in your application—such as a **webpage**, a **video**, a **user profile**, or an **order** in an e-commerce system.
- **User Interaction**: Resources are entities with which users interact to achieve specific goals (e.g., viewing a product, placing an order, updating a profile).
- **Universal Mapping**: Any aspect of an application's domain can be modeled as a resource, making REST highly flexible and extensible.
- **Data Representation**: Each resource is characterized by associated data (for example, the **title** of a page, the **items** in an order, or the **attributes** of a user).
- **Identification via URI**: Every resource is uniquely identified by a **Uniform Resource Identifier (URI)**, which serves as its address on the web. This allows clients to locate and interact with resources easily.

An example of a REST resource modeling in the IoT can be as reported in the following table:

| Resource Type       | Description                                       | Example URI                          |
|---------------------|---------------------------------------------------|--------------------------------------|
| Device              | Represents an IoT device                          | /iot/devices/123                     |
| Sensor              | Represents a sensor within a device               | /iot/devices/123/sensors/456         |
| Actuator            | Represents an actuator within a device            | /iot/devices/123/actuators/789       |
| User                | Represents a user interacting with the IoT system | /iot/users/abc                       |
| Data Stream         | Represents a data stream from a sensor            | /iot/devices/123/sensors/456/data    |
| Configuration       | Represents device configuration settings          | /iot/devices/123/configuration       |

> In summary, **REST models everything as a resource**, enabling a uniform, scalable, and modular approach to designing web-based and distributed systems.

---

## 3.10.2 Differences with Other Architectural Styles

When **modeling distributed systems**, it is essential to understand how **REST** differs from other architectural styles, such as **Remote Procedure Call (RPC)** and **Service-Oriented Architecture (SOA)**. Each style has its own principles and approaches to structuring interactions between components, which can significantly impact the design and functionality of the system.

**Remote Procedure Call (RPC)** 

The RPC focuses on invoking methods or functions on remote systems as if they were local. This approach often leads to **tighter coupling** between client and server, as the client must be aware of the server's interface and method signatures. RPC can be less flexible and harder to scale, especially in dynamic environments where services may change frequently.

An example of RPC protocols includes **gRPC** and **XML-RPC** and can be quickly summarized as follows with an IoT example:

Suppose an IoT client wants to remotely turn on a smart light. Using an RPC protocol (e.g., gRPC), the client sends a method call like `TurnOnLight(device_id: "light-001")` to the server. The server executes the function and returns a result (e.g., success/failure). This direct invocation abstracts the network communication, making remote actions appear as local function calls.

**Service-Oriented Architecture (SOA)**

SOA emphasizes the use of **loosely coupled services** that communicate over a network. Services in SOA are designed to be reusable and can be orchestrated to perform complex workflows. While SOA promotes modularity and reusability, it can introduce complexity due to service contracts and the need for service discovery mechanisms.

An example of SOA protocols includes **SOAP** and **WSDL** and can be summarized as follows with an IoT example:

In an IoT scenario, a SOA-based system might have a service for managing device configurations. A client could send a SOAP request to the `DeviceConfigService` to update the settings of a specific device. The service processes the request and returns a SOAP response indicating the success or failure of the operation. This approach allows for clear service definitions and interactions but may involve more overhead compared to REST.

**Comparison Table**

| Aspect                     | REST                                             | RPC                                              | SOA                                             |
|----------------------------|--------------------------------------------------|--------------------------------------------------|-------------------------------------------------|
| **Interaction Model**      | Resource-based, stateless interactions           | Function/method calls, often stateful            | Service-based, can be stateful or stateless      |
| **Coupling**               | Loose coupling through standard interfaces       | Tight coupling due to direct method calls        | Moderate coupling, services can be independently deployed |
| **Scalability**            | Highly scalable due to statelessness             | Less scalable, stateful interactions can limit scalability | Scalable, but depends on service design          |
| **Flexibility**            | High flexibility with resource representations   | Less flexible, tied to specific method signatures | Flexible, but can be complex due to service contracts |
| **Standardization**        | Uses standard HTTP methods and status codes      | No standard protocol, varies by implementation | Often uses SOAP or REST, but can be complex      | 
| **Complexity**             | Simpler, with fewer constraints                  | Can be complex due to method definitions         | Can be complex due to service orchestration      | 
| **Use Cases**              | Web applications, IoT, mobile apps               | Legacy systems, tightly coupled applications     | Enterprise applications, complex workflows       |

> In summary, **REST** offers a **resource-oriented**, **stateless**, and **scalable** approach to modeling distributed systems, making it well-suited for modern web and IoT applications. In contrast, **RPC** focuses on direct method calls, often leading to tighter coupling, while **SOA** emphasizes service-based interactions that can introduce complexity. Understanding these differences is crucial for selecting the appropriate architectural style for your specific application needs.

---

## 3.10.3 A Simple Comparison Between REST and SOAP

![](images/rest_vs_soap.png)

**Figure 3.10:** A simple comparison between REST and SOAP.

The figure compares REST and SOAP web service models, highlighting key distinctions in architecture, data formats, and messaging approaches[1].

**REST Resource**

- **Endpoints and Operations**: REST uses simple URI endpoints (e.g., `/sensor/temp`) and HTTP methods such as `GET` for retrieving data.
- **Data Formats**: REST supports various representations, commonly `application/json` and sometimes `application/xml`. JSON is lightweight, widely used for IoT and web APIs, while XML can be employed when needed[1].
- **Description and Discovery**: It may utilize WSDL (Web Services Description Language), WADL (Web Application Description Language), or JSON-WSP for service definition, though these are optional within RESTful design[1].
- **Interaction Style**: REST is stateless, typically lightweight, with direct mappings between HTTP methods and CRUD operations[1].

**SOAP Service**

- **Endpoints and Operations**: SOAP packages requests into structured envelopes sent to service endpoints (e.g., `/sensor/service`), often using the HTTP `POST` method.
- **Data Formats**: SOAP defines strict messaging using `application/soap+xml`, where each message has two sections: a header and a body. The body contains function call and parameter data (here, `RequestSensor(temp)`)[1].
- **Description and Discovery**: SOAP relies heavily on WSDL for automatic service description and client generation[1].
- **Interaction Style**: SOAP is protocol-heavy, including built-in standards for security, reliability, and transactional processing—making it suitable for complex enterprise scenarios but less ideal for lightweight IoT and web applications[1].

**Comparative Table**

| Aspect             | REST                              | SOAP                               |
|--------------------|-----------------------------------|------------------------------------|
| Endpoint Example   | /sensor/temp                      | /sensor/service                    |
| HTTP Verb          | GET, POST, PUT, DELETE            | Typically POST                     |
| Data Format        | JSON, XML                         | SOAP XML (Header + Body)           |
| Description        | Optional WSDL/WADL/JSON-WSP       | Mandatory WSDL                     |
| Structure          | Resource-oriented, lightweight     | Strict envelope, protocol-heavy    |
| Typical Use        | IoT, Web APIs, Mobile clients     | Enterprise, transaction-heavy APIs |

**Key Differences**

- REST emphasizes simplicity, direct resource manipulation, and flexibility in data formats—ideal for scalable web and IoT APIs.
- SOAP is more regimented, suitable for situations demanding comprehensive standards (security, transactions), but less efficient for modern web and IoT application needs[1].

---

## 3.10.4 The Client Perspective REST vs. SOAP

When **modeling client-server interactions**, the choice between **REST** and **SOAP** can significantly impact the design and functionality of the system. From a **client perspective**, several factors should be considered.

When interacting with a server, the client must be aware of certain foundational concepts to ensure effective communication and correct operation.

**Client-Server Interaction Essentials**

- **Protocol Compliance**: The client must use the appropriate protocol and adhere strictly to its message structure and semantics (e.g., HTTP methods like GET, POST, headers, and body formats).
- **Resource or Service Addressing**: Clients should know the exact URI or endpoint to target based on the service or resource to be accessed.
- **Request Metadata**: Proper headers such as `Content-Type`, `Accept`, and authentication tokens if necessary must be included to ensure the server understands the request context.
- **Response Handling**: Clients should interpret diverse response status codes and payloads to process results or errors adequately.

**Conceptual Differences: Resource vs Service-Based Approaches**

- **Resource-Centric Model (e.g., REST)**:
  - Represents everything as resources addressed by **URIs**.
  - A **resource** is an entity (like a sensor, device, or location) on which multiple standard actions (CRUD - Create, Retrieve, Update, Delete) can be performed using HTTP methods.
  - This model is **intuitive**, **scalable**, and **easy to navigate** because the client interacts primarily by addressing resources and selecting desired operations.
  - Clients **do not need deep knowledge** about specific actions beyond standard methods; **they explore or manipulate resources directly**.

- **Service-Oriented Model (e.g., SOAP)**:
  - Emphasizes **services** that expose specific operations or methods (like `RequestSensor(temp)`).
  - Services often require **detailed contract definitions** (e.g., WSDL) that specify all available operations, input, and output parameters.
  - **Clients must have additional knowledge** about the available services, operation names, expected message formats, and how to compose requests accordingly.
  - This model is powerful for **complex, transactional, or secure workflows but introduces more complexity for the client**.

In simple terms, a resource-centric approach like REST focuses on addressing and manipulating entities with uniform methods, promoting ease of use and scalability. A service-based approach like SOAP defines a catalog of operations that clients invoke, requiring richer client-side knowledge about the service contract. Clients aiming to interact with a server must appreciate these distinctions to prepare correct requests, handle responses, and maintain compatibility with the server’s communication model.

> **Note:** From an IoT perspective, REST is often preferred for its simplicity, scalability, and alignment with web standards, making it suitable for resource-constrained devices and dynamic environments. SOAP may be chosen in scenarios demanding strict security, reliability, or complex transactions, typically in enterprise settings. However, REST's lightweight nature and ease of integration with modern web technologies often make it the go-to choice not only for IoT but also for web and mobile applications.

---

## 3.10.5 REST Main Characteristics

When **modeling REST architectures**, several core characteristics and principles guide the design of scalable, interoperable, and maintainable systems:

- **Client-Server Model**:  
  - **Clients** (user agents, such as browsers or IoT devices) act as the application interface, initiating interactions by sending requests.
  - **Servers** (origin servers) host **resources** and respond to client requests, managing data and business logic.
  - This **separation of concerns** ensures that clients and servers have distinct, limited responsibilities, promoting modularity and independent evolution.

- **Intermediaries**:  
  - **Forward proxies** (known to clients) serve as “exit points” for requests, often used for caching, filtering, or access control.
  - **Reverse proxies** appear as origin servers to clients but relay requests to actual servers, enabling load balancing, security, and scalability.
  - Intermediaries can act as both clients and servers, enhancing flexibility and robustness in distributed system modeling.

- **Uniform Interface**:  
  - All connectors within the system must conform to a standardized interface, which simplifies integration and interaction.
  - **Key constraints of the uniform interface**:
    - **Identification of resources**: Every resource is uniquely identified by a URI, enabling consistent addressing and manipulation.
    - **Manipulation of resources through representations**: Clients interact with resources by exchanging representations (e.g., JSON, XML), allowing for flexible data modeling.
    - **Self-descriptive messages**: Each message contains all necessary information for processing, supporting stateless communication and interoperability.
    - **Hypermedia as the engine of application state (HATEOAS)**: Clients navigate the application dynamically using hyperlinks provided in resource representations, enabling discoverability and adaptability.

> By adhering to these principles, RESTful modeling achieves **scalability**, **simplicity**, and **interoperability**, making it a foundational approach for modern web and IoT systems.

---

## 3.10.6 REST & Resource Representation

![](images/rest_resource_representation.png)

**Figure 3.11:** REST & Resource Representation also with forward and reverse proxies.

When **modeling RESTful systems**, it is crucial to understand that **resources themselves are never exchanged directly** between endpoints. Instead, what is transferred is a **representation** of a resource—a snapshot or view of its state at a specific moment.

**Key characteristics of resource representation in REST modeling:**

- **Representation**:  
  - A representation is a **transformation or view** of a resource’s current state.
  - It is encoded in a **transferable format** such as **JSON**, **XML**, **XHTML**, **Atom**, **plain text**, **CSV**, **MP3**, or **JPEG**.
- **Serialization/Deserialization**:  
  - Each endpoint must **serialize** (convert resource state to a transferable format) before sending and **deserialize** (convert back to usable data) upon receiving.
- **Decoupling**:  
  - This approach **decouples the internal resource model** from its external representation, allowing flexibility in how resources are exposed and consumed.
- **Multiple Representations**:  
  - The same resource can have **multiple representations** (e.g., a device’s data as JSON for APIs, or as HTML for web dashboards), supporting diverse client needs.

> In RESTful modeling, always remember: **what is exchanged are representations, not the resources themselves**. This principle enables interoperability, extensibility, and efficient communication across heterogeneous systems.

![](images/rest_resource_representation_1_n.png)

**Figure 3.12:** From 1 resource to N representations.

When **modeling RESTful systems**, it is essential to understand that what is actually exchanged between **clients** and **servers** is a **representation** of a resource—not the resource itself.

**Core characteristics:**
- A **resource** is an abstract entity identified by a **URI**; its **representation** is a concrete, transferable format (such as **JSON**, **XML**, or **HTML**) that describes its current state.
- The **same resource** can have **multiple representations** (**1:N relationship**), allowing different clients to consume the resource in the format best suited to their needs.
- For **clarity and compactness**, we will refer to the **representation of a resource** simply as a **resource** in the following sections—but always remember the distinction between the abstract resource and its concrete representation.

> **Key modeling takeaway:** Always model interactions in REST as exchanges of resource representations, enabling flexibility, interoperability, and support for diverse client requirements.
