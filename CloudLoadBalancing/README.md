# Cloud Load Balancing

Cloud Load Balancing gives you the ability to distribute load-balanced compute resources in single or multiple regions to meet your **high availability requirements**, to put your resources behind a **single anycast IP address**, and to scale your resources up or down with **intelligent autoscaling**. You can **serve content as close as possible** to your users. There are two types:

1.  Global: These load balancers leverage the Google frontends (which are software-defined). Distributed systems that **sit in Google’s points of presence**. You want to use a global load balancer when your users and instances are distributed **globally**, your users need access to the **same applications and content**, and you want to provide access using a **single anycast IP address**. The global load balancers are the HTTP(S), SSL proxy, and TCP proxy load balancers.
2.  Regional: The Six regional load balancers are external and internal HTTP(S), TCP Proxy, and TCP/UDP network.

## Choosing load balancer
Only the HTTP(S), SSL proxy, and TCP proxy load balancing services support IPv6 clients. These services handle IPv6 requests from your users and proxy them over IPv4 to your backends, and vice versa is the same.

![choosing-load-balancer](/img/choosing-load-balancer.png)

You'd choose an Application Load Balancer when you need a flexible feature set for your applications with HTTP(S) traffic.
You'd choose a proxy Network Load Balancer to implement TLS offload, TCP proxy, or support for external load balancing to backends in multiple regions.
You'd choose a passthrough Network Load Balancer to preserve client source IP addresses, avoid the overhead of proxies, and to support additional protocols like UDP, ESP, and ICMP. UDP, or if you need to expose client IP addresses to your applications.
You can further narrow down your choices depending on your application's requirements: whether your application is **external(internet-facing)**, or **internally**, and whether you need backends deployed **globally**, or **regionally**.

![summary-load-balancers.png](/img/summary-load-balancers.png)
-MANAGED: requests are routed either to the Google Front End or to the Envoy proxy.

### HTTP(s) Load Balancing
User traffic directed to an HTTP(S) load balancer enters the POP (Point of presence) closest to the user and is then load-balanced over Google's global network to the closest backend that has sufficient available capacity.
allowing for routing decisions based on the URL.
your applications are available to your customers at a **single anycast IP address**, which simplifies your DNS setup.
HTTP(S) load balancing balances HTTP and HTTPS traffic across multiple back-end instances and across multiple regions (if you setup **global** load balancing)
HTTP on port 80 or port 8080. HTTPS on port 443. This load balancer supports both IPv4 and IPv6 clients
You can configure **URL maps** that route some URLs to one set of instances and route other URLs to other instances.
Requests are generally routed to the instance group that have **capacity and is closest** to the user.
![architecture-http-load-balancer](/img/architecture-http-load-balancer.png)
Instances that pass the **health check** are allowed to receive new requests.
**Session affinity** (optional) attempts to send all requests from the same client to same virtual machine instance.
-   An HTTP(S) load balancer requires at least once (with up to 15) signed **SSL certificate installed** on the target HTTPS proxy for the load balancer. The client **SSL sessions** terminate at the load balancer.
For each SSL certificate, you first create an **SSL certificate resource**, which contains the SSL certificate information. This resource is **only used with** the load balancing proxies (HTTPS proxy or target SSL proxy).
-   **Backend buckets** allow you to use Google **Cloud Storage** buckets with HTTP(S) Load Balancing. Use case: send requests for *dynamic content*, such as data, to a *backend service*; and send requests for *static content*, such as images, to a *backend bucket*.
-   Network endpoint group (NEG): This is a configuration object that specifies a **group of backend endpoints** or services. Useful to deploying services in **containers**. Define **how endpoints should be reached**, whether they are reachable, and where they are located. **Serverless NEGs** don't contain endpoints.

#### Cloud CDN (Content Delivery Network)
Cloud CDN **caches content or HTTP(S) load-balanced content** at the edge of Google's network providing **faster delivery** of content close to your users while reducing serving costs. Content can be cached at **CDN nodes**
You can enable Cloud CDN with a simple checkbox when setting up the backend service of your HTTP(S) load balancer.
Each Cloud CDN request is automatically logged within Google Cloud. These logs will indicate a “Cache Hit (cached data)” or “Cache Miss (uncached data)” status for each HTTP request 
Cache modes to control the factors that determine whether or not Cloud CDN caches your content, how responses are cached, whether or not Cloud CDN respects cache directives sent by the origin, and how cache TTLs are applied.
The available cache modes are 
1.  USE_ORIGIN_HEADERS: **requires origin responses to set valid** cache directives and valid caching headers.
2.  CACHE_ALL_STATIC: **automatically caches static content** that doesn't have the no-store, private, or no-cache directive. Origin responses that set valid caching directives are also cached.
3.  FORCE_CACHE_ALL: **unconditionally caches** responses, overriding any cache directives set by the origin. You should make sure **not to cache private, per-user content** (such as dynamic HTML or API responses) if using a shared backend with this mode configured.

### SSL proxy load balancing
SSL proxy is a *global* load balancing service for **encrypted non-HTTP traffic or SSL Traffic**.
This load balancer **terminates user SSL connections** at the load balancing layer, then balances the connections across your instances using the SSL (recommended) or TCP protocols.
This load balancer supports:
*   both **IPv4 and IPv6** addresses for client traffic
*   provides **intelligent routing**: load balancer can route requests to back-end locations where **there is capacity**.
*   Certificate management: to update your customer-facing certificate. Using self-signed certificates on your instances.
*   Security patching: in order to keep your instances safe when vulnerabilities are detected
*   SSL policies

### TCP proxy load balancing
TCP proxy is a *global* load balancing service for **unencrypted, non-HTTP traffic or TCP Traffic**.
This load balancer **terminates your customer's TCP sessions** at the load balancing layer then forwards the traffic to your virtual machine instances using TCP or SSL (recommended).
This load balancer supports:
*   both **IPv4 and IPv6** addresses for client traffic
*   provides **intelligent routing**: load balancer can route requests to back-end locations where **there is capacity**.
*   Security patching: in order to keep your instances safe when vulnerabilities are detected

### Network load balanncing
Network load balancing is a *regional*, **non-proxied** load balancing service. That means all traffic is passed through the load balancer instead of being proxied, and the traffic can only be balanced between VM instances that are in the same region.
This load balancing service uses **forwarding rules to balance** the load of your systems **based on the incoming IP protocol data**, such as address, port and protocol type.
You can use it to load balance **UDP traffic** and to load balance **TCP and SSL traffic** on ports that are not supported with the TCP proxy and SSL proxy load balancers.
The architecture of a network load balancer depends on whether you use:
*   back-end service-based network load balancer:  support for non-legacy health checks, TCP, SSL, HTTP, HTTPS and HTTP/2 auto-scaling with managed instance groups, connection draining and a configurable failover policy.
*   target-pool-based network load balancer: A target pool resource defines a group of instances that receive incoming traffic from forwarding rules. When a forwarding rule directs **TCP and UDP traffic** to a target pool, the load balancer picks an instance from these target pools based on a hash of the source IP and port and the destination IP and port. Each project can have **up to 50 target pools**, and each target pool can only have **one health check**. All the instances of a target pool must be in the **same region**, which is the same limitation as for the network load balancer.

## Internal load balancing

### Internal TCP/UDP load balancing
The internal TCP/UDP load balancer is a *regional private* load balancing service for **TCP and UDP-based traffic**.
Load balancing with a private load balancing IP address. You don't need a public IP address
You configure an **internal TCP/UDP load balancing IP address** to act as the **front end** to your private back-end instances.
**lowered latency** because all of your load balanced traffic stays within Google's network
It uses lightweight load balancing built on top of *Andromeda* that **directly delivers the traffic** from the client instance to a back-end instance

# Internal HTTPS load balancing
The internal HTTPS load balancing is a **proxy-based regional** layer seven load balancer based **Envoy proxy** that works using an Internal load balancing IP address.
Support HTTP, HTTPS and HTTP/2 protocols.
Envoy proxy: This enables rich traffic **control capabilities** based on HTTPS parameters.

# Best practice
it's useful to combine an internal and an external load balancer to support three-tier web services.