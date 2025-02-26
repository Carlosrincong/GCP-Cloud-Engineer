# OBSERVABILITY

The four distinct recurring user needs for observability:
1.  Visibility into system health: overall health of systems, how their application is working on GCP.
2.  Error reporting and alerting: proactive alerting, anomaly detection, or guidance on issues.
3.  Efficient troubleshooting: the potential cause of the issue and recommend a meaningful direction for the customer to start their investigation.
4.  Performance improvement: perform retrospective analysis, understand how changes in the system affect its performance.

### Monitoring
Monitoring is defined as collecting, processing, aggregating, and displaying real-time quantitative **data about a system**, such as query counts and types, **error** counts and types, processing **times**, and server **lifetimes**.

![public side of monitoring](/img/monitoring-sre-product-sides.png)

To **improve continually** our products we need monitoring data (such as dashboards) and define automated alerts.
To **debugging** application functional and **performance** issues, we need monitoring tools that help provide data crucial

### The four golden signals
There are “four golden **signals”** that measure a system’s *performance and reliability*.
1.  **Latency**: how long it takes a particular part of a system to return a result. Sample **latency metrics** include page load latency, number of requests waiting for a thread, query duration, service response time, transaction duration, time to first response, time to complete data return.
2.  **Traffic**: how many requests are reaching your system (current system demand).It’s a core measure when calculating **infrastructure spend**. Sample **traffic metrics** include number of HTTP requests per second, number of requests for static vs. dynamic content, number of Network I/Os, number of concurrent sessions, number of transactions per second, number of retrievals per second, number of active requests, number of write iops, number of read iops and number active connections.
3.  **Saturation**: how full the service is (most constrained resources). Sample **capacity metrics** include, percentage of memory utilization, percentage of thread pool utilization, percentage of cache utilization, percentage of disk utilization, percentage of CPU utilization, Disk quota, Memory quota, number of available connections and number of users on the system.
4.  **Errors**: which are events that measure system failures or other issues. Sample **error metrics** include wrong answers or incorrect content, number of 400/500 HTTP codes, number of failed requests, number of exceptions, number of stack traces, servers that fail liveness checks and number of dropped connections.

![observability-for-troubleshooting](/img/observability-for-troubleshooting.png)

# GOOGLE CLOUD OBSERVABILITY (STACKDRIVER)

Google Cloud operations is a suite of products to monitor, diagnose and troubleshoot infrastructure, services, and applications at scale.
It incorporates capabilities to let DevOps (development operations), SREs (site reliability engineering), or ITOps (information technology operations) 
It offers integrated capabilities for **monitoring**, **logging**, and advanced observability services like **Trace and Profiler**.
The operations suite consists of three broad categories:
1.  Logging: Cloud Logging collects and stores all of your application **logs**, so you can see what's happening under the hood.
2.  Monitoring: Cloud Monitoring collects **metrics and traces**, so you can track the **performance** of your applications and identify bottlenecks
3.  Application Performance Management (APM):  **APM** provides a unified view of your application's **performance**, so you can quickly identify and fix problems.

## Cloud Monitoring
![cloud-monitoring-features](/img/cloud-monitoring-features.png)
*   Cloud Monitoring provides visibility into the **performance**, **uptime**, and overall **health** of cloud-powered applications.
*   It collects metrics, events, and metadata from projects, logs, services, systems, agents, custom code, and various common application components, including Cassandra, Nginx, Apache Web Server, Elasticsearch, and many others.
*   Monitoring ingests that data and generates **insights** via dashboards, Metrics Explorer charts, and automated alerts.
*   It reveals what needs **urgent attention** and shows trends in application **usage patterns**
*   These metrics are **without cost** and provide information about how the service is **performing**.

#### Arquitecture patterns
*   GMP is a part of Cloud Monitoring and it makes **GKE** cluster and workload metrics available as Prometheus data.
*   Cloud Monitoring and **BindPlane** can provide a single pane of glass for a **hybrid cloud**.
![cloud-monitoring-arquitecture](/img/cloud-monitoring-arquitecture.png)
#### Monitoring multiple projects
*   In monitoring settings for a project, you can see that the current **metrics scope** only has a single project in it by default. But a Single metrics scope can be used for monitoring large units of projects (metrics scoope expanded). Metrics scoopes **only affects** Cloud monitoring tools.
*   Note that the **recommended** approach for production deployments is to create a **dedicated project to host monitoring** configuration data and use its metrics scope to set up monitoring for the projects that have actual resources in them. It also helps **compare** non-prod and prod environments easily
#### Data model and Dasboards
*   Google Cloud sees that your project contains resources and **auto-creates dashboards** for you that radiate the information that Google thinks is important for those two resource types.
![cloud-monitoring.datamodel](/img/cloud-monitoring.datamodel.png)
*   metricKind can be:
    1.  Gauge metric: measures a specific instant in time.
    2.  Delta metric:  measures the change in a time interval.
    3.  Cumulative metric: which the value constantly increases over time.
#### Query metrics
*   Cloud Monitoring supports two query languages: **MQL and PromQL** (CE & GKE). In MQL, operations are linked together by using the common **“pipe” idiom**, where the output of one operation becomes the input to the next.
*   You can use **Grafana** to chart metric data ingested into Cloud Monitoring.
#### Uptime checks
*   Uptime checks can be configured to test the **availability** of your public services using HTTP, HTTPS, or TCP.
*   For each uptime check, you can create an **alerting policy** and view the **latency** of each global location.
### Alerting
#### SLI, SLO and SLA
1.  SLI (service level **indicator**): the number of good events divided by the count of all valid events.
2.  SLO (service level objetive): combines a service level indicator with a **target reliability**. You should choose SLOs that are S.M.A.R.T: Specific, Measurable, Achievable, Relevant and Time-bound. There are two types **Window-based SLOs** use a ratio of the number of good versus bad measurement intervals, or windows. And **Request-based SLOs** use a ratio of good requests to total requests.
3.  SLA (service level agreement): An SLA describes the **minimum levels** of service that you promise to provide to your customers and what happens when you break that promise. Your **alerting thresholds must be often substantially higher than the minimum levels** of service documented in your SLA.
#### Alerting strategy
Send an Alert when a service is down, or an SLO isn't being met.
when a system is heading to spend all of its **error budget** before the allocated time window. Error budget is perfection minus SLO. **Error budget** is the proportion of alerts detected that were relevant to the sum of relevant alerts and missed alerts.
![evaluating-alerts](/img/evaluating-alerts.png)
Define multiple conditions in an alerting policy to get better precision, recall, detection time, and rest time.
![alert-windoe-lenght](/img/alert-window-lenght.png)
One trick might be to use **short windows, but add a successive failure count**. This way, the error is spotted quickly but treated as an anomaly until the **duration** or **error count is reached**.
**Don't involve humans unless** the alert meets some threshold for criticality.
You can use these **levels** to focus on the issues deemed most critical for your operations and triage through the noise.
#### Alerting policy
An alerting policy has: A name, One or more **alert conditions**, Notifications and Documentation. The alerting policies are of two types:
1.  **Metric based** alerting: Policies used to track *metric data* collected by Cloud **Monitoring** are called metric-based alerting policies. There are three types of conditions:
    1.1.    **Metric-threshold conditions** trigger when the values of a metric are more than, or less than, a **threshold** for a specific **duration window**.
    1.2.    **Metric-absence conditions** trigger when there is an *absence of measurements for a duration window*.
    1.3.    **Forecast conditions** predict the **future behavior of the measurements** by using previous data. These conditions trigger when there is a *prediction* that a time series **will violate the threshold within a forecast window**.
2.  **Log based** alerting: Log-based alerting is used to notify anytime a specific **message occurs in a log** in Cloud **Logging** or by using the Cloud Monitoring API.

The **alert condition** is where you decide *what's being monitored* and under what *condition an alert should be generated*.
*   You start with a **target resource and metric** you want the alert to monitor.
*   Then the **yes-no decision logic** for triggering the alert notification is configured. It includes the *trigger condition, threshold, and duration*.

There are direct-to-human **notification channels**:
*   *Email* alerts are **easy and informative**, but they can become notification **spam** if you aren't careful.
*   *SMS* is a great option for **fast notifications**, but choose the recipient carefully.
*   *Slack* is very popular in **support circles**.
*   Mobile Push from *Google Cloud App* is a valid option
For **third-party integration** use 
*   *PagerDuty* is a on-call management and incident response service.
*   *Webhook* to alert users to external systems or code.
*   *Pub/Sub* to alert users to external systems or code.

If you send notifications to a third-party service then you can **parse the JSON payload and route the notification according to its severity**

Because user-defined *labels are included in notifications*, if you add labels that indicate the *severity of an incident*, then the notification contains information that can help you **prioritize your alerts** for investigation.

When the conditions for an alerting policy are met, Cloud Monitoring opens an **incident** in one of three states: 
1.  *Incident firing*  when the alerting policy's set of conditions is **being met** or there’s **no data** to indicate that the condition is no longer met. Open incidents indicate a **new or unhandled alert**
2.  *Acknowledged incidents*  A technician **mark** a new open alert as acknowledged as a signal to others that **someone is dealing with the issue**.
3.  *Alert policies*

You create a **snooze** to prevent *repeated notifications* from being sent for an **open incident**

**Groups** provide a mechanism for *alerting on the behavior of a set of resources* instead of individual resources.

#### Monitoring Console and alerting
Create SLI then the SLO. For alerting create an alerting policy. After the SLO is created, it’s easy to monitor the SLI status, error budget, compliance, and alert status.

## Cloud Logging

Google's Cloud Logging allows users to collect, store, search, analyze, monitor, and alert on **log entries** and events. Logs are **ingested inmediatelly and automatically**. Logs are the **pulse** of your workloads and application. 
Error Reporting, Log Explorer, and Log Analytics let you focus from **large sets of data**.

### Cloud Logging Arquitecture
![cloud-logging-arquitecture](/img/cloud-logging-arquitecture.png)

Log Analysis: 
1.  *Logs explorer* is optimized for **troubleshooting** use cases with features like log streaming
2.  *Error reporting* help users react to **critical application errors** through automated error grouping and notifications.
3.  *Logs-based metrics*, dashboards and alerting provide other ways to understand and make **logs actionable**.
4.  *Log analytics* expands the toolset to include **ad hoc log analysis** capabilities

#### Logs Collection
1.  **Platform logs** are logs written by Google Cloud services.
2.  **Component logs** are similar to platform logs, but they are generated by Google-provided software components that run on your systems.
3.  **Cloud Audit Logs** provide information about administrative activities and accesses within your Google Cloud resources.
4.  **User-written logs** are logs written by custom applications and services. These logs are written to Cloud Logging by using **Ops Agent or Cloud Logging API or Cloud Logging client libraries**.

![automated-logs](/img/automated-logs.png)

#### Log Routing and Storage
![log-routing-and-storage](/img/log-routing-and-storage.png)

Logging automatically creates two **logs buckets**: 
1.  _Required: Admin Activity audit logs, System Event audit logs, and Access Transparency logs, and retains them for 400 days. You **aren't charged** for the logs stored in.
2.  _Default: This bucket holds **all other** ingested logs in a Google Cloud project. Standard Cloud Logging **pricing** applies to these logs. You can't delete this bucket, but **you can disable the _Default log sink** that routes logs to this bucket.

Cloud Logging supports a variety of **log sinks**, including:
1.  *Cloud Logging log buckets* are storage buckets that help you to **pre-separate log entries** into a distinct log storage bucket.
2.  *Cloud Pub/Sub topics* are topics can be used to route log data to **other services**, such as **third-party logging solutions, applications or systems**.
3.  *BigQuery* can be used to store and **analyze** log data.
4.  *Cloud storage bucket* provides **long-term storage** of log data in Cloud Storage.
5.  *Splunk* is used to integrate logs into existing Splunk-based system.

Logs Explorer to build a **query** that selects the logs you want to exclude. Then use the Log Explorer query to create an **exclusion filter** that filters the unwanted entries out of the sink.
When you’re trying to find log entries, start with what you know:  log entry, the log filename, resource name, resorces labels, even a bit of the contents of the logged message might work

##### Use case
1. Export: Pub/Sub >> Dataflow >> BigQuery

*Dataflow* is an excellent option if you're looking for **real-time log processing** at scale. Streaming the logs into *BigQuery* for **longer-term analysis**.

2. Export: Cloud Storage

For long-term retention, reduced storage costs, and configurable object lifecycles.

3. Export: Pub/Sub >> Splunk/third-party SIEM

To integrate the logging data from Google Cloud, back into an **on-premises Splunk instance**.

#### Log-based metrics
Logs-based metrics derive metric data from the content of log entries. 
There are two types of log-based metrics:
1.  *System-defined log-based metrics* provided by Cloud Logging
2.  *User-defined log-based metrics* are **calculated** only from logs that have been ingested by Logging

There are three types of log-based metrics:
1.  Counter metrics: count the **number of log entries matching** an advanced logs query.
2.  Distrinution metrics: record the **statistical distribution** of the extracted log values in histogram buckets with the count, mean, and sum of squared deviations of the values.
3.  Boolean metrics record where a log entry **matches** a specified filter.

All predefined system log-based metrics are the counter type.

There are diferent use cases
1.  Count the ocurrences
2.  Observe trends in the data
3.  Visualize extracted data

With **bucket-scoped log-based metrics**, you can create log-based metrics that can evaluate logs in the following cases: 
1.  Logs that are routed from one project to a bucket in another project.
2.  Logs that are routed into a bucket through an aggregated sink.

#### Log Analytics
Log Analytics gives you the analytical power of BigQuery within the Cloud Logging console and provides you with a new user interface that's optimized for analyzing your logs.
The three prominent **use cases** for Cloud Logging in Log Analyics are troubleshooting, log analytics and reporting.
BigQuery ingestion and storage (analytics-enabled bucket) costs are included in your Logging costs. 
Data residency and lifecycle are managed by Cloud Logging.

## Cloud Audit Logs
Cloud Audit Logs help answer the question, **"Who did what, where, and when?**
Audit logs also inform you about the **resources provisioned using an IaC tool**.
To manage your **Google Cloud organization's logs**, you can aggregate them from across your organization into a single Cloud Logging bucket. Use appropriate IAM controls on both Google Cloud-based and exported logs.
**Custom log views** can be created to **control access** to logs from specific projects or users.
Data in the Data Access audit logs can be deemed as **personally identifiable information** (PII) for an organization.
The most important group of logs in Google Cloud are probably the Cloud Audit Logs.
Theses logs can be reviewed into the **Log Explorer** console
There are four audit logs: 
1.  Admin Activity audit logs: log entries of **administrative** actions that modify the **configuration or metadata of resources**. No charge
2.  System Event audit logs: log entries of actions generated by **Google systems** that modify the **configuration of resources**. No charge
3.  Data Access audit logs: **API calls** that read, create or modify, the configuration or metadata of resources. These logs are **disabled by default** and can be can be enabled at **various levels**: Organization Folder Project, Resources, and Billing accounts. There are three types of Data Access audit logs information:
    
    3.1.    Admin read: records operations that read metadata or configuration information.
    
    3.2.    Data read: records operations that read user-provided data.
    
    3.3.    Data write: records operations that write user-provided data.
    
    You can exempt specific users or groups from having their data accesses recorded. For reduce cost and noise. 

4.  Policy Denied audit logs: When a security policy is violated. The project is charged

# Application Performance Management
Provides insights into how your code and services are functioning.

## Error Reporting
*   Error Reporting counts, analyzes, and aggregates the **crashes and exceptions** in your running cloud services.
*   Error Reporting can only analyze log entries that are stored in **Cloud Logging buckets** that are in the global region.
*   Errors are processed and displayed in the interface within seconds, providing **instant error notification**.
*   Alerts you when a new application error cannot be grouped with existing ones.
*   Helps you to understand errors to **fix the root causes**.
*   Error Reporting can aggregate and display errors for: App Engine, Cloud Functions, App script, Cloud Run, Compute Engine, Amazon EC2 And GKE.
*   Enable the Error **Reporting API**, and install the client library by using npm. Use error message builder to customize all fields.

## Cloud Trace
*   Cloud Trace is a tracing system that collects **latency data** from your distributed applications and displays it in the Google Cloud console, with detailed information for a single request or view aggregate latency for your entire application.
*   A trace describes the **time** that it takes an application to **complete a single operation**. A trace is a collection of spans. A span describes how long it takes to **perform a complete suboperation**.
*   Track how requests propagate through your application 
*   Useful to generate in-depth latency reports to surface **performance degradations** in near-real time
*   The **Trace SDK** is available for Java, Node.js, Ruby, and Go. The **Trace API** can be used to submit and retrieve trace data from any source. The Cloud Trace API **collects trace data and sends it to your Google Cloud project**.
*   There are two ways to send trace data to Cloud Trace: 
    -   Automatic tracing
    -   Instrumenting the application: You can do this by using Google client libraries or **OpenTelemetry (recommended)**.

## Cloud Profiler
*   Provide a complete **CPU, memmory** or heap picture of an application without slowing it down.
*   Helps developers understand which paths consume the most **resources** and the different ways in which their **code** is called.
*   The profiling types available vary by language. The profiling types can be: CPU time, heap, allocated heap, contention, wall time and threads. Check the **API** documentation for your programing lenguage.
*   Profiler instruments applications that run in most Google and non-Google compute technologies.

# Observability for Cloud Services

#### Virtual Machine with Ops Agent
Monitoring information can be **augmented** by installing agents into the VM operating system.
The Ops Agent is the **primary agent for collecting telemetry data (logging and metrics)** from your Compute Engine instances.
These agents are required for security reasons
You can configure the Ops agent to **monitor many third-party** applications
Agent exposes metrics beyond the 80+ metrics that Cloud Monitoring already supports for Compute Engine.
Also ingests any user defined **(Custom) metrics in Prometheus** format.
Ops Agent **logs** can be viewed in the **integration** page of **Monitoring Console**

How to use:
-   Install the ops agent by using the agent policy
-   Install the ops agent by using the Compute engine console > observability > install ops agent > run in the Cloud Shell

#### Non-Virtual machine
1.  App Engine flexible environment is built on top of GKE and has the Monitoring agent pre-installed and configured.
2.  Google Kubernetes Engine nodes (VMs), Cloud Monitoring and Cloud Logging is an option which is enabled **by default**. Google Kubernetes Engine (GKE) also includes integration with Google Cloud **Managed Service for Prometheus (optional).**
With Prometheus in GKE, You must deploy a **PodMonitoring** resource that scrapes a metrics endpoint to see any data in the Query UI. The **ClusterPodMonitoring** resource provides the same interface as the PodMonitoring resource but does not limit discovered pods to a given namespace.
3.  Cloud Run and Cloud Function provides integrated monitoring support, with no setup or configuration required. Cloud Run has two types of logs which is automatically sent to **Cloud Logging**, request logs (requests of the service) and container logs (standard logs).

Managed Service for Prometheus lets users collect metrics from both Kubernetes and VM environments 
![managed-service-for-prometheus](/img/managed-service-for-prometheus.png)

##### Data collection options
-   Managed: recommended approach for all **Kubernetes** environments and is especially suitable for more hands-off **fully managed** experience.
-   Self-deployed: suitable for quick integration into more **complex environment**.
-   Otel (OpenTelemetry):  best to support cross-singal workflows such as exemplars.
-   Ops Agent: the **easiest** way and is recommended to collect and send Prometheus metric data originating from **Compute Engine** environments

##### Custom metrics
To create custom metrics for Cloud Monitoring: You can use the classic **Cloud Monitoring API** Or you can use the **OpenTelemetry protocol and Ops Agent**.
Then you can send that metrics metrics to Cloud Monitoring. Custom metrics can be used in the same way as built-in metrics.
To begin with Cloud monitoring *API*, the data you collect for a custom metric must be associated with a **descriptor for a custom metric type**.

### Networking

#### Traffic
VPC Flow Logs **records a sample** (about one out of ten packets) of **network flows sent from and received by** VM instances, including Google Kubernetes Engine nodes. VPC Flow *Log samples* are from a **VM’s perspective**.
These logs can be used for **network monitoring**, traffic analysis, forensics, real-time security analysis, and expense optimization.
VPC Flow Logs is part of **Andromeda**, the software that powers VPC networks.
You can activate or deactivate **VPC Flow Logs per VPC subnet.** at the network configuration.
**Logs Explorer** can be used to access the VPC Flow Logs.

#### Firewall rules
To know what the firewall rules are doing, how many **connections match** with the rule and the firewall rule is allowing/stoping the **correct traffic**.
Firewall Rules Logging lets you audit, verify, and analyze **the effects of your firewall rules**. These logs are **disabled by default**.
Firewall Rules Logging can **only record TCP and UDP** connections. For other protocols, use **Packet Mirroring**.
Firewall Rules Logging can generate a **lot of data**, which might have a **cost implication**.
**Logs Explorer** to view logs in real time or to configure exports.

#### Load balancers
Logs all the load balancing **requests sent to your load balancer**. To know how each connection is routed to serving backends.
These logs can be used for debugging and analyzing your **user traffic**.

#### Cloud NAT
Log entry can be generated when a** network connection (TCP or UDP) that uses Cloud NAT** is created, and/or when an **egress packet is dropped** because no port was available for Cloud NAT.
To view the collected logs in **Logs Explorer**, filter to the Cloud NAT Gateway resource 

#### Packet Mirroring
Packet Mirroring **clones the traffic (ingress/egress) and its data of specific instances** in your Virtual Private Cloud (VPC) network and forwards it for examination (threats or anomalies). This is useful in **security and monitoring**.
-   Security: usage of the following **security tools**: Intrusion detection systems match signatures with multiple packets of a single flow. Deep Packet Inspection engines inspect payloads for anomalies.
-   Monitoring: to maintain **integrity of deployment**. Troubleshoots like Packet loss issues (analyzing protocols), and reconnection and latency issues (analyzing real time traffic patterns)
-   Network forensics for PCI compliance

The mirroring **happens on the virtual machine** (VM) instances, not on the network. Therefore **consumes additional bandwidth** on the hosts, which is one of the major **limitations** of Packet Mirroring is bandwidth consumption. Use **filters to reduce** the traffic collected for mirrored instances.
Packet Mirroring exports monitoring data about mirrored traffic to **Cloud Monitoring**.

#### Network Intelligence Center
Currently, it offers five modules: 
-   Network Topology: visualizes your Google Cloud **network as a graph** to explore your existing configurations and quickly troubleshoot networking issues.
-   Connectivity Tests: diagnose **connectivity issues** and prevent outages.
-   Performance Dashboard: gives you visibility into the **performance of your VPC**
-   Firewall Insights: produces **metrics and insights** that let you make better decisions about your **firewall rules** and to knwo how these are being used.
-   Network Analyzer: monitors your VPC network configurations and **detects misconfigurations and suboptimal configurations**.

# Pricing
Cost is usage-based and not infrastructure-based.
Cloud Profiler is offered at **no cost**
Cloud Logging (incluiding Error reporting), Cloud Monitoring, and Cloud Trace has an **associated costs**.

-   Logging pricing is based on the volume of chargeable **logs ingested**.
-   Cloud Monitoring prices are based on the: Volume of chargeable metrics ingested, Number of chargeable API calls, Execution of Cloud Monitoring uptime checks, Metrics ingested by using Google Cloud Managed Service for Prometheus.
-   Trace prices are based on the number of **spans ingested** and eventually scanned

Many functions of the Google Cloud operations suite are free, including: Using Cloud Profiler. Collecting and using the Cloud Audit Logs, Access Transparency logs, BigQuery Data Access logs and anything excluded from logs. Creating and using dashboards. Visualizing Google Cloud and Anthos metrics and log streams. App Engine standard trace spans. Uptime checks. Logs analytics when queries are running in Cloud Logging.


The networking logs, including VPC Flow logs, Firewall Rules Logging, and Cloud NAT, will cost you the standard log storage fees. However, if you store them in Cloud Logging, they won't cost you anything extra to generate.

## Best practice
-   If you exclude log entries, you don't pay for them. Common exclusions: Load Balancing, VPC flow logs (completly deactive) and web applications with their http 200 OK response. 
-   Log exports are free, but not the target resource. 
-   You can export logs yet exclude them from being ingested into Cloud Logging.
-   2 TiBs of data access log data stored in Logging would cost about $1,000. The same 2 TiBs stored in a regional, standard class bucket would cost about $40.
-   Reduce Ops Agent usage.
-   How you use labels on Monitoring custom metrics can affect the volume of time series that are generated
-   Custom metrics can increase spend.
-   Trace charges are based on the number of trace spans ingested and scanned.
-   Sampling is not only a best practice for using Cloud Trace: you might reduce your span volume for cost-reduction reasons too.