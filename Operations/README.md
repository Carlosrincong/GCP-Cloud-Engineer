
# GOOGLE CLOUD OPERATIONS

Google Cloud operations is a suite of products to monitor, diagnose and troubleshoot infrastructure, services, and applications at scale.
It incorporates capabilities to let DevOps (development operations), SREs (site reliability engineering), or ITOps (information technology operations) 
It offers integrated capabilities for **monitoring**, **logging**, and advanced observability services like **Trace and Profiler**.
The operations suite consists of three broad categories:
1.  Logging: Cloud Logging collects and stores all of your application **logs**, so you can see what's happening under the hood.
2.  Monitoring: Cloud Monitoring collects **metrics and traces**, so you can track the **performance** of your applications and identify bottlenecks
3.  Application Performance Management (APM):  APM provides a unified view of your application's **performance**, so you can quickly identify and fix problems.

## Obervability tools
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
1.  Latency
2.  Traffic
3.  Saturation
4.  Errors