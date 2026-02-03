# Deep Dive into AWS 

# AWS Shared Responsibility Model

The **AWS Shared Responsibility Model** is the foundational security and compliance framework that defines how security responsibilities are divided between **AWS** (the cloud provider) and the **customer** (you). It is frequently summarized as:

- **Security of the Cloud** → AWS's responsibility
- **Security in the Cloud** → Customer's responsibility
![7a404923-5572-409c-b30e-6d44706bcd89 094727e5c591e9a96edf10578d0bc1172d9e4553](https://github.com/user-attachments/assets/61a700d1-2567-4362-b3ec-155c2f0bf165)

This model significantly reduces your operational burden by having AWS manage and secure the global infrastructure, while you retain full control and accountability for what you deploy and configure inside AWS.

## Core Principle & Key Statements from AWS

> "Security and Compliance is a shared responsibility between AWS and the customer. This shared model can help relieve the customer’s operational burden as AWS operates, manages and controls the components from the host operating system and virtualization layer down to the physical security of the facilities in which the service operates."

> "The customer assumes responsibility and management of the guest operating system (including updates and security patches), other associated application software as well as the configuration of the AWS provided security group firewall."

> "The nature of this shared responsibility also provides the flexibility and customer control that permits the deployment of security features that meet your specific requirements."

The model applies universally across all AWS Regions and services, but the **exact division shifts** depending on:

- The AWS service type chosen (IaaS vs. PaaS vs. abstracted/managed)
- How you integrate the service into your broader IT environment
- Your industry-specific regulatory and compliance obligations (e.g., GDPR, HIPAA, PCI DSS, FedRAMP)

## Security of the Cloud – AWS Responsibilities

AWS is fully accountable for protecting **the infrastructure** that powers every AWS service worldwide.

### Scope of AWS Responsibility

- Physical security of **data centers** (buildings, access controls, surveillance, environmental controls like fire suppression, cooling, power redundancy)
- Physical hardware (servers, storage devices, networking gear)
- Host operating system & **hypervisor** layer (Nitro System, Xen, etc.)
- Virtualization infrastructure
- Global **network infrastructure** (backbone, edge locations, peering, transit)
- Physical and environmental controls (power, HVAC, flood/fire protection)
- Infrastructure patching and configuration of underlying devices
- Employee training and awareness programs for AWS staff
- Providing audit reports, compliance attestations (SOC, ISO 27001, PCI, etc.), and documentation for inherited controls

AWS continuously monitors, patches, and hardens this foundation so customers inherit a highly secure base layer.

## Security in the Cloud – Customer Responsibilities

You are responsible for **everything** you put into or configure within AWS.

### Core Customer Duties

- Guest operating system management (installation, patching, hardening, anti-malware)
- Application software and utilities installed on compute instances
- Configuration of **AWS-provided security controls** (security groups, NACLs, WAF rules, etc.)
- Data classification, encryption (at rest & in transit), key management
- Identity & Access Management (IAM users, roles, policies, MFA, federation)
- Network configuration inside your VPCs (subnets, route tables, endpoints)
- Operating system-level firewalls, host-based intrusion detection
- Application-layer security (code vulnerabilities, input validation, OWASP Top 10 mitigation)
- Logging, monitoring, and incident response for your workloads
- Compliance alignment (mapping controls to PCI, HIPAA, GDPR, SOC 2, etc.)
- Employee training for your organization
- Backup, disaster recovery, and business continuity planning

## How Responsibility Shifts by Service Category

AWS categorizes services into three broad responsibility gradients:

|Service Category|Examples|AWS Responsibility (of the Cloud)|Customer Responsibility (in the Cloud)|Responsibility Shift|
|---|---|---|---|---|
|**Infrastructure (IaaS)**|Amazon EC2, EBS, VPC|Physical infra, hypervisor, host OS, facilities|Guest OS (patching, hardening), applications, security groups, network config inside VPC, data encryption, IAM|Highest customer control & responsibility|
|**Container / Managed**|Amazon ECS / EKS on EC2, RDS, ElastiCache|Infra + managed OS patching (in many cases), platform|Container images, application code, data encryption, IAM roles, network config, access controls|Medium – AWS handles more OS/platform tasks|
|**Abstracted / Fully Managed**|Amazon S3, DynamoDB, Lambda, Aurora Serverless, SQS, SNS|Infra + OS + platform + endpoints + patching|Data classification, encryption choices, IAM policies/permissions, bucket/object ACLs, access logging|Lowest customer infra burden – focus on data & access|

### Concrete Service Examples

- **Amazon EC2 (classic IaaS)**
    - AWS: Physical server, hypervisor, host OS
    - Customer: Guest OS patching, OS hardening (CIS benchmarks), application patching, security group rules, IAM instance profiles, EBS encryption, backup strategy
- **AWS Lambda (serverless)**
    - AWS: Entire execution environment, patching, scaling infrastructure
    - Customer: Function code security, dependencies/libraries, environment variables, IAM execution role, input validation, secrets management
- **Amazon S3 (object storage – abstracted)**
    - AWS: Infrastructure, OS, storage platform, durability (11 9s), availability
    - Customer: Bucket policies, object ACLs, encryption (SSE-S3, SSE-KMS, client-side), MFA Delete, versioning, Object Lock, access logging, data classification
- **Amazon RDS / Aurora**
    - AWS: Underlying OS patching, DB engine patching (minor), hardware, backups (automated snapshots), Multi-AZ replication
    - Customer: Database parameter groups, user accounts & privileges, application-level encryption, query security, backup retention policy, encryption key rotation
- **Amazon EKS / ECS on Fargate**
    - AWS: Kubernetes control plane (EKS), container runtime, patching of managed nodes (Fargate)
    - Customer: Container images (vulnerability scanning), pod security policies, IAM roles for tasks/pods, network policies, secrets

## Shared Controls – Areas Where Both Have Responsibility (Different Contexts)

|Control Area|AWS Responsibility|Customer Responsibility|
|---|---|---|
|**Patch Management**|Patches hypervisor, host OS, infrastructure|Patches guest OS, applications, containers, dependencies|
|**Configuration Management**|Configures infrastructure devices|Configures guest OS, databases, applications, security groups|
|**Awareness & Training**|Trains AWS employees|Trains your employees on cloud security & compliance|

## Inherited vs. Customer-Specific Controls

- **Inherited Controls** Fully managed by AWS → physical/environmental, hypervisor, global backbone → You inherit these automatically (no action needed)
- **Shared Controls** Apply to both in different scopes (patch management, configuration)
- **Customer-Specific Controls** Solely your domain → data zoning, service protection, application-layer security, compliance mapping for your industry

# AWS Security, Identity, and Compliance 

AWS provides a comprehensive, integrated suite of **security, identity, and compliance services** designed to help organizations protect workloads, applications, data, and infrastructure in the cloud. These services follow the **AWS Shared Responsibility Model** (AWS secures the cloud infrastructure; customers secure their data, applications, configurations, and access in the cloud).

**Core Value Propositions** (from the hero section):

- Securely manage identities, resources, and permissions at scale for workforce and customer-facing applications.
- Enhance security posture and streamline operations through intelligent threat detection, risk prioritization, and shift-left security practices.
- Protect data, accounts, and workloads with encryption, key management, and sensitive data discovery.
- Gain comprehensive compliance visibility with automated checks aligned to AWS best practices and industry standards (e.g., PCI DSS, HIPAA, GDPR, FedRAMP, SOC, ISO).
- Enforce fine-grained policies to inspect/filter traffic and block unauthorized access at network, host, and application layers.

AWS organizes security capabilities into five primary categories:

1. **Identity and Access Management**
2. **Detection and Response**
3. **Data Protection**
4. **Compliance**
5. **Network and Application Protection**
## 1. Identity and Access Management

These services enable secure authentication, authorization, federation, and least-privilege access across AWS accounts, applications, and workloads.

- **AWS Identity and Access Management (IAM)** Securely manage identities and fine-grained access to AWS services and resources. **Capabilities**: Policies (JSON), roles (temporary credentials via STS), users/groups, MFA, ABAC (attribute-based), service control policies (SCPs) via Organizations, access analyzer. **Use Cases**: Least-privilege enforcement, cross-account access, federated access (SAML/OIDC), EC2 instance roles. **Best Practices**: Root user lockdown, credential rotation, policy boundaries, IAM Access Analyzer for unused permissions.
- **AWS IAM Identity Center** (formerly AWS SSO) Centrally manage workforce access to multiple AWS accounts and business applications. **Capabilities**: Permission sets, multi-account SSO, integration with external IdPs (Okta, Azure AD), SCIM provisioning. **Use Cases**: Enterprise SSO, centralized workforce identity governance.
- **Amazon Cognito** Implement secure, scalable customer identity and access management (CIAM) for web/mobile apps. **Capabilities**: User pools (sign-up/sign-in), identity pools (federated/temp creds), social/enterprise federation, adaptive authentication, MFA. **Use Cases**: Consumer-facing apps (e-commerce, mobile), B2C authentication.
- **Amazon Verified Permissions** Manage fine-grained permissions and authorization in custom applications (Cognito-backed Cedar policy engine). **Capabilities**: Policy-based authorization, policy stores, schema-driven, real-time decisions. **Use Cases**: Application-level fine-grained access control (FGAC), replacing home-grown authz logic.
- **AWS Directory Service** Fully managed Microsoft Active Directory (or AD Connector / Simple AD). **Capabilities**: Domain join EC2/Linux, Kerberos/NTLM, RADIUS, LDAP. **Use Cases**: Hybrid identity, Windows workloads, legacy app migration.
- **AWS Resource Access Manager (RAM)** Securely share AWS resources across accounts or within Organizations. **Capabilities**: Share VPC subnets, Transit Gateways, Route 53 Resolver rules, License Manager configs. **Use Cases**: Multi-account resource sharing without duplication.
- **AWS Organizations** Centrally govern and manage multiple AWS accounts at scale. **Capabilities**: Consolidated billing, SCPs, tag policies, delegated administration. **Use Cases**: Multi-account strategy, governance guardrails.

## 2. Detection and Response

Services that continuously monitor, detect threats, investigate incidents, and automate responses.

- **Amazon GuardDuty** Intelligent threat detection using ML on logs (VPC Flow, DNS, CloudTrail, EKS audit, S3 data events, runtime). **Capabilities**: Malware scanning (EBS), crypto mining detection, reconnaissance, credential compromise findings. **Use Cases**: Account compromise detection, runtime threat monitoring.
- **Amazon Inspector** Automated vulnerability management for EC2, Lambda, containers. **Capabilities**: CVE scanning, network reachability, software inventory, CIS/OS benchmarks. **Use Cases**: Continuous vulnerability scanning, shift-left in CI/CD.
- **Amazon Detective** Investigate security findings with graph-based analysis of CloudTrail, VPC Flow, GuardDuty, Security Hub. **Capabilities**: Entity behavior timelines, root cause analysis. **Use Cases**: Incident forensics, threat hunting.
- **AWS Security Hub CSPM** (formerly AWS Security Hub) Centralized security posture management; aggregates findings from 100+ sources. **Capabilities**: Compliance checks (CIS, PCI, AWS Foundational), automated remediation, insights. **Use Cases**: Unified dashboard, prioritization, compliance reporting.
- **Amazon Macie** ML-powered sensitive data discovery and protection in S3. **Capabilities**: PII/PHI detection, access pattern anomalies, automated classification. **Use Cases**: Data risk identification, compliance (GDPR, HIPAA).
- **Amazon Security Lake** Centralized data lake for security logs (normalized OCSF format). **Capabilities**: Ingest from AWS + third-party, query with Athena, retention policies. **Use Cases**: Long-term log retention, advanced analytics/SIEM.

## 3. Data Protection

Encryption, key management, secrets, and certificate services.

- **AWS Key Management Service (KMS)** Create/control cryptographic keys for encryption. **Capabilities**: Customer-managed keys (CMKs), automatic rotation, multi-Region, FIPS 140-2/3. **Use Cases**: S3 SSE-KMS, EBS encryption, RDS encryption.
- **AWS Secrets Manager** Rotate, manage, retrieve secrets (DB creds, API keys). **Capabilities**: Automatic rotation (RDS, Redshift, etc.), fine-grained access. **Use Cases**: Secure credential storage in apps/Lambda.
- **AWS Certificate Manager (ACM)** Provision/manage SSL/TLS certificates. **Capabilities**: Public/private certs, auto-renewal, integration with ELB, CloudFront. **Use Cases**: HTTPS enforcement.
- **AWS CloudHSM** Single-tenant HSM for key storage/processing. **Capabilities**: FIPS 140-2 Level 3, PKCS#11, custom key ops. **Use Cases**: High-compliance key management (PCI, financial).

## 4. Compliance

Tools for governance, auditing, and compliance automation.

- **AWS Artifact** On-demand access to compliance reports (SOC, PCI, ISO). **Use Cases**: Audit evidence collection.
- **AWS Audit Manager** Automate evidence collection for audits (GDPR, HIPAA, PCI). **Capabilities**: Frameworks, assessments, continuous monitoring.
- **AWS Config** Track resource configurations and compliance over time. **Capabilities**: Rules (managed/custom), conformance packs, remediation.

## 5. Network and Application Protection

Protect against network threats and application exploits.

- **AWS WAF** Web application firewall for filtering malicious web traffic. **Capabilities**: Managed rules (SQLi, XSS), rate limiting, CAPTCHA, geo-blocking.
- **AWS Shield** DDoS protection (Standard free / Advanced paid). **Capabilities**: Layer 3/4/7 mitigation, 365 protection.
- **AWS Network Firewall** Managed stateful firewall for VPCs. **Capabilities**: Intrusion prevention (IPS), deep packet inspection.
- **AWS Firewall Manager** Centrally manage WAF, Shield, VPC security groups across accounts.


# AWS Networking and Content Delivery 


AWS Networking and Content Delivery category provides secure, high-performance, low-latency connectivity, isolation, global distribution, and DNS resolution. It follows the **Shared Responsibility Model**: AWS manages the global backbone, edge locations, and underlying infrastructure; customers configure VPCs, routing, security, and access policies.

Key pillars:

- **Isolation & Control** → Amazon VPC
- **DNS & Domain Management** → Amazon Route 53
- **Global Content Acceleration** → Amazon CloudFront
- **Traffic Distribution & Scaling** → Elastic Load Balancing (ELB) + Auto Scaling Groups (ASG)
- **Connectivity & Routing** → Internet Gateways, NAT, Peering, Transit Gateway, etc.
- **Monitoring & Integration** → CloudWatch, CloudTrail, API Gateway, SQS/SNS/SES

## 1. Amazon VPC Overview

**Amazon Virtual Private Cloud (VPC)** lets you launch AWS resources into a **logically isolated virtual network** that you define — resembling a traditional data center network but built on AWS's scalable infrastructure.

### Core Concepts

- **VPC** — Isolated virtual network with your own IP address range (CIDR block).
- **Subnets** — Subdivisions of VPC IP range, each in a single Availability Zone (AZ).
    - **Public Subnet** — Route to Internet Gateway (IGW) for direct internet access.
    - **Private Subnet** — No direct internet route; use NAT for outbound.
- **CIDR Blocks** — IPv4 (e.g., 10.0.0.0/16) and IPv6 support. Primary CIDR + secondary CIDRs allowed.
- **Route Tables** — Control traffic direction from subnets/gateways (local, IGW, NAT, peering, VPC endpoints, etc.).
- **Internet Gateway (IGW)** — VPC component enabling bidirectional internet communication for public subnets.
- **NAT Gateway** — Managed, highly available service for outbound internet from private subnets (IPv4/IPv6 via NAT64/DNS64).
- **Security Groups** — Stateful firewalls at instance level (allow rules only).
- **Network ACLs (NACLs)** — Stateless firewalls at subnet level (allow/deny rules, numbered priority).
- **VPC Endpoints** — Private connectivity to AWS services (Interface for API Gateway/S3, Gateway for S3/DynamoDB).
- **VPC Peering** — Direct private routing between two VPCs (non-transitive).
- **Transit Gateway** — Hub for connecting multiple VPCs, on-premises (VPN/Direct Connect), scalable.
- **Elastic IP (EIP)** — Static public IPv4 address allocable to instances/NAT gateways.
- **Other Features** — VPC Flow Logs (traffic capture), Traffic Mirroring, Reachability Analyzer.

**IPv4 vs IPv6** — Dual-stack support; public IPv4 often requires EIP (charged beyond Free Tier); IPv6 uses Global Unicast Addresses.

**Best Practices** — Use multi-AZ subnets, least-privilege NACLs/SGs, private subnets for sensitive workloads, VPC endpoints to avoid internet traversal.

## 2. Default VPC vs Custom VPC (Demo-Style Comparison)

### Default VPC (Pre-configured – Quick Start Demo)

- Automatically created in every Region for new accounts.
- One **public subnet per AZ** (e.g., 10.0.0.0/20 in us-east-1a).
- **Internet Gateway** attached.
- Main route table has 0.0.0.0/0 → IGW.
- DNS resolution + hostnames enabled.
- Security group allows all outbound, inbound restricted.
- Ideal for: Quick EC2 launches, public-facing apps, learning.

**Demo Flow (Conceptual)**:

1. Launch EC2 in default VPC → auto-assigns public IP/subnet.
2. Instance gets public DNS name (ec2-xx.compute.amazonaws.com).
3. Internet access works out-of-box.

**Limitations** — Less control; can't change CIDR easily; public by default.

### Custom VPC (Production-Grade Demo)

- You define CIDR (e.g., 10.10.0.0/16).
- Create public + private subnets across AZs.
- Attach IGW to VPC.
- Create custom route tables:
    - Public: 0.0.0.0/0 → IGW
    - Private: 0.0.0.0/0 → NAT Gateway
- Launch NAT Gateway in public subnet + associate EIP.
- Add security groups (e.g., web tier: allow 80/443 inbound) + NACLs.
- Enable VPC Flow Logs for auditing.

**Demo Flow (Conceptual)**:

1. Create VPC → 10.0.0.0/16.
2. Subnets: Public-A (10.0.1.0/24), Private-A (10.0.2.0/24), etc.
3. Attach IGW → update public route table.
4. Create NAT Gateway → update private route table.
5. Launch EC2 in private subnet → outbound works, inbound blocked.
6. Add peering or Transit Gateway for multi-VPC.

**Recommendation** — Use custom VPCs for production; default for prototyping.

## 3. Internet Connectivity Deep Dive

- **Internet Gateway (IGW)** Purpose: Enables resources in public subnets to reach internet + be reached from internet. High availability: Redundant in Region. Route: 0.0.0.0/0 → igw-xxxx (public subnet). Requires public IP/EIP on instance for inbound.
    
- **NAT Gateway** (vs NAT Instance) **NAT Gateway** (recommended):
    
    - Fully managed, auto-scales, highly available (create one per AZ).
    - Public: In public subnet + EIP → outbound via IGW.
    - Private: Routes via Transit Gateway/VPN (no IGW).
    - Supports IPv6 outbound (NAT64).
    - Pricing: Hourly + data processed.
    
    **NAT Instance** (legacy/self-managed):
    
    - EC2 instance running NAT software (e.g., iptables).
    - Manual scaling/HA (Auto Scaling + secondary IPs).
    - Lower cost but higher management.
    
    **Best Choice** — NAT Gateway for most cases (simplicity + reliability).
    

## 4. Elastic Load Balancing (ELB) + Auto Scaling Groups (ASG)

- **Elastic Load Balancing** — Distributes incoming traffic across targets (EC2, containers, Lambda, IP). Types:
    - **Application Load Balancer (ALB)** → Layer 7 (HTTP/HTTPS), path/host routing, WAF integration.
    - **Network Load Balancer (NLB)** → Layer 4 (TCP/UDP/TLS), ultra-low latency, static IP.
    - **Gateway Load Balancer (GWLB)** → Layer 3/4 for appliances (firewalls).
    - **Classic** (legacy). Features: Health checks, sticky sessions, SSL termination (ACM).
- **Auto Scaling Groups (ASG)** — Automatically adjust EC2 capacity.
    - Scaling policies: Target tracking (CPU), step/simple, scheduled, predictive.
    - Integrates with ELB (health checks remove unhealthy instances).
    - Launch templates/configurations for consistency.

**Typical Architecture** — ASG behind ALB in public subnets → private subnets for app/DB.

## 5. Amazon Route 53 – DNS Service

Highly available, scalable **DNS web service** + domain registrar.

- **Hosted Zones** — Public (internet-facing) / Private (VPC-internal).
- **Routing Policies**:
    - Simple
    - Weighted
    - Latency-based
    - Failover (active-passive)
    - Geolocation / Geoproximity
    - Multivalue answer
    - IP-based
- **Health Checks** → Monitor endpoints, integrate with CloudWatch alarms.
- **Alias Records** → Route to AWS resources (ELB, CloudFront, S3) without charges.
- **Resolver** → Inbound/outbound endpoints, DNS Firewall.
- **Domain Registration** → Buy/manage domains directly.

**Use Cases** — Domain registration, failover, global routing, private DNS in VPC.

## 6. Amazon CloudFront – Content Delivery Network (CDN)

Global **CDN** for low-latency content delivery (static/dynamic).

- **How it Works** — Edge locations cache content → serve from nearest POP.
- **Origins** — S3, EC2, ALB, MediaPackage, HTTP servers.
- **Behaviors** → Path patterns, cache TTL, query strings, compression.
- **Security** — WAF, Shield, Field-Level Encryption, HTTPS (ACM).
- **Logging** → Standard/real-time to S3.
- **Invalidations** → Remove cached objects.
- **Integration** — Route 53 alias + S3 OAI/OAC for private content.

**Use Cases** — Websites, APIs, video streaming, global apps.

## 7. Key Integration Services

- **API Gateway** → Front-end for serverless/microservices, throttling, auth, caching.
- **SQS / SNS / SES** → Decoupled messaging (queues/topics), email delivery.
- **CloudWatch** → Metrics, alarms, logs for monitoring (e.g., VPC Flow Logs, ELB metrics).
- **CloudTrail** → Audit API calls for governance/security.


# AWS Database Services 

AWS offers **purpose-built databases** for every workload: relational, NoSQL, in-memory, graph, document, search, time-series, and more. This eliminates the need for one-size-fits-all databases, enabling optimization for cost, performance, scale, and developer productivity. All services follow the **Shared Responsibility Model** (AWS handles infrastructure, patching, backups; customers handle data, access, encryption, schema design).

- **Serverless options** for auto-scaling and pay-per-use
- **Encryption** at rest (AWS KMS) and in transit (TLS)
- **High availability** (Multi-AZ, global replication)
- **Monitoring** via CloudWatch, enhanced monitoring
- **Security** via IAM, VPC, encryption, audit logs
- **Integrations** with Lambda, Glue, SageMaker, zero-ETL patterns

## 1. Amazon RDS (Relational Database Service)

**Fully managed relational databases** – handles provisioning, patching, backups, recovery, scaling.

### Key Features

- Supported engines: PostgreSQL, MySQL, MariaDB, Oracle, SQL Server, Db2, **Amazon Aurora** (enhanced MySQL/PostgreSQL-compatible).
- Deployment options: Standard RDS (instance-based), RDS Custom (OS/DB customization), RDS on Outposts (on-premises).
- **Performance optimizations**: Graviton3/4 instances, Optimized Writes/Reads, EBS io2 Block Express storage.
- **High Availability**: Multi-AZ (synchronous replication, automatic failover ~60s), readable standbys (up to 2 additional read replicas for Aurora/RDS PostgreSQL).
- **Read Replicas**: Up to 15 per primary (async), cross-Region support.
- **Backups**: Automated snapshots, point-in-time recovery (PITR), manual snapshots.
- **Security**: Encryption (KMS), IAM database auth, SSL/TLS, VPC isolation, audit logging.
- **Management**: Automated patching (maintenance windows), parameter groups, performance insights.
- **Analytics/ML**: Zero-ETL integrations to Redshift, SageMaker, Bedrock for near-real-time insights.
- **Generative AI**: pgvector + hnsw indexes in PostgreSQL/Aurora for vector similarity search (up to 20x faster queries).

### Pricing

On-Demand, Reserved Instances, Savings Plans; storage + I/O + backups charged separately.

### Use Cases

Web/mobile apps, e-commerce, CRM/ERP, legacy migrations.

### Best Practices

Use Multi-AZ + read replicas, enable Performance Insights, use IAM auth, monitor with CloudWatch alarms.

## 2. Amazon Aurora (MySQL- & PostgreSQL-Compatible)

Aurora is part of RDS but a **cloud-native relational database** with separate architecture.

### Architecture & Advantages

- Fault-tolerant, distributed storage (6 copies across 3 AZs) → up to 99.99% single-Region, 99.999% multi-Region availability.
- 5x throughput vs standard MySQL, 3x vs PostgreSQL.
- Storage auto-scales from 10 GB to 128 TB (no provisioning needed).
- **Aurora I/O-Optimized** vs Standard configuration for cost/performance trade-off.

### Aurora Serverless

- **v2** (recommended): Instant scaling (0.5–128 ACUs), pauses after inactivity, fine-grained (0.5 ACU increments), supports read replicas.
- **v1** (older): Scales in larger jumps, less granular, higher cold-start latency.

### Global Databases

Multi-Region replication (1 primary + up to 5 secondary clusters), <1s replication lag, failover in <1 min.

### Recent Enhancements (2025–2026)

- Vector support via pgvector (Aurora PostgreSQL), hnsw indexes for AI/RAG workloads.
- Babelfish for SQL Server compatibility (minimal code changes).
- Zero-ETL to Redshift.

### Use Cases

High-throughput OLTP, SaaS multi-tenant, global apps, enterprise modernization (CRM, ERP, billing).

## 3. Amazon RDS Proxy

**Fully managed database proxy** for RDS & Aurora – improves scalability, resilience, security.

### Key Benefits

- **Connection pooling** → reuses connections, reduces DB load (ideal for serverless/Lambda bursts).
- **Failover handling** → preserves app connections, reduces failover time up to 66% (Aurora/RDS).
- **Secrets management** → integrates Secrets Manager, supports IAM auth (no hardcoded creds).
- **Performance** → handles unpredictable workloads, throttles excessive connections.

### Supported Engines

Aurora MySQL/PostgreSQL, RDS MySQL/PostgreSQL/MariaDB/SQL Server.

### Integration with Serverless

Perfect for Lambda – use IAM role auth, no credential management in code.

### Security

IAM auth (client ↔ proxy & proxy ↔ DB), Secrets Manager, TLS.

### Use Cases

Serverless apps, PHP/Rails (frequent connections), multi-tenant SaaS, high-connection-count workloads.

## 4. Amazon Redshift (Data Warehouse & Analytics)

**Petabyte-scale data warehouse** for OLAP/analytics.

### Architecture

- **RA3 nodes** + managed storage → separate compute/storage, scale independently.
- **Concurrency Scaling** → auto-adds clusters for bursts.
- **AQUA** (Advanced Query Accelerator) → in-memory caching for faster queries.

### Redshift Serverless

- No clusters to manage → instant start, auto-scales compute (RPU – Redshift Processing Units).
- Pay only for queries run + storage.
- Ideal for variable/sporadic workloads.

### Data Loading & Integrations

- **Zero-ETL** from Aurora, RDS, DynamoDB, Kinesis, MSK → near-real-time analytics.
- **COPY** command, streaming ingestion.
- **Redshift Spectrum** → query S3 data lake without loading.
- **Amazon Q** → natural language to SQL.
- **SageMaker / Bedrock** → ML on warehouse data.

### Security

Row/column-level access, VPC, encryption, IAM.

### Use Cases

BI dashboards (QuickSight, Tableau), predictive analytics, real-time fraud detection, IoT leaderboards.

## 5. Amazon DynamoDB (NoSQL Key-Value & Document)

**Fully managed, serverless NoSQL** database – single-digit ms latency at any scale.

### Key Concepts

- Tables, items (JSON-like), primary keys (partition + sort).
- **Capacity modes**: Provisioned (RCU/WCU) or On-Demand (auto-scales).
- **Global Tables** → multi-Region active-active, 99.999% availability, strong consistency.

### Features

- Streams → event-driven (Lambda triggers).
- **DAX** → in-memory cache (microsecond reads).
- Backups: On-demand + PITR (35 days).
- **PartiQL** → SQL-like queries.
- Vector search support (recent).

### Security

Encryption (KMS), IAM fine-grained, VPC endpoints.

### Use Cases

Gaming (leaderboards, sessions), retail (carts, profiles), IoT, media metadata, high-concurrency apps.

### Best Practices

Single-table design, model access patterns first, use on-demand for unpredictable traffic.

## 6. Amazon OpenSearch Service

**Managed search & analytics** suite (successor to Elasticsearch).

- Full-text search, log analytics, observability, security analytics.
- Vector search for semantic/AI workloads.
- Serverless option available.
- Integrations: Kinesis, CloudWatch Logs, S3.

Use Cases: Application search, SIEM, observability.

## 7. Amazon ElastiCache & MemoryDB for Redis

**In-memory caching/data stores** for sub-ms latency.

- **ElastiCache for Redis/Memcached** → managed Redis (multi-AZ, clustering) or Memcached.
- **MemoryDB for Redis** → durable (Multi-AZ transactional log), Redis-compatible, ultra-fast reads/writes.

Use Cases: Caching, session stores, leaderboards, real-time analytics.

## 8. Amazon DocumentDB (with MongoDB compatibility)

**Managed document database** – MongoDB workloads.

- MongoDB 5.0/6.0 APIs.
- Multi-AZ, replicas, backups.
- Serverless option.

Use Cases: Content management, catalogs, user profiles.

## 9. Amazon Keyspaces (for Apache Cassandra)

**Managed wide-column store** – serverless Cassandra.

- CQL compatible.
- On-demand or provisioned capacity.
- Point-in-time recovery.

Use Cases: Industrial IoT, messaging, time-series.

# AWS Compute Services 

AWS Compute services provide the building blocks for running workloads — from traditional virtual machines to fully serverless and containerized architectures.

## 1. Amazon EC2 – Elastic Compute Cloud

**EC2** is the foundational **IaaS** service — resizable virtual servers (instances) in the cloud.

### Instance Types – Families & Use Cases (2025–2026)

|Family|Prefix|Best For|Processor Options|Key Features / Accelerators|Typical Use Cases|
|---|---|---|---|---|---|
|General Purpose|t*, m*, c*|Balanced compute, memory, network|Intel, AMD, Graviton (Arm)|Burstable (T), high frequency (C), balanced (M)|Web servers, dev/test, small/medium DBs|
|Compute Optimized|c*|High-performance compute|Intel Xeon, AMD EPYC, Graviton4|Highest clock speed, AVX-512, high vCPU:memory|Batch processing, gaming servers, HPC, ML inference|
|Memory Optimized|r*, x*, z*, u*|Memory-intensive workloads|Intel, AMD, Graviton|Very high memory-to-vCPU ratio|In-memory databases (Redis, SAP HANA), big data analytics|
|Storage Optimized|i*, d*, im*|High I/O, large local storage|Intel, AMD|NVMe SSDs, high throughput IOPS|NoSQL (Cassandra, MongoDB), data warehousing, log processing|
|Accelerated Computing|p*, g*, trn*, inf*|GPU / ML / inference / graphics|NVIDIA GPUs, AWS Inferentia, Trainium|GPU (A100/H100), Inferentia2, Trainium2|Deep learning training/inference, graphics rendering, video transcoding|
|High Memory|u-*|Extremely large memory workloads|Intel|Up to 24 TB RAM|SAP HANA, large in-memory analytics|
|HPC Optimized|hpc*|High-performance computing|Intel, AMD|High network bandwidth, Elastic Fabric Adapter|Scientific simulations, CFD, weather modeling|

**Naming convention example**: c7g.4xlarge = compute optimized, 7th generation, Graviton3, 4×large size

**Instance Purchasing Options**

- On-Demand
- Spot Instances (up to ~90% discount)
- Reserved Instances (1 or 3 years) – Standard / Convertible
- Savings Plans (Compute / EC2 Instance) – most flexible
- Dedicated Hosts / Dedicated Instances / Capacity Reservations

**Best Practices**

- Use Graviton (Arm-based) instances for better price/performance (up to 40% better)
- Right-size instances using Compute Optimizer
- Use Spot + ASG for fault-tolerant workloads
- Enable IMDSv2 and disable IMDSv1

## 2. Amazon Machine Images (AMI)

**AMI** is a template that contains:

- Software configuration (OS, application server, applications)
- Launch permissions
- Block device mapping

### Types of AMIs

- **AWS Marketplace AMIs** — Paid / free third-party images
- **Community AMIs** — Shared by other AWS users
- **My AMIs** — Your own custom images
- **AWS-provided AMIs** — Amazon Linux 2023, Ubuntu, Windows Server, etc.

### Key Features

- Region-specific (cannot launch in another region without copying)
- EBS-backed (default) vs Instance Store-backed (ephemeral)
- Encrypted AMIs (using KMS keys)
- Shared AMIs (cross-account)

**Best Practices**

- Never use public/community AMIs in production without hardening
- Create golden AMIs with security patches, CIS benchmarks, your app stack
- Use **EC2 Image Builder** to automate creation

## 3. EC2 Image Builder

**Fully managed service** to create, test, and distribute secure, up-to-date custom AMIs and container images.

### Key Components

- **Image recipes** — Define components (scripts, packages, hardening steps)
- **Components** — Reusable building blocks (AWS-managed or custom)
- **Distribution settings** — Where to publish (Regions, accounts, Marketplace)
- **Infrastructure configuration** — Instance types, VPC/subnets, IAM roles
- **Image pipeline** — Automates build → test → distribute

### Benefits

- Removes manual patching
- Enforces security baselines
- Integrates with AWS Config, Security Hub
- Versioning & rollback

**Use Cases**

- Golden images for Auto Scaling Groups
- Compliance-required hardened images
- Consistent dev/test/prod environments

## 4. Elastic Network Interface (ENI)

**Virtual network card** that can be attached to EC2 instances.

### Key Characteristics

- Primary ENI — created with instance, cannot be detached
- Secondary ENI — can be attached/detached, moved between instances
- Supports multiple private IPv4, IPv6, Elastic IPs
- MAC address stays with ENI
- Security groups and MAC address filtering possible

### Common Use Cases

- Multi-homed instances (different subnets)
- High availability (move ENI during failover)
- Network appliances (firewalls, load balancers)
- License-bound applications (MAC-based licensing)

## 5. AWS Elastic Beanstalk

**Platform as a Service (PaaS)** — easiest way to deploy and manage web applications.

### Supported Platforms

- Java, .NET, PHP, Node.js, Python, Ruby, Go, Docker
- Single container Docker & Multi-container Docker (via ECS)

### Features

- Auto Scaling, Load Balancing, Health monitoring
- Managed updates (platform + OS patches)
- Blue/green & rolling deployments
- Environment configuration via .ebextensions
- Integrates with RDS, ElastiCache, S3, CloudWatch

**When to Use**

- Developers want to focus on code, not infrastructure
- Quick MVP / small-to-medium applications
- Standard web apps (no complex orchestration needed)

**When NOT to Use**

- Very custom networking / advanced container orchestration
- Microservices with complex dependencies → prefer ECS/EKS

## 6. AWS Lambda – Serverless Compute

**Event-driven, serverless** compute service — run code without provisioning servers.

### Key Concepts

- Functions — code + configuration
- Runtimes — Node.js, Python, Java, Go, .NET, Ruby, custom (container)
- Triggers — 200+ event sources (S3, API Gateway, DynamoDB, EventBridge, etc.)
- Concurrency — Provisioned concurrency, reserved concurrency
- Layers — reusable code/libraries
- Extensions — Lambda SnapStart, Lambda Response Streaming

### Pricing

Pay per request + duration (ms granularity)

### Best Practices

- Keep functions small & single-purpose
- Use environment variables / Parameter Store / Secrets Manager
- Enable X-Ray tracing
- Use Provisioned Concurrency for latency-sensitive apps

## 7. Amazon ECS – Elastic Container Service

**Fully managed container orchestration** service — supports two launch types.

### Launch Types

- **Fargate** — Serverless (no EC2 management)
- **EC2** — You manage the container instances

### Key Components

- **Cluster** — logical grouping
- **Task Definition** — container(s) blueprint (CPU, memory, ports, env vars)
- **Service** — maintains desired count of tasks, integrates with ALB/NLB
- **Task** — running instance of task definition

### Integrations

- ECR, ALB, CloudWatch, IAM roles for tasks
- AWS Copilot CLI — simplifies deployment

## 8. Amazon ECR – Elastic Container Registry

**Fully managed Docker container registry** — secure, scalable, reliable.

### Features

- Private repositories
- Image scanning (basic + enhanced with Inspector)
- Lifecycle policies
- Cross-account & cross-region replication
- Pull-through cache (for public registries)

## 9. Amazon EKS – Elastic Kubernetes Service

**Managed Kubernetes** service — AWS manages control plane.

### Key Components

- **Control Plane** — Managed by AWS (HA across 3 AZs)
- **Worker Nodes** — Self-managed EC2, Fargate, Managed Node Groups, Karpenter
- **Networking** — VPC CNI (primary), Calico, Cilium (optional)
- **Add-ons** — CoreDNS, kube-proxy, VPC CNI, EBS CSI, AWS Load Balancer Controller

### Deployment Options

- EKS on EC2
- EKS on Fargate (serverless pods)
- EKS Anywhere (on-premises / edge)

### Modern Patterns

- Karpenter for autoscaling
- Bottlerocket OS for nodes
- EKS Blueprints (CDK/CLI/Terraform)
- AWS Controllers for Kubernetes (ACK)

## Summary – Compute Service Comparison Table

|Service|Management Level|Best For|Scaling|Pricing Model|Orchestration|
|---|---|---|---|---|---|
|EC2|IaaS|Maximum control, legacy apps|Auto Scaling Groups|Per second + storage|Manual/ASG|
|Elastic Beanstalk|PaaS|Quick web app deployment|Managed ASG + ELB|Underlying resources|Platform-managed|
|Lambda|Serverless|Event-driven, microservices|Automatic|Per request + duration|None|
|ECS (Fargate)|Serverless containers|Simple container workloads|Service auto-scaling|Per vCPU + memory second|ECS|
|ECS (EC2)|Managed containers|Cost-optimized containers|ASG + Service|EC2 + data transfer|ECS|
|EKS|Managed Kubernetes|Full Kubernetes ecosystem|Cluster autoscaler / Karpenter|Control plane + nodes/Fargate|Kubernetes|
|ECR|Registry|Container image storage|Automatic|Storage + data transfer|—|

# AWS Storage Services 

AWS Storage services provide scalable, durable, and secure options for different access patterns: block (low-latency, like disks), file (shared access), object (unlimited scale, HTTP), and hybrid (on-premises to cloud bridging). All follow the **Shared Responsibility Model** — AWS handles infrastructure durability; customers manage encryption, access, lifecycle, and data classification.

## 1. Amazon EBS – Elastic Block Store

**Persistent block-level storage volumes** for use with EC2 instances (like virtual hard drives).

### Key Features

- Attached to a single EC2 instance (or Multi-Attach for io1/io2 on Nitro instances).
- Lives in a specific Availability Zone (AZ) with automatic replication within the AZ.
- Supports file systems (ext4, XFS, NTFS), databases, boot volumes.
- Snapshots for point-in-time backups (incremental, stored in S3).

### Volume Types (Performance & Use Cases)

|Volume Type|Durability|Max IOPS (per vol)|Max Throughput|Storage Size|Best For / Use Cases|Cost Profile|
|---|---|---|---|---|---|---|
|**gp3** (General Purpose SSD)|99.8–99.9%|16,000|1,000 MiB/s|1 GiB – 16 TiB|Balanced price/performance; most workloads (boot, dev/test, small DBs)|Lowest cost SSD|
|**gp2** (older gen)|99.8–99.9%|16,000 (burst)|250 MiB/s|1 GiB – 16 TiB|Legacy; burstable performance|Similar to gp3|
|**io2 Block Express**|99.999%|256,000|4,000 MiB/s|4 GiB – 64 TiB|Highest performance; mission-critical apps (large DBs like SAP HANA, Oracle)|Highest cost|
|**io2**|99.999%|64,000|2,000 MiB/s|4 GiB – 64 TiB|High IOPS apps; Multi-Attach support|High|
|**io1** (older)|99.8–99.9%|64,000|1,000 MiB/s|4 GiB – 16 TiB|Legacy provisioned IOPS|High|
|**st1** (Throughput Optimized HDD)|99–99.9%|500|500 MiB/s|500 GiB – 16 TiB|Sequential big data, data warehouses, log processing|Low cost HDD|
|**sc1** (Cold HDD)|99–99.9%|250|250 MiB/s|500 GiB – 16 TiB|Infrequently accessed, large sequential workloads|Lowest cost|

### Advanced Features

- **Encryption**: At-rest (KMS-managed or customer keys), in-transit via instance.
- **Snapshots**: Incremental, point-in-time; use Data Lifecycle Manager for automation.
- **Multi-Attach**: io1/io2 volumes attachable to multiple Nitro EC2 instances (clustered apps).
- **Fast Snapshot Restore (FSR)**: Instant restore from snapshots.
- **io2 Block Express**: Highest durability/throughput; SAN-like performance.

### Best Practices

- Use gp3 for most new workloads (better baseline than gp2).
- Enable encryption by default.
- Monitor with CloudWatch (BurstBalance, VolumeRead/WriteOps).
- Use snapshots + AMI for backups; enable deletion protection.

## 2. Amazon EC2 Instance Store

**Temporary block storage** physically attached to the host computer of an EC2 instance.

### Key Characteristics

- **Ephemeral**: Data lost on instance **stop**, **terminate**, **hardware failure**, or **host maintenance**.
- No persistence across reboots/stops (only survives soft reboots in some cases).
- Included in instance price (no separate charge).
- Very high IOPS/throughput (direct-attached NVMe/SSD/HDD).

### Supported Instance Types

- Many compute-optimized (c*), storage-optimized (i*, d*, im*), accelerated (p*, g*) types offer instance store.
- Size/number vary (e.g., i4i.16xlarge has multiple NVMe drives totaling tens of TB).
- Check docs for exact limits per type/size.

### Performance Advantages

- Lowest latency, highest IOPS/throughput compared to EBS (direct host attachment).
- Ideal for temporary high-performance needs.

### Use Cases

- Caches, scratch data, buffers.
- Temporary databases (replicated across fleet).
- Transient workloads (batch processing, ML training scratch space).
- Data replicated across instances (e.g., web server temp files).

### Best Practices & Limitations

- Never store persistent data here.
- Initialize volumes on first use for optimal performance.
- Use RAID 0 for larger/striped volumes if needed.
- Combine with EBS for persistent root + instance store for temp.

## 3. Amazon EFS – Elastic File System

**Fully managed, elastic NFS file system** — scales to petabytes automatically.

### Architecture & Performance Modes

- Regional (multi-AZ) or One Zone deployment.
- **Performance Modes**:
    - General Purpose (default) — low latency, good for most workloads.
    - Max I/O (older) — higher throughput for massively parallel apps.
- **Throughput Modes**:
    - Bursting (default) — credits-based, scales with size.
    - Provisioned — set fixed throughput (MiB/s).
    - Elastic (newer) — auto-scales throughput instantly.

### Storage Classes

- **Standard** — Frequent access.
- **Infrequent Access (IA)** — Cost-optimized for less-accessed files.
- **Archive** — Lowest cost for rarely accessed data.

### Key Features

- **Availability & Durability**: 99.999999999% (11 9s) durability; multi-AZ regional.
- **Access Points** — Enforce root directory, POSIX permissions, IAM auth.
- **Encryption**: At-rest (KMS), in-transit (TLS).
- **Lifecycle Management**: Auto-transition to IA/Archive.
- **Backups**: AWS Backup integration.

### Integrations

- EC2 (NFS mount), Lambda, ECS/EKS (persistent storage), on-premises via Direct Connect/VPN.

### Use Cases

- Shared file storage for web serving, content management, big data analytics, home directories, ML training data.
- Lift-and-shift enterprise apps needing shared NFS.

### Best Practices

- Use Access Points for multi-tenant isolation.
- Enable lifecycle policies for cost savings.
- Monitor BurstCreditBalance in CloudWatch.

## 4. Amazon S3 – Simple Storage Service

**Object storage** built for virtually unlimited scale, 11 9s durability.

### Storage Classes & Use Cases

|Class|Use Case|Retrieval Time|Durability / Availability|Min Storage Duration|Approx. Cost Tier|
|---|---|---|---|---|---|
|**S3 Standard**|Frequent access|Milliseconds|11 9s / 99.99%|None|Highest|
|**Intelligent-Tiering**|Unknown/ changing access patterns|Milliseconds|11 9s / 99.9%|None|Auto-optimizes|
|**Standard-IA**|Infrequent access|Milliseconds|11 9s / 99.9%|30 days|Lower|
|**One Zone-IA**|Non-critical, infrequent|Milliseconds|11 9s / 99.5%|30 days|Lower than IA|
|**Glacier Instant Retrieval**|Archive with ms access|Milliseconds|11 9s / 99.9%|90 days|Very low|
|**Glacier Flexible Retrieval**|Archive, flexible retrieval|Minutes to hours|11 9s / 99.99%|90 days|Low|
|**Glacier Deep Archive**|Long-term archive|12–48 hours|11 9s / 99.99%|180 days|Lowest|
|**S3 Express One Zone**|Ultra-low latency, high throughput|Sub-ms|High (One Zone)|None|Premium|

### Key Features

- **Versioning** — Recover from deletes/overwrites.
- **Object Lock** — WORM compliance (legal hold, retention).
- **Replication** — Cross-Region, Same-Region, CRR/SRR.
- **Encryption** — SSE-S3 (default), SSE-KMS, client-side.
- **Security** — Bucket policies, IAM, Access Points, Block Public Access.
- **Performance** — Transfer Acceleration, multipart uploads, byte-range fetches.

### Best Practices

- Use Intelligent-Tiering as default for unknown patterns.
- Enable lifecycle policies to move → IA → Glacier → Deep Archive.
- Use S3 Inventory + Athena for auditing.
- Monitor with Storage Lens for organization-wide insights.

## 5. AWS Storage Gateway

**Hybrid cloud storage service** — on-premises access to AWS cloud storage.

### Gateway Types

|Type|Protocol|Storage Backend|Modes|Use Cases|
|---|---|---|---|---|
|**File Gateway (S3)**|NFS / SMB|Amazon S3|—|File shares → S3 data lake, backup, archive|
|**Volume Gateway**|iSCSI|S3 (with local cache)|Cached / Stored|Block storage extension, cloud backup, DR|
|**Tape Gateway**|iSCSI (VTL)|S3 + Glacier / Deep Archive|—|Virtual tape backup, replace physical tapes|

- **Cached Volumes** — Primary data in S3, hot data cached locally.
- **Stored Volumes** — Primary data local, async backup to S3.

### Key Features

- Low-latency local access via caching.
- Encryption, audit logging, WORM support.
- Deployable as VM (VMware, Hyper-V, KVM) or EC2.

### Use Cases

- Hybrid workloads: extend on-premises storage to cloud.
- Backup/DR without forklift changes.
- Data lake ingestion via file shares.

### Best Practices

- Use Cached mode for growing datasets.
- Monitor cache hit rate.
- Integrate with AWS Backup for centralized protection.


# Terraform Notes

## Terraform folder structure
```
terraform-project-root/
├── environments/
│   ├── dev/
│   │   ├── backend.tf
│   │   ├── provider.tf
│   │   ├── terraform.tfvars
│   │   ├── variables.tf                 (optional – only overrides)
│   │   └── main.tf                      (very thin – mostly module calls)
│   │
│   ├── staging/                         (or bts/, nonprod/, test/)
│   │   ├── backend.tf
│   │   ├── provider.tf
│   │   ├── terraform.tfvars
│   │   └── main.tf
│   │
│   └── prod/
│       ├── backend.tf
│       ├── provider.tf
│       ├── terraform.tfvars
│       └── main.tf
│
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── versions.tf
│   │   └── README.md
│   │
│   ├── eks/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── versions.tf
│   │
│   ├── rds/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── versions.tf
│   │
│   ├── s3-bucket/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── versions.tf
│   │
│   ├── iam-roles/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── ec2-asg/
│   │   ├── ...
│   │
│   ├── cloudwatch/
│   │   ├── alarms.tf
│   │   ├── dashboards.tf
│   │   └── variables.tf
│   │
│   └── networking/                     (optional – shared VPC peering, TGW, etc.)
│       └── ...
│
├── global/                             (single-instance resources – usually prod only)
│   ├── iam-users-groups-policies/
│   ├── organization-scp/
│   ├── route53-zones/
│   └── s3-logging-buckets/
│
├── shared/                             (sometimes used instead of global/)
│   └── ...
│
├── .github/
│   └── workflows/
│       ├── terraform-plan.yml
│       ├── terraform-apply-dev.yml
│       ├── terraform-apply-prod.yml
│       └── terraform-destroy.yml
│
├── docs/
│   ├── architecture.md
│   └── terraform-best-practices.md
│
├── scripts/
│   └── tf-wrapper.sh                   (optional helper)
│
├── .gitignore
├── .pre-commit-config.yaml
├── terraform.tf                        (global required_version & providers – optional)
└── README.md
```

## 1. Infrastructure as Code (IaC) with Terraform (Objective 1)

**Key Concepts**

- IaC definition: Provision & manage infrastructure through machine-readable definition files (code) instead of manual processes.
- Advantages: Consistency, repeatability, version control, collaboration, auditability, automation (CI/CD), reduced drift, faster recovery.
- Terraform's role: Declarative (describe desired state), provider-agnostic (multi-cloud/hybrid), idempotent operations.
- Terraform manages multi-cloud, hybrid, and service-agnostic workflows via providers.

**Best Practices**

- Treat infrastructure like application code: commit, review, test.
- Use version control (Git) for .tf files.

## 2. Terraform Fundamentals (Objective 2)

**Key Concepts**

- **Providers**: Plugins that interact with APIs (AWS, Azure, GCP, Kubernetes, Vault, etc.).
- **Installation & Versioning**: terraform init downloads providers; lock file (.terraform.lock.hcl) pins versions.
- **Terraform Block**: Specifies required_version, required_providers.
- **Multiple Providers**: Alias for same provider type (e.g., aws.east, aws.west).
- **State**: JSON file tracking real-world resources.

**Best Practices**

- Always pin provider versions (required_providers).
- Use dependency lock file & upgrade providers safely.
- Manage Terraform binary versions (tfenv, asdf).

## 3. Core Terraform Workflow (Objective 3)

**Workflow Steps**

1. Write configuration (.tf files)
2. terraform init → download providers, modules, backend init
3. terraform fmt → canonical format
4. terraform validate → syntax & internal consistency
5. terraform plan → preview changes (dependency graph)
6. terraform apply → create/update/destroy resources
7. terraform destroy → teardown (with -auto-approve in scripts)

**Important Commands**

- terraform plan -out=plan.tfplan → save plan
- terraform apply plan.tfplan → apply saved plan
- terraform plan -destroy → preview destroy

**Best Practices**

- Never skip plan before apply in production.
- Use -target sparingly (for emergencies).
- Understand dependency graph (implicit vs explicit).

## 4. Read and Write Configuration (Objective 4)

**HCL Syntax Essentials**

- Blocks: resource, data, variable, output, locals, terraform, provider
- Arguments vs Attributes: Input (set) vs Computed/Output (read)
- References: ${resource_type.name.attribute} or modern resource_type.name.attribute
- **Dependencies**: Implicit (references), explicit (depends_on)
- **Variables**: Input (types: string, number, bool, list, map, object), defaults, validation rules
- **Outputs**: Expose values (sensitive flag)
- **Functions**: Built-in (e.g., join, merge, file, templatefile, cidrsubnet)
- **Dynamic Blocks**: dynamic "block" { for_each = ... }
- **Lifecycle Meta-Arguments**:
    - create_before_destroy
    - prevent_destroy
    - ignore_changes
    - replace_triggered_by
- **Validation & Checks**: Variable validation blocks, precondition/postcondition, check blocks
- **Sensitive Data**: sensitive = true, ephemeral values, write-only arguments, Vault provider integration

**Best Practices**

- Use descriptive names & comments.
- Modularize with locals.
- Protect secrets (never hardcode; use Vault or tfvars).
- Use checks/preconditions for guardrails.

## 5. Use and Create Modules (Objective 5)

**Modules**: Reusable configuration packages.

**Sources**

- Terraform Registry (public)
- Private registry (HCP Terraform)
- Git, local path, Terraform Cloud/Enterprise

**Structure** (standard)

- main.tf, variables.tf, outputs.tf, versions.tf, README.md
- Optional: providers.tf, locals.tf

**Key Concepts**

- Root vs child modules
- Module variables (inputs), outputs
- Providers passed or inherited
- count / for_each on modules
- Version constraints (~> 1.2)

**Best Practices**

- Keep modules focused & composable.
- Version modules.
- Use source = "hashicorp/module-name/aws" syntax.

## 6. Terraform State Management (Objective 6)

**State File** (.terraform/terraform.tfstate)

- Maps config to real resources
- Stores metadata (attributes, dependencies)
- Improves performance (caching)

**Backends**

- Local (default)
- Remote: S3 + DynamoDB (locking), Azure Blob, GCS, Terraform Cloud, Consul, etc.
- backend "s3" { ... }

**Key Operations**

- terraform refresh (legacy) → use refresh-only plan
- terraform state list/show/pull/push
- terraform state mv/rm
- moved block for refactoring
- Drift detection & reconciliation

**Best Practices**

- Always use remote backend + locking in teams.
- Never edit state manually.
- Use moved instead of state mv when possible.

## 7. Maintain Infrastructure with Terraform (Objective 7)

**Key Tasks**

- **Import**: terraform import aws_instance.example i-1234567890abcdef0
- **Taint** (deprecated) → use replace in plan
- Troubleshooting: TF_LOG=DEBUG, terraform console
- State inspection: terraform state list, show -json

**Best Practices**

- Import existing resources carefully (plan after).
- Enable detailed logs only when needed.

## 8. Use HCP Terraform (Objective 8 – New Emphasis in 004)

**HCP Terraform** (Terraform Cloud SaaS)

- Hosted runs, state storage, collaboration
- **Workspaces**: CLI-driven or VCS-connected
- **Projects**: Organize workspaces
- **Variable Sets**: Share variables across workspaces
- **Dynamic Credentials**: OIDC short-lived creds (no long-lived keys)
- **Run Triggers**: Workspace dependencies
- **Remote State**: data "terraform_remote_state"
- **Drift Detection & Health Assessments**
- **Policy Enforcement** (Sentinel or OPA)
- **Explorer & Change Requests** for visibility

**Migration**

- terraform login → connect CLI
- Migrate local state to HCP

**Best Practices**

- Use dynamic credentials for security.
- Organize with projects & variable sets.
- Enable drift detection & notifications.
