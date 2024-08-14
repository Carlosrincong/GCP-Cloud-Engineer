# App Engine

App Engine is a fully managed PaaS offering
This means developers can just upload code and App Engine will deploy the required infrastructure and managing the environment.
App Engine is closely integrated with Cloud Monitoring, Cloud Logging, Cloud Profiler, and Error Reporting.
App Engine also supports version control and traffic splitting.
for applications which don’t need to build a highly reliable and scalable infrastructure.
App Engine use cases include: Websites, mobile app and gaming backends and a method to present a RESTful API

There are two types of enviroments: 

Standard
-   Run in Sandbox enviroment, to distribute requests across multiple servers to meet traffic demand
-   Designed for sudden and extreme spikes of traffic

Flexible
-   Run in docker containers
-   Designed for consistent traffic
-   managed vms
