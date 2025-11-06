<!-- omit in toc -->
# Lecture 7 - Software Architectures Distributed Approaches

<!-- omit in toc -->
## Lecture Information

| **Master's Degree** | Digital Automation Engineering (D.M.270/04)                                      |
|---------------------|----------------------------------------------------------------------------------|
| **Curriculum**      | Digital Infrastructure                                                           |
| **Course**          | Distributed IoT Software Architectures                                           |
| **Lecture Title**   | Software Architectures Distributed Approaches                                    |
| **Author**          | Prof. Marco Picone (marco.picone@unimore.it)                                     |
| **License**         | [Creative Commons Attribution 4.0](https://creativecommons.org/licenses/by/4.0/) | 


<!-- omit in toc -->
# Table of Contents

- [6.1 Software Architecture - A Definition](#61-software-architecture---a-definition)
- [6.2 Software Architecture - Characteristics](#62-software-architecture---characteristics)
  - [6.2.1 Operational Characteristics](#621-operational-characteristics)
  - [6.2.2 Operational Architecture Characteristics \& DevOps](#622-operational-architecture-characteristics--devops)
  - [6.2.3 Structural Architecture Characteristics](#623-structural-architecture-characteristics)
  - [6.2.4 Cross-Cutting Architecture Characteristics](#624-cross-cutting-architecture-characteristics)
- [6.3 Extracting Software Architecture Characteristics](#63-extracting-software-architecture-characteristics)
- [6.4 Software Architecture Foundations](#64-software-architecture-foundations)
  - [6.4.1 Anti-Patterns - The Big Ball of Mud](#641-anti-patterns---the-big-ball-of-mud)
  - [6.4.2 Anti-Patterns - Additional Comments](#642-anti-patterns---additional-comments)
  - [6.4.3 Simple Patterns - Unitary Architecture](#643-simple-patterns---unitary-architecture)
  - [6.4.4 Simple Patterns - Client Server Architecture](#644-simple-patterns---client-server-architecture)
  - [6.4.5 Simple Patterns - Three-Tier Architecture](#645-simple-patterns---three-tier-architecture)
  - [6.4.6 Software Architecture - Main Categories](#646-software-architecture---main-categories)
- [6.5 Software Architecture - Monolithic](#65-software-architecture---monolithic)
  - [6.5.1 Monolithic Software Architecture - Layered Architecture](#651-monolithic-software-architecture---layered-architecture)
  - [6.5.1.1 Layered Architecture - Topology](#6511-layered-architecture---topology)
  - [6.5.1.2 Layered Architecture - Discussion](#6512-layered-architecture---discussion)
  - [6.5.1.3 Layered Architecture - Rating](#6513-layered-architecture---rating)
- [6.6 Software Architecture - Pipeline](#66-software-architecture---pipeline)
  - [6.6.1 Pipeline Architecture - Components](#661-pipeline-architecture---components)
  - [6.6.2 Pipeline Architecture \& ETL Processing](#662-pipeline-architecture--etl-processing)
  - [6.6.2 An IoT ETL Example](#662-an-iot-etl-example)
  - [6.6.3 Pipeline Architecture \& ETL Rating](#663-pipeline-architecture--etl-rating)
  - [6.7 Software Architecture - Microkernel](#67-software-architecture---microkernel)
    - [6.7.1 Microkernel Topology](#671-microkernel-topology)
    - [6.7.2 Microkernel Plugin Components](#672-microkernel-plugin-components)
    - [6.7.3 Microkernel - Plugin Registry](#673-microkernel---plugin-registry)
    - [6.7.3 Microkernel - Plugin Contacts](#673-microkernel---plugin-contacts)
    - [6.7.3 Microkernel - Rating](#673-microkernel---rating)
- [References](#references)
  
# 7.1 Distributed Software Architectures - A Definition

**Distributed Software Architecture** refers to the design and organization of software systems that are distributed across multiple computing nodes, which may be located in the same physical environment or spread across different geographical locations. This architectural style emphasizes the interactions and communication between distributed components, enabling them to work together to achieve common goals.

Several common styles exist for distributed software architectures. Key approaches include:

- **Service-based architecture** — system decomposed into coarse-grained services that expose functionality via well-defined interfaces.  
- **Event-driven architecture** — components interact asynchronously by emitting and consuming events, improving decoupling and scalability.  
- **Space-based architecture** — components coordinate through a distributed shared space (e.g., tuple space) to avoid bottlenecks.  
- **Service-oriented architecture (SOA)** — integration of reusable services across an enterprise, often via standard contracts and middleware.  
- **Microservices architecture** — many small, independently deployable services, each owning its data and lifecycle.  
- **Serverless architecture** — function-as-a-service model with event-triggered execution and managed scaling.

Course coverage (levels of detail):  

- **Service-based** — introduced and discussed.  
- **Event-driven** — introduced and discussed.  
- **Microservices** — **in-depth: dedicated lectures, hands-on sessions, and laboratory work.**  
- **Serverless** — introduced and discussed.

---

# 7.2 Distributed Software Architectures - Fallacies

Distributed architectures provide superior **performance**, **scalability**, and **availability** compared to monoliths — but they introduce **important trade‑offs** summarized by the **"Eight Fallacies of Distributed Computing" (L. Peter Deutsch et al., Sun Microsystems, 1994)**. 

A **fallacy** is an assumption believed to be true but not reliable in practice. 
The eight fallacies are:

- **The network is reliable** — networks fail; design for retries, timeouts, and graceful degradation.  
- **Latency is zero** — communication incurs delay; prefer asynchronous patterns, batching, and locality.  
- **Bandwidth is infinite** — throughput is limited; minimize payloads, compress, and avoid chatty protocols.  
- **The network is secure** — assume it is untrusted; enforce authentication, authorization, and encryption.  
- **Topology doesn't change** — nodes and routes can change; support discovery and dynamic configuration.  
- **There is one administrator** — systems span multiple administrative domains; handle differing policies and access controls.  
- **Transport cost is zero** — network usage has latency and monetary cost; reduce unnecessary transfers and optimize transfers.  
- **The network is homogeneous** — environments differ in hardware, OS, and middleware; design for interoperability and portability.

---

## 7.2.1 Fallacy 1 - The network is reliable

![](images/fallacy_1.png)

**Figure 7.1:** Schematic example of the unreliability of networks.

Developers often assume the **network is reliable** — but it isn’t. 
**Design distributed systems assuming transient and partial failures.**

- **Reality:** networks experience drops, delays, partitions, DNS failures and intermittent outages.
- **Impact:** any architecture that relies on remote communication can fail if the network misbehaves.
- **Mitigations:** use for example:
  - **timeouts:** set reasonable timeouts for operations to avoid hanging indefinitely.
  - **retries with backoff:** retry failed operations with exponential backoff to avoid overwhelming the network.
  - **circuit breakers:** stop trying to reach a failing service after repeated failures, allowing it time to recover.
  - **idempotent operations:** design operations that can be safely retried without unintended side effects.
  - **caching:** store responses to avoid repeated network calls.
  - **graceful degradation:** provide fallback options when services are unavailable.
- **Design principle:** minimize synchronous network dependencies, isolate failures (bulkheads), and improve observability to detect and recover quickly.
- **Trade-off:** the more a system depends on the network (e.g., many microservices), the larger its exposure to network faults — design for resilience accordingly.

---

## 7.2.2 Fallacy 2 - Latency is zero

![](images/fallacy_2.png)

**Figure 7.2:** Example of local vs remote latency and their impact.

Developers often assume **latency is zero** in distributed systems — but it isn’t.
Relationships between components over a network introduce non-negligible delays and the following considerations apply:

- **Local vs remote latency**
  - `T_local` (local method/function call) is typically in **nanoseconds (ns)** or **microseconds (µs)**.
  - `T_remote` (REST, messaging, RPC) is typically in **milliseconds (ms)** and **always greater than _local**.
  - Conclusion: **latency is not zero** in distributed systems.

- **Why this matters**
  - Architects must measure the **average round‑trip latency** in the production environment (e.g., 60 ms vs 500 ms) to decide if a distributed design is feasible.
  - Microservices amplify the issue because many fine‑grained calls can accumulate latency.

- **Simple calculation**
  - If average latency = **100 ms** per request, chaining **10** synchronous service calls adds **≈1,000 ms** to the user request.

- **Percentiles and the long tail**
  - Average latency is useful, but **95th–99th percentiles** are critical. An average of **60 ms** with a **95th = 400 ms** will cause real-world performance problems.
  - Design for the **long tail**: measure and mitigate high-percentile latencies.

- **Mitigations (brief)**
  - Prefer **asynchronous calls**, **batching**, **caching**, **locality**, and **aggregation** to reduce synchronous call chains and exposure to network latency.


---

## 7.2.3 Fallacy 3 - Bandwidth is infinite

![](images/fallacy_3.png)

**Figure 7.3:** Example of bandwidth consumption in distributed systems.

Bandwidth is typically negligible inside a **monolith**, but in **distributed** architectures inter‑service communication can consume significant bandwidth and degrade latency and reliability.

**Example**

- Service A: manages IoT devices.  
- Service B: manages deployment/configuration.  
- Service B returns 45 attributes ≈ **500 KB**, while Service A needs only the location ≈ **200 B** — an instance of **stamp coupling** (sending more data than required).
- At **2,000 requests/s**: 500 KB × 2,000 = 1,000,000 KB/s = **1,000 MB/s ≈ 1 GB/s** (≈ 8 Gbit/s) consumed just for that single interservice call.

**Impacts**

- Increased latency (*fallacy #2*), network congestion and cost, higher failure and reduced reliability (*fallacy #1*).
- **Stamp coupling** occurs when a service sends more data than the receiving service actually needs. This can lead to inefficient use of network resources, increased latency, and higher costs, especially in high-throughput systems.

**Mitigations**

- **Partial responses / field selection** (return only required fields).  
- **Compression** or compact binary formats.  
- **Caching** and co‑location of services.  
- **Aggregation / batching** and asynchronous messaging to reduce chatty calls.  
- Clear data ownership and API design to avoid unnecessary transfers.

**Design principle:** assume bandwidth is limited — minimize payload size and chatty interactions (where and when possible).

---

## 7.2.3.1 Stamp Coupling

![](images/fallacy_3_stamp_coupling.png)

**Figure 7.4:** Simple example of stamp coupling and data structures.

**Stamp coupling** occurs when modules exchange large or composite data structures (records/objects) but each module uses only part of the data. This creates unnecessary dependencies and reduces modularity.

**Key points:**

- **Problem:** receiving modules become coupled to the structure and unused fields; changes to the shared structure can force widespread updates.
- **Consequences:** harder maintenance, larger payloads, increased bandwidth and risk of unintended side effects.
- **Mitigations:** 
  - Pass only the **fields required** (field selection or small DTOs).  
  - Define **clear, minimal interfaces** or contracts.  
  - Keep data structures **cohesive** and focused on a single concept.

**Example:**

- **Good (Left):** separate, self-contained structures per sensor type (temperature, humidity, light) — each module receives exactly what it needs.  
- **Bad (Right):** one large structure containing all sensor fields — modules receive irrelevant data, increasing coupling and fragility.

**Example:** if Service B returns only the location (~200 B) instead of a full 500 KB record, at 2,000 req/s that saves roughly 400 KB/s of bandwidth.

**Mitigations Examples**
- **Private REST endpoints** — expose minimal, purpose-specific endpoints for internal consumers.  
- **Field selectors / partial responses** — allow callers to request only required fields (query params or Accept headers).  
- **GraphQL / similar query layers** — let clients specify needed fields dynamically to avoid overfetching.  
- **Consumer-Driven Contracts (CDCs)** — design APIs based on actual consumer needs to keep contracts small and stable.  
- **Internal messaging / events** — publish compact messages (events) or use topics to avoid synchronous transfer of large objects.

**Design principle:** always transfer the minimal, well-defined data necessary; favor clear contracts and co-located logic to reduce bandwidth and coupling.

---

## 7.2.4 Fallacy 4 - The network is secure

![](images/fallacy_4.png)

**Figure 7.5:** Example of the network is secure fallacy.

Most teams assume VPNs and firewalls make the network safe — but **the network is not secure**. 
In distributed architectures security becomes harder and must be designed explicitly.

- **Every endpoint must be protected:** each service instance, management API, and inter‑service interface needs authentication, authorization, input validation and encryption.
- **Attack surface grows:** splitting a monolith into many services multiplies entry points and increases risk.
- **Interservice security matters:** internal traffic can carry threats; treat service-to-service calls as untrusted unless explicitly protected.
- **Operational cost and complexity:** securing all endpoints requires certificates, key management, policy enforcement and monitoring.
- **Performance trade‑offs:** TLS, auth checks and additional middleware add latency, which helps explain why highly synchronous distributed designs can be slower.

**Design guidance (brief):** Adopt defense‑in‑depth and zero‑trust principles by:

- minimizing exposed interfaces
- enforcing strong observability, and automating security configuration to ensure consistent policy enforcement and reduce human error.
- automating security configuration to ensure consistent policy enforcement and reduce human error.

---

## 7.2.5 Fallacy 5 - Topology doesn't change

![](images/fallacy_5.png)

**Figure 7.6:** Topology changes in distributed systems.

**Overall network topology** includes all routers, switches, firewalls, hubs, links, VLANs, load‑balancers and other appliances. 
Architects often assume this topology is fixed — but it changes frequently.

**Key points:**

- **Reality:** topology and network behavior change (configuration updates, firmware upgrades, routing changes, maintenance, failovers).
- **Impact:** seemingly minor infrastructure changes can invalidate **latency** and **bandwidth** assumptions, causing increased response times, timeouts, tripped **circuit breakers**, or unexpected request failures.
- **Examples:** MTU (Maximum Transmission Unit) or QoS (Quality of Service) changes, new firewall rules, route flaps, or a switch firmware update that adds milliseconds of latency or drops packets.

**Mitigations / recommendations:**

- Maintain continuous **communication** between architects, operations, and network admins (planned changes, maintenance windows).
- Use proactive **monitoring** and alerting for latency, packet loss, and topology changes (e.g., synthetic checks, traceroutes).
- Treat network as a dynamic dependency: design with conservative **timeouts**, retries with backoff, **bulkheads**, and graceful degradation.
- Include network change notifications in your **change management** and run performance tests after infra changes to validate assumptions.

**Design principle:** assume topology will change — build observability, coordination and resilience into the architecture to avoid surprises.

---

## 7.2.6 Fallacy 6 - There is one administrator

![](images/fallacy_6.png)

**Figure 7.7:** There is one administrator fallacy.

Large, distributed systems span multiple administrative domains (network, security, cloud, storage, site/network ops, platform teams), each with its own policies and change processes.
The **assumption** of a single administrator **is flawed**.

**Key points:**

- **Reality:** many administrators and teams manage different parts of the infrastructure — you won’t have a single person to contact for latency, routing, or configuration changes.
- **Impact:** assumptions about fast, centralized changes lead to surprises (unplanned topology or policy changes, differing SLAs - Service Level Agreements, delayed rollouts).
- **Consequences:** architects must plan for coordination overhead, scheduled change windows, and inconsistent policies across domains.

**Practical mitigations:**

- **Identify stakeholders** early (network, security, SRE, platform, NOC) and agree on communication and change procedures.
- **Formalize change management** (tickets, rollout plans, runbooks, SLAs) and include performance validation after infra changes.
- **Automate and codify** network/config management where possible (IaC, policy-as-code) to reduce human error and speed coordination.
- **Design for independence** (conservative timeouts, retries, bulkheads, graceful degradation) and add observability/synthetic tests to detect topology or admin-driven changes quickly.

**Design principle:** assume multiple administrators with differing policies — build coordination, observability, and resilience into your architecture to handle changes smoothly.

---

## 7.2.7 Fallacy 7 - Transport cost is zero

![](images/fallacy_7.png)

**Figure 7.8:** Transport cost is zero fallacy.

**Transport cost** here is the actual monetary and resource cost of moving data (not latency). 
Architects often confuse this with latency, but the fallacy concerns real expenses and infrastructure needs when you split a system.

- **Meaning:** network transfers, cross‑zone traffic, cloud egress, additional middleware and appliances all carry direct and operational costs.
- **Why it matters:** distributed designs typically require more hardware and services — load balancers, gateways, proxies, firewalls, extra VMs/containers, new subnets, replication, and more monitoring/ops — which increases both capital and ongoing expenses.
- **Common hidden costs:** cloud egress fees, inter‑AZ transfers, higher bandwidth plans, extra storage/replication, security and certificate management, and increased operational overhead (monitoring, backups, incident response).
- **Practical guidance:**
  - **Audit** current topology (capacity, bandwidth, security zones) and **estimate transfer/egress costs** before decomposing a monolith.
  - **Measure** expected traffic patterns and identify chatty interactions.
  - **Design to reduce transfers:** partial responses/field selection, compression, caching, batching/aggregation, co‑location, and event‑driven or asynchronous patterns.
  - **Budget** for additional infra and operational work (networking, security, SLAs).
- **Principle:** assume transport costs are non‑zero — quantify and plan for them to avoid surprise bills and inadequate infrastructure.

**Design principle:** always consider the real costs of data transfer and infrastructure when designing distributed systems; optimize to minimize unnecessary expenses.

---

## 7.2.8 Fallacy 8 - The network is homogeneous

![](images/fallacy_8.png)

**Figure 7.9:** The network is homogeneous fallacy.

Assuming the **network is homogeneous** (built from a single hardware vendor) **is incorrect**. 
Most organizations run multi‑vendor infrastructures — routers, switches, firewalls, wireless controllers and NICs (Network Interface Cards) from different vendors — so architects must design, test and operate for vendor heterogeneity, firmware differences and interoperability quirks.


- **Reality:** production networks are heterogeneous — multiple vendors, firmware versions, device models, links and configurations coexist.  
- **Implication:** untested combinations and subtle vendor differences can cause interoperability issues (e.g., MTU mismatches, QoS quirks, firmware bugs) that lead to packet loss, jitter and throughput variance.  
- **Effects:** this feeds directly into other fallacies — it undermines **reliability** (Fallacy #1), produces unexpected **latency** spikes and long‑tail behavior (Fallacy #2), and reduces effective **bandwidth** or increases inefficiencies (Fallacy #3).  
- **Practical mitigations:** test realistic vendor mixes, measure percentiles (not just averages), enforce conservative timeouts/retries and bulkheads, standardize/configure critical paths where possible, and design services to tolerate heterogeneity (observability, graceful degradation, and redundancy).

**Design principle:** assume heterogeneity, validate and design for its impacts rather than trusting a single, uniform network stack.

---

# 7.3 Additional Distributed Challenges

In addition to the eight fallacies, distributed systems introduce other practical challenges. Two key areas to remember:

- **Distributed logging**
  - Problem: application and system logs are **scattered across many nodes**, in different locations and formats, making root‑cause analysis and request tracing hard.
  - Impact: correlating events, following a request flow, and diagnosing transient errors become time‑consuming and error‑prone.
  - Mitigations (common practices):
    - **Correlation IDs / request IDs** to link events across services.
    - **Structured logs** (JSON) and consistent schemas for easier parsing and querying.
    - **Centralized collection** (Prometheus, Splunk, Datadog, etc.) for aggregation, searching, and dashboards.
    - **Distributed tracing** (OpenTelemetry, Jaeger) to visualize call graphs and latencies.
    - **Sampling, retention policies, and access controls** to manage volume, cost, and privacy.
  - Note: tooling helps but **doesn’t eliminate** the complexity—design and operational practices are required.

- **Distributed transactions**
  - Problem: maintaining ACID (Atomicity, Consistency, Isolation, Durability) semantics across multiple services and nodes is difficult or impractical.
  - Common approaches: **sagas**, **two‑phase commit (2PC)** where applicable, **idempotency**, and **compensation patterns** to handle partial failures.
  - Design guidance: prefer **explicit eventual consistency**, design compensating actions, and make operations **observable and retryable**.
  - See section 7.3.1 for an IoT transaction example and deeper discussion.

**Design principle:** distributed systems require careful design for logging and transactions; leverage patterns and tools but recognize inherent complexity.
Keep these challenges in mind when decomposing systems: logging and transaction strategies are as important as service boundaries and network considerations.

---

## 7.3.1 Distributed Transactions

**Distributed transaction (definition):** a unit of work that must leave a system in a consistent state across multiple components — either all constituent operations succeed (commit) or the system recovers to a consistent state (rollback/compensation).

Smart‑home IoT example (user leaving house — turn off lights, lock doors, set thermostat):

- **Begin transaction:** user triggers "leave home" action.
  - **Step 1 — Turn off lights:** send commands to light controllers; await acknowledgements.
  - **Step 2 — Lock doors:** send lock commands to door locks/windows; verify sensors/reporting.
  - **Step 3 — Set thermostat:** send setpoint to thermostat; confirm applied mode.
- **Commit:** if all steps succeed, mark the transaction complete and notify the user.
- **Failure handling:** if any step fails (e.g., a lock doesn't engage), do one of:
  - **Rollback** where possible (e.g., revert lights/thermostat), or
  - **Compensating action / Saga** (e.g., alert user, retry with backoff, perform alternative safety steps), because true atomic rollback is often impractical across heterogeneous IoT devices.

**Design considerations:** prefer **idempotent commands**, timeouts, retries, clear **observable** states (ack/nack), user notifications, and compensating workflows to ensure safety and eventual consistency.
In distributed IoT systems, treat transactions as coordinated workflows with explicit success/failure handling (compensation/sagas) rather than assuming instantaneous atomic commits.

---

# 7.4 Service-based Architecture

![](images/soa_1.png)

**Figure 7.10:** Schematic representation of Service-based Architecture.

**Service-based Architecture** (aka **Service‑Oriented Architecture — SOA**) structures a system as a set of network‑accessible, coarse‑grained **services**.
Coarse‑grained means each service encapsulates a significant business capability (e.g., order management, user profile, inventory) rather than fine‑grained functions.
A coarse‑grained service might handle all operations related to user management (registration, authentication, profile updates) rather than just a single function like "validate password". 
A *service* is a self‑contained module that encapsulates a business capability and can be developed, deployed and versioned independently.

**Key points:**

- **Granularity:** coarse‑grained domain services (*larger than microservices*).  
- **Independence:** services are modular and independently deployable (standalone apps or containers).  
- **Access:** remote protocols (REST, RPC, messaging); often fronted by an API gateway.  
- **Data ownership:** commonly uses a **shared/centralized database** (unlike pure microservices).  
- **Trade‑offs:** **pragmatic** and lower operational complexity/cost than microservices, yet still a distributed style — design for latency, failures and coupling.  
- **When to use:** ideal for business applications that need **clear service boundaries** without the full overhead of microservices.

**Summary:** It is a distributed architecture style that structures an application as a collection of loosely coupled services.
Each service encapsulates a specific business capability and communicates with other services over a network using well-defined interfaces and protocols.

---

## 7.4.1 Topology Characteristics

Services within this architecture style are typically coarse-grained **portions of an application** (usually called **domain services**) that are independent and separately deployed.
Main characteristics include:

- **Macro layers:** separate **User Interface**, multiple remote **coarse‑grained domain services**, and a shared **monolithic database**.
- **Service granularity & deployment:** services are coarse‑grained domain modules, typically deployed as standalone applications/executables; containerization (e.g., Docker) is optional, not required.
- **Typical size:** small service count (≈4–12 services, commonly ~7) — fewer services reduces operational complexity but increases coupling.
- **Instances & scaling:** usually a single instance per domain service; horizontal scaling is possible (multiple instances) and requires **load balancing** to route UI traffic to healthy instances.
- **Access patterns:** services are called remotely from the UI using **REST** (most common), but **RPC, messaging, or SOAP** can be used. An **API gateway** or proxy is optional; many setups use a **service locator** to find services.
- **Shared data model:** a centrally **shared database** enables easy SQL joins and simple queries, but couples services tightly and makes schema changes harder.
- **Operational implications:** simpler than microservices (lower infra/ops), but watch for **database change management** and consider **database partitioning** or other strategies when evolving the schema or scaling data.
- **Design guidance:** favor minimal, well‑defined service contracts, limit chatty interactions, and plan for controlled database evolution to balance simplicity and maintainability.

**Design principle:** Service-based Architecture offers a pragmatic distributed style with coarse-grained services and shared data, balancing modularity and operational simplicity.
We will see than microservices architecture refines this style further by emphasizing independent data ownership and finer-grained services.

---

## 7.4.2 Topology Variants

![](images/soa_2.png)

**Figure 7.11:** User Interface variations in Service-based Architecture.

Many topology variants exist within the service‑based style. Common options:

- **Monolithic UI** — a single frontend calls multiple services (often via an API gateway); simple to operate but couples UI evolution.
- **Domain‑specific UIs** — split the frontend by business domain so each UI aligns with its owning service; enables independent deployments and simpler UIs.
- **Backend‑for‑Frontend (BFF)** — per‑client or per‑domain backends that aggregate and tailor service responses, reducing chatty calls and payloads.
- **Micro‑frontends / federated UIs** — independently developed UI fragments composed at runtime; useful for large teams and isolated release cycles.
- **Multiple client types** — specialized frontends (web, mobile, dashboards) may use dedicated UIs or share common APIs.

**Design guidance:** pick the variant that matches team boundaries, deployment independence, performance needs and acceptable operational complexity; always favor minimal coupling and clear API contracts.

![](images/soa_3.png)

**Figure 7.12:** Storage variations in Service-based Architecture.

Similarly, split a monolithic database into multiple **domain‑owned databases** (analogous to microservices). Key points:

- **Data ownership:** each database should contain only the data required by its domain; other services must not read another service’s database directly.  
- **Minimize coupling:** expose shared data via **service APIs** or **events** rather than direct DB access.  
- **Avoid duplication and chatty calls:** when data must be shared, use controlled patterns (selective replication, consumer‑driven contracts, or event streams).  
- **Design trade‑offs:** plan for **eventual consistency**, reconciliation mechanisms, and clear ownership to enable independent evolution and scaling.

![](images/soa_4.png)

**Figure 7.13:** API Layer variation in Service-based Architecture.

Consider adding an **API layer** (reverse proxy / gateway) between the UI and domain services. 
It centralizes cross‑cutting concerns and is especially useful when exposing services externally or consolidating shared functionality.

Key points:
- **Use cases:** external APIs, multi‑client aggregation (BFF), protocol translation, and enforcing organization‑wide policies.
- **Typical responsibilities:** routing, **auth/authz**, TLS termination, rate limiting, **metrics** and logging, auditing, request/response transformation, caching, circuit breaking, and service discovery.
- **Benefits:** simplifies client code, reduces duplicated logic, enforces consistent security and observability, and enables central policy changes.
- **Trade‑offs:** introduces additional latency and operational scope—design for redundancy, scalability, and monitoring.

---

## 7.4.2 Service-based Architecture - Summary & Rating

**Service-based Architecture — Summary & Rating**

- **Focus:** domain-partitioned services that prioritize **domain logic** over presentation or persistence concerns.
- **Key benefits:**
  - **Agility:** faster feature delivery via independently deployable domain services.
  - **Testability:** smaller domain surface increases unit/integration test clarity.
  - **Deployability:** supports frequent, low‑risk releases.
  - **Operational simplicity & cost:** less infrastructure/ops overhead than finer‑grained patterns.
- **Resilience:** services are self‑contained which limits blast radius; fewer cross‑service dependencies reduce distributed‑transaction complexity.
- **Scalability:** **moderate** — coarse granularity limits elasticity and resource efficiency compared to microservices; usually scales by increasing instances of whole services.
- **When to choose:** teams needing pragmatic modularization with lower operational cost and clearer domain boundaries, without the full operational burden of microservices.

| Aspect              | Effect                                           | Recommendation                                                 |
|:--------------------|:------------------------------------------------:|:--------------------------------------------------------------|
| Agility             | High — independent deployments speed changes     | Use for fast iteration with clear domain boundaries           |
| Testability         | High — smaller scope per service                 | Keep services focused and well‑scoped                         |
| Deployability       | High — low‑risk, frequent releases                | Automate CI/CD for each service                               |
| Fault tolerance     | Good — limited blast radius                      | Design services to be autonomous and idempotent               |
| Scalability         | Moderate — coarse granularity                    | Scale whole services or partition domains when needed         |
| Complexity / Cost   | Low → Moderate                                   | Prefer when ops budget or team size is limited                |
| Network & Transactions | Lower network chatter, fewer distributed transactions | Use APIs/events for explicit data sharing and consistency handling |


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
