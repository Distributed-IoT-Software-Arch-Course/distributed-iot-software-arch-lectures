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


> The students of Carnegie Mellon University invent the ARPANET-connected coke machine. Four students from the School of Computer Science 
> department installed the switches in the coke machine. They counted how many coke bottles had remained in each row and for how long. If the 
> loaded bottle spends a long time in the machine, it is labeled “cold”. All this data was then remotely available to customers via a finger 
> interface. This experiment had inspired a lot of inventors all over the world to create their own connected appliances.


![Connected Drink Machine](images/Lecture1/drink_machine.png)
CSE3002 Team Project History of Internet of Things (IoT) Devices and Their Influence on Cyber Security Team F Christopher Byars Dylan Leonard Brian Patino 
**Sources:** [Link1](https://slideplayer.com/slide/14090495/), [Link2](https://hqsoftwarelab.com/blog/the-history-of-iot-a-comprehensive-timeline-of-major-events-infographic/)


## The First "Connected Devices" - The XCoffee


> The XCoffee is created at the Computer Laboratory of the University of Cambridge. Two academics who worked at the Trojan Room in the 
> laboratory had a video-frame grabber attached to one of the computers. They decided to connect a camera controlled by a server application 
> that was observing the coffee pot and taking pictures of it several times a minute. Then the pictures were sent to the client application, to 
> keep the user updated on the information about whether the pot was filled.

![XCoffee Machine](images/Lecture1/xcoffee.png)

**Sources:** [Link1](https://www.cl.cam.ac.uk/coffee/qsf/coffee.html), [Link2](https://odannyboy.medium.com/the-first-things-on-the-internet-of-things-5d817d45ac9c),[Link3](https://hqsoftwarelab.com/blog/the-history-of-iot-a-comprehensive-timeline-of-major-events-infographic/)

## The Mobile Centric World

The mobile revolution is changing the way we live, work, and interact. Mobile devices have become an integral part of our daily lives, enabling us to stay connected, access information, and perform various tasks on the go. The proliferation of smartphones, tablets, and wearable devices has transformed communication, entertainment, and productivity, making it easier than ever to stay connected to the world around us.

In the picture below, you can see how the mobile revolution has transformed St. Peter's Square in Vatican City. The left image from 2005 shows a traditional gathering of people, while the right image from 2013 captures a sea of mobile devices held up by attendees, highlighting the significant impact of mobile technology on social interactions and events.

>What a difference 8 years makes: St. Peter’s Square in 2005 and yesterday (2013)” 
(Facebook NBC News)

![Piazza San Pietro - The Mobile Revolution](images/Lecture1/piazza_san_pietro.png)

This image hides an interesting aspect on what we are not seeing and able to support this massive number of mobile devices. The answer is the **Network and Internet infrastructures, which are the backbone of the mobile revolution and are able to support the increasing demand for data and connectivity combined with Cloud Computing infrastructures and services**.

Those infrastructures evolved a lot in the last 20 years, and they are still evolving to support the new requirements of the mobile world and as we will see in this course, the Internet of Things world.

Another interesting example is the event of the concert of Vasco Rossi in Modena Park, July 2017, where more than 230K people attended the event and almost all of them were using their mobile devices to share the event in real time.

![Vasco Rossi Concert, Modena Park](images/Lecture1/olivetti_modena_park.png)

230K Devices at Vasco Rossi Concert @ Modena Park - July 2017 Source: https://www.digitaldata.olivetti.com/timbigdata/concerto-di-vasco-rossi

This is another example of how the mobile revolution is changing the way we live and interact, and how the underlying network and internet infrastructures are crucial to support this massive connectivity.

### Mobile & Wearable Computing

Another interesting aspect of the mobile revolution is the rise of wearable computing devices, such as smartwatches, fitness trackers, and augmented reality glasses. These devices are designed to be worn on the body and provide users with real-time access to information, notifications, and health monitoring features.

![Wearable Computing](images/Lecture1/wearable_computing.png)

Nowadays, we are not just associated to one or two mobile devices, but we are surrounded by a plethora of connected devices that are becoming an integral part of our daily lives. From smart home devices to connected cars, the Internet of Things (IoT) is transforming the way we interact with our environment and the world around us. 

This devices creates a new paradigm where the physical and digital worlds are increasingly interconnected, leading to new opportunities and challenges in terms of connectivity, security, and data management.


# Cyber–Physical Systems

In this context, **Cyber-Physical Systems (CPS)** play a crucial role in bridging the gap between the physical and digital worlds. CPS are systems that integrate computation, networking, and physical processes to enable real-time monitoring, control, and interaction with the physical environment.

> A **Cyber-Physical System (CPS)** refers to integrated systems that combine computational elements with physical components, enabling the interaction and collaboration between the digital and physical worlds. 
> CPS typically involve a network of **sensors**, **actuators**, and **computational devices** that **collect data** from the physical environment, **process** it, and **control** physical processes or objects.

![Cyber-Physical Systems (CPS)](images/Lecture1/cps_highlevel_overview.png)

Typically, CPS are characterized by the following features:
- **Integration of Physical and Cyber Components**: CPS seamlessly integrate physical components (sensors, actuators, etc.) with cyber components (computers, networks, software) to enable real-time monitoring and control of physical processes.
- **Real-Time Interaction**: CPS are designed to operate in real-time, allowing for immediate response to changes in the physical environment and enabling dynamic interactions between the physical and digital worlds.
- **Networked Communication**: CPS rely on networked communication to facilitate data exchange and coordination between distributed components, enabling collaboration and coordination across different physical locations.
- **Autonomy and Adaptability**: CPS often incorporate autonomous decision-making capabilities, allowing them to adapt to changing conditions and optimize performance based on real-time data.
- **Safety and Reliability**: CPS are often deployed in safety-critical applications, requiring robust safety and reliability measures to ensure the integrity and security of both physical and cyber components. 

![Cyber-Physical Systems (CPS)](images/Lecture1/cps_phases.png)

As illustrated in the figure above, CPS typically involve the following phases:
1. **Persive**: In this phase, sensors collect data from the physical environment, such as temperature, pressure, or motion.
2. **Analyze**: The collected data is then processed and analyzed using computational algorithms to extract meaningful insights and patterns.
3. **Learn**: Learning techniques may be applied to enable the system to learn from historical data and improve its performance over time.
4. **Plan**: Based on the analysis and learning, the system can plan actions or responses to be taken in the physical environment.
5. **Act**: Finally, actuators are used to execute the planned actions, such as adjusting a thermostat, controlling a robotic arm, or activating an alarm. 

**Note:** After the action phase, the cycle continues with the system continuously perceiving, analyzing, learning, planning, and acting in a dynamic and adaptive manner.