<!-- omit in toc -->
# Lecture 8 - Microservices Software Architectures

<!-- omit in toc -->
## Lecture Information

| **Master's Degree** | Digital Automation Engineering (D.M.270/04)                                      |
|---------------------|----------------------------------------------------------------------------------|
| **Curriculum**      | Digital Infrastructure                                                           |
| **Course**          | Distributed IoT Software Architectures                                           |
| **Lecture Title**   | Microservices Software Architectures                                             |
| **Author**          | Prof. Marco Picone (marco.picone@unimore.it)                                     |
| **License**         | [Creative Commons Attribution 4.0](https://creativecommons.org/licenses/by/4.0/) | 


<!-- omit in toc -->
# Table of Contents

- [7.1 Distributed Software Architectures - A Definition](#71-distributed-software-architectures---a-definition)
- [7.2 Distributed Software Architectures - Fallacies](#72-distributed-software-architectures---fallacies)
  - [7.2.1 Fallacy 1 - The network is reliable](#721-fallacy-1---the-network-is-reliable)
  - [7.2.2 Fallacy 2 - Latency is zero](#722-fallacy-2---latency-is-zero)
  - [7.2.3 Fallacy 3 - Bandwidth is infinite](#723-fallacy-3---bandwidth-is-infinite)
  - [7.2.3.1 Stamp Coupling](#7231-stamp-coupling)
  - [7.2.4 Fallacy 4 - The network is secure](#724-fallacy-4---the-network-is-secure)
  - [7.2.5 Fallacy 5 - Topology doesn't change](#725-fallacy-5---topology-doesnt-change)
  - [7.2.6 Fallacy 6 - There is one administrator](#726-fallacy-6---there-is-one-administrator)
  - [7.2.7 Fallacy 7 - Transport cost is zero](#727-fallacy-7---transport-cost-is-zero)
  - [7.2.8 Fallacy 8 - The network is homogeneous](#728-fallacy-8---the-network-is-homogeneous)
- [7.3 Additional Distributed Challenges](#73-additional-distributed-challenges)
  - [7.3.1 Distributed Transactions](#731-distributed-transactions)
- [7.4 Service-based Architecture](#74-service-based-architecture)
  - [7.4.1 Topology Characteristics](#741-topology-characteristics)
  - [7.4.2 Topology Variants](#742-topology-variants)
  - [7.4.2 Service-based Architecture - Summary \& Rating](#742-service-based-architecture---summary--rating)
- [7.5 Event-Driven Architecture](#75-event-driven-architecture)
  - [7.5.1 Event-Driven Architecture - Topology Characteristics](#751-event-driven-architecture---topology-characteristics)
  - [7.5.2 Event-Driven Architecture - Broker Topology](#752-event-driven-architecture---broker-topology)
  - [7.5.3 Event-Driven Architecture - Mediator Topology](#753-event-driven-architecture---mediator-topology)
  - [7.5.4 Event-Driven Architecture - Topologies Comparison Summary](#754-event-driven-architecture---topologies-comparison-summary)
  - [7.5.5 Event-Driven Architecture - Other Aspects](#755-event-driven-architecture---other-aspects)
  - [7.5.6 Choosing Between Request-Based and Event-Based](#756-choosing-between-request-based-and-event-based)
  - [7.5.7 Event-Driven Architecture - Summary \& Rating](#757-event-driven-architecture---summary--rating)
- [7.6 Serverless Architecture](#76-serverless-architecture)
  - [7.6.1 Serverless Architecture - Key Terms \& Design Concepts](#761-serverless-architecture---key-terms--design-concepts)
  - [7.6.2 Serverless Architecture - Benefits \& Challenges](#762-serverless-architecture---benefits--challenges)
- [References](#references)
  
# 8.1 Microservices Software Architectures - Introduction

![](images/microservice_idea.png)

**Figure 8.1:** High-level overview of a Microservices Architecture.

**Microservices architecture** is a service-oriented approach that structures applications as a collection of **loosely coupled, autonomous services** rather than a single monolithic codebase.

**Key characteristics:**

- **Decomposition**: Applications are split into small, independent services that communicate over well-defined APIs
- **Autonomy**: Each microservice operates independently with its own business logic, data storage, and deployment cycle
- **Technology diversity**: Services can use different architectures, frameworks, and adapters based on their specific needs
- **Communication patterns**: Services interact through:
  - **REST APIs** for synchronous request-response
  - **RPC (Remote Procedure Call)** for direct service invocation
  - **Message-based protocols** for asynchronous communication
- **Interface types**: Services may expose various interfaces including APIs for backend communication or web UIs for user interaction

---

# 8.2 Microservices Architecture - Definitions and Citations

![](images/microservice_definitions_citations.png)

**Figure 8.2:** Definitions and citations related to Microservices Architecture.

**Core Principle**: Microservices architecture requires **independent, modular components** to be effective.

**Key considerations:**

- **Without modularity**: Systems become tightly coupled and low-cohesion "Frankensteins" that are difficult to:
  - Develop and deliver
  - Deploy and run
  - Maintain and evolve

- **Primary design goal**: Each service should solve its **specific business capability** in the most optimal way possible

- **Independence is critical**: True microservices must operate autonomously without creating unnecessary dependencies that negate architectural benefits

---

# 8.3 Microservices Architecture - Benefits & Drawbacks

**Benefits:**

- **Decomposition & Manageability**: Applications are broken into smaller, focused services that are faster to develop, easier to understand, and simpler to maintain
- **Independent Development**: Each service can be developed by a dedicated team working autonomously on their specific business capability
- **Technology Flexibility**: Teams can choose the most appropriate technology stack for each service without being constrained by legacy decisions
- **Independent Deployment**: Services can be deployed separately, enabling continuous deployment practices even for complex applications
- **Granular Scalability**: Each service can be scaled independently based on its specific resource requirements and load patterns

**Drawbacks:**

- **Increased Complexity**: Operating a distributed system introduces inherent challenges in network communication, error handling, and service coordination
- **Distributed Data Management**: Each service maintains its own database, making cross-service transactions and data consistency significantly more complex
- **Testing Overhead**: Testing requires coordinating multiple services, managing dependencies, and validating integration points across the distributed system
- **Coordinated Changes**: Multi-service updates demand careful planning, versioning strategies, and synchronized rollout procedures to maintain system stability
- **Deployment Complexity**: Managing numerous service instances requires sophisticated orchestration for configuration, deployment, scaling, and monitoring operations

---

# 8.4 Monolithic vs Microservices Architecture - How to start ?

![](images/hope_vs_reality_microservices.png)

**Figure 8.3:** Hope vs Reality when starting with Microservices ([Source-Link](https://martinfowler.com/articles/dont-start-monolith.html)).

You can begin designing a monolithic application with a set of well-defined, smaller services that are integrated into the larger system, ready to be extracted for a transition to a microservices architecture. 

However, in practice, it is challenging to avoid creating numerous connections—both planned and unplanned. The essence of the microservices approach is to minimize such dependencies.

**Key Considerations:**

- **Subsystem Independence**: If the project is substantial, consider the subsystems you are building and aim to develop them as independently as possible.
- **Early Separation**: From the outset, adopt a strategy that divides your system into smaller components, treating each as a distinct entity with:
  - Its own development cycle
  - Its own deployment cycle
  - Its own internal architecture

This approach is a powerful concept that facilitates delivery, maintenance, and extension of the system.

Sometimes Microservices can be really complex in particular for big companies as Amazon and Netflix as depicted in the following figure.

![](images/amazon_netflix_microservices.png)

**Figure 8.4:** Some (Super) Complex Microservices Examples.

---

# References

- Fundamentals of Software Architecture: An Engineering Approach, by Mark Richards, Benjamin Lange, Neal Ford, Released February 2021, ISBN: 9781663728357
- Monolithic vs Microservices - [Link](https://articles.microservices.com/monolithic-vs-microservices-architecture-5c4848858f59)
- Pattern: Microservice Architecture - [Link](https://microservices.io/patterns/microservices.html)
- Monolithic Architecture - [Link](https://microservices.io/patterns/monolithic.html)
- Don’t start with Monolith - [Link](https://martinfowler.com/articles/dont-start-monolith.html)
- Monolithic vs Microservice and all in between - [Link](https://medium.com/swlh/monolithic-vs-micro-services-and-all-in-between-7d496408ad02)
- Best Architecture for an MVP: Monolith, SOA, Microservices, or Serverless? - [Link](https://rubygarage.org/blog/monolith-soa-microservices-serverless)
- Microservices Introduction (Monolithic vs. Microservice Architecture) - [Link](https://dzone.com/articles/microservices-1-introduction-monolithic-vs-microservices)
- How to break a Monolith into Microservices - [Link](https://martinfowler.com/articles/break-monolith-into-microservices.html)
- Serverless Design Architecture: [Link](https://www.trendmicro.com/it_it/devops/23/f/serverless-architecture-design-patterns-guide.html)
- Serverless Architecture: [Link](https://middleware.io/blog/serverless-architecture/)
- A Guide to Serverless Architecture: [Link](https://www.serverless.com/blog/serverless-architecture)

