
# OBSERVABILITY

The four distinct recurring user needs for observability:
1.  The first one is visibility into system health: verall health of systems, how their application is working on GCP.
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
*   Cloud Monitoring provides visibility into the **performance**, **uptime**, and overall **health** of cloud-powered applications.
*   It collects metrics, events, and metadata from projects, logs, services, systems, agents, custom code, and various common application components, including Cassandra, Nginx, Apache Web Server, Elasticsearch, and many others.
*   Monitoring ingests that data and generates insights via dashboards, Metrics Explorer charts, and automated alerts.
![cloud-monitoring-features](/img/cloud-monitoring-features.png)

## Cloud Logging

Google's Cloud Logging allows users to collect, store, search, analyze, monitor, and alert on **log entries** and events. Logs are **ingested inmediatelly and automatically**.

## Error Reporting
*   Error Reporting counts, analyzes, and aggregates the crashes in your running cloud services.
*   Errors are processed and displayed in the interface within seconds.
*   Alerts you when a new application error cannot be grouped with existing ones.

## Cloud Trace and Cloud Profiler for APM
### Cloud Trace
*   Cloud Trace is a tracing system that collects **latency data** from your distributed applications and displays it in the Google Cloud console.
*   to generate in-depth latency reports to surface **performance degradations** in near-real time

### Cloud Profiler
*   Provide a complete CPU and heap picture of an application without slowing it down.
*   Helps developers understand which paths consume the most **resources** and the different ways in which their **code** is actually called.

