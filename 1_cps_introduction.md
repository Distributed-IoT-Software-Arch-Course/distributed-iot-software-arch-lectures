# Lecture 1 - Introduction to Cyber-Physical Systems & Internet of Things

## Lecture Information

| **Course Title** | Distributed and Internet of Things Software Architectures |
|------------------|----------------------------------------------------------|
| **Master's Degree** | Digital Automation Engineering (D.M.270/04)           |
| **Curriculum**   | Digital Infrastructure                                   |
| **Lecture Title**| Cyber-Physical Systems & Internet of Things              |
| **Author**       | Prof. Marco Picone (marco.picone@unimore.it)             |
| **Academic Year**| A.A 2025/2026                                            |
| **Last Update**  | September 2025                                           | 


<!-- > [!TIP]
> MarkItDown now offers an MCP (Model Context Protocol) server for integration with LLM applications like Claude Desktop. See [markitdown-mcp](https://github.com/microsoft/markitdown/tree/main/packages/markitdown-mcp) for more information. -->

# Outline

- Cyber-Physical Systems
- Cyber-Physical Application Scenarios
- Internet of Things (IoT) Definition & Vision
- From WSN and M2M to IoT
- IoT Characteristics
- IoT Protocol Stack
- IoT Connectivity
- IoT Software

# Internet & Connected Devices

## Where do we started ?

Since from the beginning of the Internet, there was the desire to connect more “things” to it. Source: ARPANET Completion Report: January 4, 1978.

![ARPANET Completion Report January 4, 1978](images/Lecture1/arpanet_1978.png)

## Where are we today ?

The internet now connects billions devices anywhere!

![The current state of the Internet/Web](images/Lecture1/current_internet_web.png)

<!-- Slide number: 5 -->
## The First "Connected Devices" - The Cold Drink Machine

```
The students of Carnegie Mellon University invent the ARPANET-connected coke machine. Four students from the School of Computer Science department installed the switches in the coke machine. They counted how many coke bottles had remained in each row and for how long. If the loaded bottle spends a long time in the machine, it is labeled “cold”. All this data was then remotely available to customers via a finger interface. This experiment had inspired a lot of inventors all over the world to create their own connected appliances.
```

![Connected Drink Machine](images/Lecture1/drink_machine.png)
CSE3002 Team Project History of Internet of Things (IoT) Devices and Their Influence on Cyber Security Team F Christopher Byars Dylan Leonard Brian Patino. Sources: https://slideplayer.com/slide/14090495/, https://hqsoftwarelab.com/blog/the-history-of-iot-a-comprehensive-timeline-of-major-events-infographic/


## The First "Connected Devices" - The XCoffee

```
The XCoffee is created at the Computer Laboratory of the University of Cambridge. Two academics who worked at the Trojan Room in the laboratory had a video-frame grabber attached to one of the computers. They decided to connect a camera controlled by a server application that was observing the coffee pot and taking pictures of it several times a minute. Then the pictures were sent to the client application, to keep the user updated on the information about whether the pot was filled.
```

![XCoffee Machine](images/Lecture1/xcoffee.png)

Sources: https://www.cl.cam.ac.uk/coffee/qsf/coffee.html, https://odannyboy.medium.com/the-first-things-on-the-internet-of-things-5d817d45ac9c,https://hqsoftwarelab.com/blog/the-history-of-iot-a-comprehensive-timeline-of-major-events-infographic/

## The Mobile Centric World

```
What a difference 8 years makes: St. Peter’s Square in 2005 and yesterday (2013)” (Facebook NBC News)
```

![Piazza San Pietro - The Mobile Revolution](images/Lecture1/piazza_san_pietro.png)

Another interesting example is the event ...

![Vasco Rossi Concert, Modena Park](images/Lecture1/olivetti_modena_park.png)

230K Devices at Vasco Rossi Concert @ Modena Park - July 2017 Source: https://www.digitaldata.olivetti.com/timbigdata/concerto-di-vasco-rossi

### Mobile & Wearable Computing

![Vasco Rossi Concert, Modena Park](images/Lecture1/wearable_computing.png)

<!-- Slide number: 11 -->
# Cyber–Physical Systems

> [!IMPORTANT]
> A **Cyber-Physical System (CPS)** refers to integrated systems that combine computational elements with physical components, enabling the interaction and collaboration between the digital and physical worlds. CPS typically involve a network of **sensors**, **actuators**, and **computational devices** that **collect data** from the physical environment, **process** it, and **control** physical processes or objects.

![Cyber-Physical Systems High-Level Overview](images/Lecture1/cps_highlevel_overview.png)

<!-- Slide number: 12 -->
# Cyber–Physical Systems
2
Plan
Learn
Analyze

![Digital Brain Icon - Free PNG & SVG 2486380 - Noun Project](Picture4.jpg)
Cyber World

3

Act
Perceive

1

Physical World

12

<!-- Slide number: 13 -->
# Cyber–Physical Systems
The field of cyber-physical systems is cross-disciplinary in nature — building upon complex technology systems that promote advancement in countless fields
Cyber-physical systems are engineered systems where functionalities and salient properties emerge from the networked interaction of cyber/digital and physical components
CPS technology seeks to develop and deploy technologies needed for the seamless integration of cyber and physical systems including:
Processes
Software
Networking
Artificial Intelligence
Coordination/Orchestration Algorithms
Systems on Chip (SoC)
Embedded Systems
Robotics
and counting …
13

<!-- Slide number: 14 -->
# Cyber–Physical Systems
Cyber-physical systems are also a way to encompass the large spectrum of application scenarios including:
Industry 4.0
Internet of Things (IoT)
Automotive
Military
Medical & Healthcare
and so on
They have recently emerged as the leading domain for the study and implementation of multi-component systems where computational and physical resources are strictly interconnected and seamlessly integrated

![A robot welding a car body Description automatically generated](Picture54.jpg)
14

<!-- Slide number: 15 -->
# Cyber–Physical Systems
CPSs integrate in the same environment and application scenario:
Sensing
Actuation
Computation
Control
Networking
Communication
They represent a major paradigm in the framework of collective and connected systems, as well as a vertical study of systems: they are inherently transdisciplinary, generalizing and expanding individual sub-fields

![Message - free icon](Picture4.jpg)

![Message - free icon](Picture4.jpg)

![Message - free icon](Picture4.jpg)

![Message - free icon](Picture4.jpg)

![Message - free icon](Picture4.jpg)

![Message - free icon](Picture4.jpg)

15

<!-- Slide number: 16 -->
# Cyber–Physical Systems – Technologies (Some)

![A diagram of a factory Description automatically generated](Picture4.jpg)
Wireless
Networks
Edge Computing
Robots
Robots

Monitoring, Coordination, Automation
Internet/Cloud
Access
Wired
Networks
Human-to-Machine Interaction(s)
Protocols
https://www.mouser.it/new/analog-devices/adi-industry-4https://www.linkedin.com/pulse/examples-industry-40-use-cases-luka-kozamernik/
16

<!-- Slide number: 17 -->
# Cyber–Physical Systems – High Level Overview

![A diagram of a factory Description automatically generated](Picture4.jpg)
Decision

Insight
Goal
Context
Key Performance Indicator
Process
Event
Data
System(s)
Equipment
17

<!-- Slide number: 18 -->
# Cyber–Physical Systems – Distributed Software

![A diagram of a factory Description automatically generated](Picture4.jpg)
Distributed
Software

18
https://www.linkedin.com/pulse/examples-industry-40-use-cases-luka-kozamernik/

<!-- Slide number: 19 -->
# Cyber–Physical System- Distributed Software
Integration of Physical and Digital Components: CPS involves the integration of software systems with physical components such as sensors, actuators, and control systems. The software must interact with these physical elements to monitor and control the underlying physical processes.
Real-Time and Predictability: CPS often operates in real-time or near-real-time environments where timely and predictable responses are critical. The software must be designed to meet stringent timing requirements, ensuring timely data collection, processing, and control actions.
Heterogeneity and Interoperability: CPS typically involve a mix of diverse technologies, devices, and communication protocols. The software must be capable of interacting and integrating with different hardware and software components, ensuring interoperability and seamless communication among them.
Safety and Reliability: CPS are often deployed in safety-critical domains such as automotive, healthcare, and industrial automation. The software must be developed with a strong emphasis on safety and reliability, adhering to rigorous standards and employing techniques like fault tolerance and error handling.
19

<!-- Slide number: 20 -->
# Cyber–Physical System- Distributed Software
Scalability and Adaptability: CPS are often deployed in large-scale systems where the number of connected devices and data volumes can be substantial. The software must be scalable, capable of handling increasing system complexity and data loads. Additionally, it should be adaptable to dynamic changes in the environment or system requirements.
Network and Connectivity: CPS software must utilize the network connectivity for communication between the cyber and physical world, as well as among different CPS components. For example, a smart grid system must coordinate the power generation and distribution among different sources and consumers through the internet.
Security and Privacy: CPS are vulnerable to cybersecurity threats due to their interconnected nature. The software must incorporate robust security measures to protect against potential attacks and ensure the privacy and integrity of sensitive data.
Verification and Validation: Due to the critical nature of CPS, software development for CPS requires thorough verification and validation processes. Rigorous testing, simulation, and formal methods are employed to ensure the correctness, performance, and safety of the software
20

<!-- Slide number: 21 -->
# Cyber–Physical System Open Issues
If we escalate to the more general Cyber-Physical System models, the design and control challenges become even harder, since individual component autonomy must be glued by explicitly addressing interdependence and coordination, interoperability, distributed control and emergence of behaviors
In this context centralized and static management and control model are not expected to be the right solution approach to address all these challenges and the current main existing issues are the following:
Centralized and monolithic Software architectures
Missing management of the massive heterogeneity and fragmentation of the physical layer (protocols, software, hardware, data format, etc …)
Limited interoperability and collaboration both between existing solutions and through cross-domain application scenarios
Centralized learning and coordination
21

<!-- Slide number: 22 -->
# Cyber–Physical System Open Challenges (Opportunities)
On the other hand, the envisioned goal is to build a new generation of distributed, highly-dynamic, opportunistic, able to operate in an open and coordinated environment through:
distributed and continuum architectures (across device, edge, cloud)
networking and intelligent communication
effective management of the physical layer heterogeneity
standardization and native interoperability
control, supervision and management
local coordination
autonomy of the sub-systems
native system re-configuration
decentralized learning & dynamic evolution and behaviors
22

<!-- Slide number: 23 -->
# Cyber–Physical System of Systems
The concept of Cyber-Physical System of Systems (CPSoS) refers to the integration and collaboration of multiple interconnected CPSs to create a more complex and sophisticated system
CPSoS is characterized by the coordination and interaction of individual CPS units, each with its own set of physical components, computational elements, and networked communication.
In a CPSoS, the individual CPS units retain their autonomy and functionality while working together towards a common goal or objective. These systems can vary in scale and complexity, ranging from localized collaborations to large-scale networks of interconnected CPS units
The key idea behind CPSoS is to leverage the capabilities and resources of multiple CPS units to achieve enhanced performance, efficiency, and functionality that would not be possible with isolated systems. By combining the individual strengths of different CPS units, CPSoS can offer improved system-wide intelligence, resilience, and adaptability.
23

<!-- Slide number: 24 -->
# Cyber–Physical System of Systems
CPSoS can be found in various domains, such as smart cities, transportation systems, industrial automation, and healthcare. Examples include:
interconnected traffic management systems
coordinated smart grid networks
integrated healthcare monitoring systems
smart manufacturing
However, managing CPSoS presents several challenges:
ensuring interoperability and seamless communication between different CPS units
handling heterogeneity in system architectures and technologies
addressing issues of scalability and complexity
managing security and privacy concerns across the interconnected systems.
Overall, CPSoS represents a higher-level integration of multiple CPS units, enabling collaborative and coordinated operation to achieve more advanced functionalities, improved performance, and increased system intelligence.
24

<!-- Slide number: 25 -->
# Cyber-Physical Applications - One Point of View

![Google Shape;426;p60](GoogleShape426p60.jpg)
25

<!-- Slide number: 26 -->
# Cyber-Physical Application – An Integrated Point of View

![Google Shape;432;p61](GoogleShape432p61.jpg)
Cyber-Physical System of Systems
26

<!-- Slide number: 27 -->
# CPSoS – Smart Manufacturing Example
For example, in a Smart Manufacturing use case In this scenario, various interconnected CPS units collaborate to optimize production processes, monitor equipment health, and improve overall efficiency. The CPSoS in a smart manufacturing system typically includes multiple CPS components such as:
Industrial Robots: Robotic arms and automation systems that perform tasks like assembly, welding, or material handling.
Internet of Things Devices: Sensors and actuators embedded in machinery, equipment, and production lines to collect real-time data on parameters like temperature, pressure, vibration, and energy consumption.
Industrial Control Systems: Distributed control systems and Programmable Logic Controllers (PLCs) that regulate and coordinate operations across different CPS units.
Data Analytics and AI Systems: Machine learning algorithms and data analytics tools that process the collected data, identify patterns, and provide insights for predictive maintenance, quality control, and optimization.
Supply Chain Management Systems: CPS units involved in the coordination and optimization of supply chain activities, including inventory management, demand forecasting, and logistics.
Human-Machine Interfaces: Interfaces that allow human operators to monitor and control the manufacturing processes, providing real-time feedback and facilitating human-machine collaboration.
27

<!-- Slide number: 28 -->
# CPSoS – Smart Manufacturing Example
These interconnected CPS units collaborate to achieve various objectives, such as:
Optimizing production schedules based on demand forecasts and real-time data on equipment performance.
Implementing predictive maintenance strategies by monitoring equipment health in real-time and identifying potential failures before they occur.
Optimizing energy consumption and resource utilization by leveraging real-time data on energy usage and production demands.
Enabling real-time quality control through continuous monitoring and feedback on product quality parameters.
Facilitating flexible and adaptive production processes by dynamically reconfiguring CPS units based on changing demands or resource availability.
In such scenario, the CPSoS in smart manufacturing systems improves efficiency, productivity, and quality by leveraging the integration and collaboration of multiple CPS units. It enables real-time monitoring, control, and optimization of manufacturing processes, resulting in enhanced operational performance and competitiveness in the industrial ecosystem.
28

<!-- Slide number: 29 -->
# Industrial IoT (IIoT)

![Google Shape;486;p66](GoogleShape486p66.jpg)

![Google Shape;487;p66](GoogleShape487p66.jpg)
29

<!-- Slide number: 30 -->
# Industrial IoT (IIoT)

![Google Shape;493;p67](GoogleShape493p67.jpg)
Source: RedHat l'OpenSource e i suoi partner per l'Internet of Things. Milano 30/10/2018, RedHat Forum 2018.
30

<!-- Slide number: 31 -->
# Smart Home & Smart Building

![Google Shape;438;p62](GoogleShape438p62.jpg)

![Google Shape;439;p62](GoogleShape439p62.jpg)
Centralized Building Control
Common Policies (e.g., Office hours, Temperatures, etc ..)
High number of guest, visitors and promiscuous accesses
Complex Behaviour and High number of heterogeneous devices and data
Apartment Local Control
Local Dynamic Policies
Limited number of guests
Simple Behaviour and limited number of Smart Objects
31

<!-- Slide number: 32 -->
# Smart Cities

![Google Shape;462;p64](GoogleShape462p64.jpg)
Heterogeneous Applications, Data and Connectivity Solutions
Interoperability and Seamless Communication between subsystem is a key of success though the use of standard protocols,  Open Data and a shared technological stack
Mobility of users and things
Citizens, Visitors and Tourists as natural consumers of customized data and services
32

<!-- Slide number: 33 -->
# The Internet of Things (R)Evolution

![Google Shape;155;p22](GoogleShape155p22.jpg)
Internet of Things has already both directly or indirectly transformed several markets and fields such as:
Communication (e.g., 5G Cellular Networks)
Internet Architecture (Edge Computing)
Human–Machine Interaction
Mobile Device and Applications
Industry
Single Board Computers and prototyping platforms
Furthermore it may embrace a massive amount of heterogeneous research and technologies fields at the same time:
Computer Science
Software Engineering
Networking & Communication Systems
Distributed Systems
Artificial Intelligence and Machine Learning
Electronics
Business
…. and counting

![Google Shape;156;p22](GoogleShape156p22.jpg)
https://safeatlast.co/blog/iot-statistics/
33

<!-- Slide number: 34 -->
# IoT Trends
https://iot-analytics.com/iot-technologies/

![](Picture4.jpg)
34

<!-- Slide number: 35 -->
# What is the Internet of Things ?

![Google Shape;170;p24](GoogleShape170p24.jpg)
A network of networks with billions of uniquely identified physical Smart Objects organized in an Internet-like structure
Smart Objects are items such as sensors, consumer devices, and enterprise assets that are connected to both the Internet and each other
35

<!-- Slide number: 36 -->
# IoT Characteristics
The main and distinctive characteristics of the Internet of Things are the following
Unique identifiable objects (things) with embedded intelligence able to sense or interact with the environment and communicate with the external world
Presence of constrained devices with limited processing, storage and energy capabilities
IP (Internet Protocol) based Networks (both IPv6 and IPv4)
Different Communication Technologies (e.g., WiFi, Cellular, 802.15.4 etc ...)
Standard protocols and Interoperability
Disruptive heterogeneity in terms of data, hardware and software
Security
Interaction between People & Things
36

<!-- Slide number: 37 -->
# IoT Challenges

![Google Shape;189;p27](GoogleShape189p27.jpg)

![Google Shape;190;p27](GoogleShape190p27.jpg)
37

<!-- Slide number: 38 -->
# IoT vs Wireless Sensor Networks
Wireless Ad-hoc Sensor Networks (WSN) represent the ancestors of the Internet of Things without a common and shared IP network.
WSNs promised wide support of the interaction between people and their surroundings. The potential of the WSN lies in the three words composing the acronym itself:
Wireless: puts the focus on the freedom that the elimination of wires gives in terms of mobility support and ease of system deployment
Sensor: reflects the capability of sensing technology to provide the means to perceive and interact – in a wide sense – with the world
Networks: gives emphasis to the possibility of building systems whose functional capabilities are given by a plurality of communicating devices, possibly distributed over large areas.
38

<!-- Slide number: 39 -->
# Telemetry & Machine 2 Machine (M2M)
Telemetry allows the possibility to collect remote measurements from the field
Telemetry can be associated to:
Long-range Measurements: temperature, humidity, wind from remote weather stations (cellular network or Inmarsat satellite network); Formula 1
Short-range Measurements: pacemaker (telemetry coil, to measure the activity without surgery: low-power communication)
M2M is a generalization of telemetry, which implies autonomic bidirectional communication between non-human operated machines and a central collector device

![Google Shape;203;p29](GoogleShape203p29.jpg)
39

<!-- Slide number: 40 -->
# M2M Fragmentation
Fragmented industry verticals:
most industries are solving their M2M needs on their own;
Often converging upon similar architectures and elements;
the M2M “wheel” is reinvented from industry to industry
Customized solutions abound:
since solutions are on an industry-by-industry basis, each solution requires its own design, production, and implementation cycle;
unique solutions often result in sole-sourcing of customized hardware;
software design is limited to a small group of developers who understand the architecture and API’s for a particular industry or platform, thus leading to high development costs and high costs for support.
Lack of scale for components: economies of scale are difficult to achieve in any given industry since solutions are so varied and unique.
40

<!-- Slide number: 41 -->
# IoT vs Machine 2 Machine (M2M)

![Google Shape;215;p31](GoogleShape215p31.jpg)
Figure from: https://www.avsystem.com/blog/iot-and-m2m-what-is-the-difference/
41

<!-- Slide number: 42 -->
# IoT vs Machine 2 Machine (M2M)

![Google Shape;222;p32](GoogleShape222p32.jpg)
42

<!-- Slide number: 43 -->
# Vertical Silos are not Real IoT !

![Google Shape;228;p33](GoogleShape228p33.jpg)
43

<!-- Slide number: 44 -->
# Vertical Silos are not Real IoT !

![Google Shape;234;p34](GoogleShape234p34.jpg)

![Google Shape;236;p34](GoogleShape236p34.jpg)
44

<!-- Slide number: 45 -->
# IoT ”Pillars”

![Google Shape;183;p26](GoogleShape183p26.jpg)
45

<!-- Slide number: 46 -->
# A Shared IoT Multi-Layer Model
It is possible to abstract IoT Systems and Architectures through a general multi-layer reference model with the aim to provide an high-level overview and to help in understanding the different layers and their interactions, enabling the development of comprehensive and scalable IoT solutions
Of course, the model can be adapted and customized based on specific IoT implementations and requirements
Main layers characterizing this reference model are:
Perception Layer
Network Layer
Data and Information Management Layer
Services and Applications Layer
Business Layer
46

<!-- Slide number: 47 -->
# A Shared IoT Multi-Layer Model (An Example)

![Seven levels of IoT Reference Model](Picture2.jpg)
Business Layer
Services and Applications Layer

Data and Information Management Layer

Network Layer
Perception Layer
https://www.altexsoft.com/blog/iot-architecture-layers-components/
https://newsroom.cisco.com/c/r/newsroom/en/us/a/y2014/m10/the-internet-of-things-world-forum-unites-industry-leaders-in-chicago-to-accelerate-the-adoption-of-iot-business-models.html
47

<!-- Slide number: 48 -->
# A Shared IoT Multi-Layer Model
Perception Layer: The perception layer is the bottommost layer of the IoT World-Forum Reference Model. It comprises the physical objects, sensors, actuators, and devices that interact with the physical environment. This layer collects data from the environment, such as temperature, humidity, or motion, through sensors and converts it into digital information.
Network Layer: The network layer builds upon the perception layer and provides the infrastructure for communication and connectivity. It encompasses various technologies and protocols for local and wide-area networking, such as wireless (Wi-Fi, Bluetooth, Zigbee), wired (Ethernet), or cellular networks. This layer facilitates the transfer of data between devices, gateways, and the cloud.
Data and Information Management Layer: The data and information management layer focuses on the storage, processing, and management of data generated by IoT devices. It includes components such as data storage systems, databases, and data analytics platforms. This layer handles tasks such as data filtering, aggregation, analysis, and enables efficient storage and retrieval of IoT-generated data.
Services and Applications Layer: The services and applications layer builds upon the previous layers and provides higher-level functionalities and services to end-users. It includes services like device management, security, data visualization, and application development frameworks. This layer enables the creation of diverse IoT applications and services tailored to specific use cases.
Business Layer: The business layer is the topmost layer of the IoT World-Forum Reference Model. It focuses on the business aspects, including the monetization, governance, and value creation of IoT solutions. This layer encompasses business models, standards, regulations, and policies that govern the deployment and operation of IoT systems. It also includes considerations such as privacy, ethics, and sustainability.
48

<!-- Slide number: 49 -->
# IoT Hardware

![Google Shape;242;p35](GoogleShape242p35.jpg)

![Google Shape;243;p35](GoogleShape243p35.jpg)
49

<!-- Slide number: 50 -->
# IoT Hardware
Communication: This gives the smart object its communication capabilities. It is typically either a radio transceiver with an antenna or a wired connection.
Microcontroller: This gives the smart object its behavior. It is a small microprocessor that runs the software of the smart object.
Sensors or actuators: These give the smart object a way to sense and interact with the physical world.
Power source: This is needed because the smart object contains electrical circuits. The most common power source is a battery, but there are other examples as well such as piezoelectric power sources, that provide power when a physical force is applied, or small solar cells, that provide power when light shines on them.
50

<!-- Slide number: 51 -->
# Internet of Things Protocol Stack
The extremely high number of IoT devices, together with their heterogeneity, require proper mechanisms for the management and seamless interaction with smart objects.
At the physical layer, low power Wi-Fi, IEEE 802.15.4, LoRa and LoRaWAN, 4.5G/5G, and Bluetooth Low-Energy (BLE) are used to minimize energy consumption.
Interoperability among IoT devices will be provided through the use of the Internet Protocol (IP), which will also guarantee integration with the Internet (6LoWPAN).
At the application layer, CoAP (RFC 7252) has been designed to bring the REST paradigm to constrained devices. MQTT represents instead the Pub/Sub IoT standard at the moment.

![Google Shape;263;p38](GoogleShape263p38.jpg)
51

<!-- Slide number: 52 -->
# IoT Connectivity

![Google Shape;270;p39](GoogleShape270p39.jpg)
https://www.qorvo.com/design-hub/blog/iot-standards-the-end-game | https://www.digikey.com/en/articles/techzone/2018/jun/speed-development-secure-cellular-connected-iot-applications
52

<!-- Slide number: 53 -->
# IoT Software – An Overview
An IoT solution typically involves numerous devices (referred to as "things"), which may utilize gateways to establish communication through a network. This network connects to an enterprise back-end server running an IoT platform, which facilitates the integration of IoT data into the existing enterprise infrastructure. The devices, gateways, and cloud platform have clearly defined roles, each providing specific features and functionalities necessary for a reliable and effective IoT solution.

![A diagram of a cloud Description automatically generated](Picture3.jpg)
53
Source: https://iot.eclipse.org/community/resources/white-papers/

<!-- Slide number: 54 -->
# IoT Software – Sensors & Actuators
The "Thing" serves as the initial component in an IoT solution, typically generating data and interacting with the physical world. Things are often constrained in terms of size and power supply, hence they commonly utilize microcontrollers (MCUs) with limited capabilities. These MCUs are specialized for specific tasks, designed for cost-effective mass production. The software running on MCU-based devices is tailored to support specific functions. Key features of the software stack on such devices may include:
IoT Operating System: While many devices operate without an operating system, some incorporate embedded or real-time operating systems specifically suited for small, constrained devices, offering IoT-specific capabilities.
Hardware Abstraction: This software layer allows access to MCU's hardware features, such as flash memory, GPIOs, and serial interfaces, abstracting their complexities.
Communication Support: Drivers and protocols facilitate device connectivity to wired or wireless protocols like Bluetooth, Z-Wave, Thread, CAN bus, MQTT, CoAP, enabling efficient device communication.
Remote Management: The capability to remotely control the device, enabling firmware upgrades or battery level monitoring, ensuring efficient device management.

![A screenshot of a computer program Description automatically generated](Picture4.jpg)
Source: https://iot.eclipse.org/community/resources/white-papers/
54

<!-- Slide number: 55 -->
# IoT Software – Gateways
The IoT gateway serves as the central hub for a group of sensors and actuators, facilitating their connectivity with each other and external networks. It can manifest as a physical hardware device or as a functional component integrated within a larger "Thing" connected to the network. Examples of gateways include industrial machines, connected automobiles, or home automation appliances.
An IoT gateway often provides data processing and storage capabilities at the edge to handle network latency and ensure reliability. It addresses interoperability challenges between incompatible devices for device-to-device connectivity. In a typical IoT architecture, multiple IoT gateways support numerous devices, forming a scalable infrastructure.

![A screenshot of a computer program Description automatically generated](Picture2.jpg)
Source: https://iot.eclipse.org/community/resources/white-papers/
55

<!-- Slide number: 56 -->
# IoT Software – Gateways
IoT gateways are increasingly reliant on software to implement their core functionalities. The essential features of a gateway's software stack include:
Operating System: Typically, a general-purpose operating system like Linux is employed as the foundation for the gateway software.
Application Container or Runtime Environment: IoT gateways often possess the capability to execute application code and allow dynamic updates. For instance, gateways may support languages such as Java, Python, or Node.js.
Communication and Connectivity: IoT gateways need to support various connectivity protocols to interact with different devices (e.g., Bluetooth, Wi-Fi, Z-Wave, ZigBee, Thread). They also require the ability to connect to different network types (e.g., Ethernet, cellular, Wi-Fi, satellite) while ensuring reliable, secure, and confidential communication.
Data Management & Messaging: Gateway software incorporates local data persistence to support scenarios involving network latency, offline mode, and real-time analytics at the edge. Additionally, it facilitates consistent forwarding of device data to an IoT platform.
Remote Management: The gateway software enables remote provisioning, configuration, and startup/shutdown of gateways, along with managing the applications running on them. This functionality empowers administrators to perform tasks remotely for efficient gateway management.

![A screenshot of a computer program Description automatically generated](Picture2.jpg)
Source: https://iot.eclipse.org/community/resources/white-papers/
56

<!-- Slide number: 57 -->
# IoT Software – Cloud & Platforms
An IoT Platform serves as the software infrastructure and service framework necessary to enable IoT solutions. They mainly operate on Cloud Infrastructures (such as OpenShift, AWS, Microsoft Azure, or Cloud Foundry) or within an enterprise data center. The platform is designed to scale horizontally, accommodating the large number of connected devices, as well as vertically to cater to the diverse range of IoT solutions. Additionally, the IoT Cloud Platform facilitates interoperability between the IoT solution and existing enterprise applications, as well as other IoT solutions.
The essential functionalities of an IoT Cloud Platform include:
Connectivity and Message Routing
Device Management and Device Registry
Data Management and Storage
Event Management, Analytics & User Interface
Application Enablement
IoT platforms are not only in the Cloud ! We will talk about that aspect in a dedicated Lecture :)

![A blue rectangular box with text Description automatically generated](Picture3.jpg)
Source: https://iot.eclipse.org/community/resources/white-papers/
57

<!-- Slide number: 58 -->
# IoT Software – Cloud & Platforms
Connectivity and Message Routing: IoT platforms must effectively interact with a vast number of devices and gateways, supporting various protocols and data formats. They normalize and integrate this data for seamless integration with the enterprise systems.
Device Management and Device Registry: The platform provides a central registry for identifying devices and gateways within the IoT solution. It enables device provisioning, software updates, and overall management of devices.
Data Management and Storage: An IoT Cloud Platform incorporates a scalable data store capable of handling the volume and variety of IoT data generated. It ensures efficient storage, retrieval, and management of the data.
Event Management, Analytics & User Interface: The platform offers scalable event processing capabilities, enabling the consolidation, analysis, and interpretation of IoT data. It facilitates the creation of reports, graphs, dashboards, and user interfaces to visualize and gain insights from the data.
Application Enablement: The IoT Cloud Platform allows the creation of custom reports, graphs, dashboards, and provides APIs for seamless application integration. It empowers developers to leverage the platform's capabilities for application development and integration.

![A blue rectangular box with text Description automatically generated](Picture3.jpg)
Source: https://iot.eclipse.org/community/resources/white-papers/
58

<!-- Slide number: 59 -->
# IoT Software – Cross-Stack Functionalities

![A screenshot of a computer Description automatically generated](Picture6.jpg)
Source: https://iot.eclipse.org/community/resources/white-papers/
59

<!-- Slide number: 60 -->
# IoT Software – Cross-Stack Functionalities
Within an IoT solution, various features must be taken into consideration across different stacks of the architecture, including:
Security: Implementing robust security measures throughout the entire IoT ecosystem is crucial. This involves incorporating authentication, encryption, and authorization features at each level, from devices to the cloud.
Ontologies: Establishing a standardized format and description for device data is essential for enabling effective data analytics and promoting data interoperability. The ability to define ontologies and metadata that can span across diverse domains is a significant focus in the IoT realm.
Development Tools and SDKs: IoT developers require appropriate development tools that support the wide range of hardware and software platforms involved in IoT solutions. These tools aid in streamlining the development process and ensuring compatibility across different platforms.
Source: https://iot.eclipse.org/community/resources/white-papers/
60

<!-- Slide number: 61 -->
# IoT Software – Key Characteristics
There are certain shared characteristics that should be embraced by every IoT stack, including:
Loosely Coupled: Each IoT stack should have the ability to function independently of other stacks. It should be possible to utilize an IoT Cloud Platform from one provider, an IoT gateway from another provider, and a device stack from a third provider, enabling flexibility and interoperability.
Modular: Each stack should allow for the selection and integration of features from different suppliers. This modular approach facilitates customization and the ability to choose components that best fit the specific IoT solution requirements.
Platform-Independent: Each stack should be agnostic to the underlying hardware and cloud infrastructure. For example, the device stack should be compatible with multiple microcontrollers (MCUs), while the IoT Cloud Platform should be adaptable to different Cloud Platform as a Service (PaaS) offerings.
Based on Open Standards: Communication between the stacks should be based on open standards, ensuring interoperability and compatibility across different IoT components. Open standards foster collaboration and the creation of ecosystems that promote seamless integration.
Defined APIs: Each stack should provide well-defined Application Programming Interfaces (APIs) that enable easy integration with existing applications and facilitate interoperability with other IoT solutions. These APIs simplify the development and integration processes, promoting efficient connectivity and data exchange.

![A black and white icon of a ship Description automatically generated](Picture3.jpg)
61

<!-- Slide number: 62 -->
# (Some) References
White Paper: DevOps for Developing Cyber-Physical Systems. https://www.iks.fraunhofer.de/en/publications/whitepapers-studies/whitepaper-devops-cyber-physical-systems.html
What is the difference between CPS and IoT ? https://blog.engineering.vanderbilt.edu/what-is-the-difference-between-cps-and-iot
Example of Industry 4.0 Use Cases: https://www.linkedin.com/pulse/examples-industry-40-use-cases-luka-kozamernik/
Cyber-Physical Systems: https://www.nist.gov/itl/ssd/cyber-physical-systems
Safety and Security of Cyber-Physical Systems. Engineering dependable Software using Principle-based Development. https://link.springer.com/book/10.1007/978-3-658-37182-1
Introduction to Cyber-Physical Systems: https://www.geeksforgeeks.org/introduction-to-cyber-physical-system/
Melanie Schranz, Gianni A. Di Caro, Thomas Schmickl, Wilfried Elmenreich, Farshad Arvin, Ahmet Şekercioğlu, Micha Sende. Swarm Intelligence and cyber-physical systems: Concepts, challenges and future trends. Swarm and Evolutionary Computation, Volume 60, 2021, 100762, ISSN 2210-6502, https://doi.org/10.1016/j.swevo.2020.100762.
E.A. Lee, Cyber physical systems: design challenges. Proceedings of the Eleventh IEEE International Symposium on Object Oriented Real-Time Distributed Computing (2008), pp. 363-369
N. S. Foundation, Cyber physical systems, (https://www.nsf.gov/funding/pgm_summ.jsp?pims_id=503286)
C.B. Nielsen, P.G. Larsen, J. Fitzgerald, J. Woodcock, J. Peleska. Systems of systems engineering: basic concepts, model-based techniques, and research directions. ACM Comput. Surv., 48 (2) (2015)
Y. Liu, Y. Peng, B. Wang, S. Yao, Z. Liu. Review on cyber-physical systems. IEEE/CAA J. Autom. Sin., 4 (1) (2017), pp. 27-40
The Three Software Stacks Required for IoT Architectures: https://iot.eclipse.org/community/resources/white-papers/pdf/Eclipse%20IoT%20White%20Paper%20-%20The%20Three%20Software%20Stacks%20Required%20for%20IoT%20Architectures.pdf
Open Source Software in Industry 4.0: https://iot.eclipse.org/community/resources/white-papers/pdf/Eclipse%20IoT%20White%20Paper%20-%20Open%20Source%20Software%20for%20Industry%204.0.pdf
62

<!-- Slide number: 63 -->

![1280px-Logo_Università_degli_Studi_di_Modena_e_Reggio_Emilia.svg.png](1280pxLogo_Università_degli_Studi_di_Modena_e_Reggio_Emiliasvgpng.jpg)

Distributed and Internet of Things Software Architectures
Digital Automation Engineering (D.M.270/04)
Curriculum: Digital Infrastructure
 Cyber-Physical Systems &
Internet of Things
Prof. Marco Picone
A.A 2025/2026
63
