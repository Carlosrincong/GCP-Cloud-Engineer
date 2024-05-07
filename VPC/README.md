# CLOUD VPC (VIRTUAL PRIVATE CLOUD)

VPC is a comprehensive set of Google managed networking objects:
- Networks: networks do not have IP ranges and come in three different flavors; default, auto mode, and custom mode. 

    1.  Default: a subnet is allocated for each region with non-overlapping CIDR blocks and firewall rules that allow ingress traffic for ICMP, RDP, and SSH traffic from anywhere, as well as ingress traffic from within the default network for all protocols and ports.
    2.  Auto: one subnet from each region is automatically created within it. Subnets wich use a set of predefined IP ranges with a /20 mask that can be expanded to /16. All of these subnets fit within the 10.128.0.0/9 CIDR block. As new Google Cloud regions become available, new subnets in those regions are automatically added
    3.  Custom: It does not automatically create subnets and provides you with complete control over its subnets and IP ranges

    The network stores a lookup table that matches external IP addresses with the internal IP addresses of the relevant instances

- Subnetworks allow you to divide or segregate your environment. The network is really nothing else than just a combination of subnets. Concepts: CIDR block, Masks, DHCP.  
- IP addresses for internal and external use along with granular IP address range selections. That means, each virtual machine can have two IP addresses assigned:
    1.  Internal IP address: which is going to be assigned from a subnet via DHCP internally. When you create a VM in Google Cloud, its symbolic name is registered with an internal DNS service that translates the name to an internal IP address.
    2.  External IP address (optional): You can assign an external IP address if your device or machine is externally facing (connections from hosts outside of the project). That external IP address can be assigned from a pool, making it ephemeral, or it can be assigned from a reserved external IP address, making it static. VMs doesn´t know external IP address. It´s mapped to the internal IP address.
- DNS: Each instance has a metadata server that also acts as a DNS resolver for that instance. the DNS name always points to a specific instance, no matter what the internal IP address is. Domain name servers can be hosted on Google Cloud, using Cloud DNS. 
Cloud DNS translates requests for domain names like google.com into IP addresses, also lets you create and update millions of DNS records. In conclusion, VPC networks have an internal DNS service that allows you to address instances by that DNS names, instead of their internal IP addresses.
- Routes: every network has routes that let instances in a network send traffic directly to each other, even across subnets. In addition, every network has a default route that directs packets to destinations that are outside the network. Routes is what enables VMs on the same network to communicate.

    Routes match packets by destination IP addresses if also matching a firewall rule. A route is created when a subnet is created.
    The virtual network router selects the next hop for a packet by consulting the routing table for that instance.
- Firewall rules: firewall rules protect you virtual machine instances from unapproved connections, both inbound and outbound, known as ingress and egress. The default network has pre-configured firewall rules that allow all instances in the network to talk with each other. Firewall rules are stateful, that means allow bidirectional communication once a session is established. 

    A firewall rule is composed of:
    1.  Direction: inbound connections (ingress rules) or outbound connections (egress rules). For egress rules may be specified using IP CIDR ranges
    2.  Source/Destination: Source of connections or Destination of connections
    3.  Protocol and port:  where any rule can be restricted to apply to specific protocols only or specific combinations of protocols and ports only.
    4.  Action: allow or deny packets
    5.  Priority: which governs the order in which rules are evaluated. The higher number, the higher the priority.
    6.  Rule assignament: By default, all rules are assigned to all instances, but you can assign certain rules to certain instances only by using target tags.

- Alias IP ranges: Alias IP Ranges let you assign a range of internal IP addresses as an alias to a virtual machine's network interface. This is useful if you have multiple services running on a VM, and you want to assign a different IP address to each service without having to define a separate network interface. You just draw the alias IP range from the local subnet's primary or secondary CIDR ranges.
- Gateway: translate data packet from a source protocol to destination protocol on network. 
- VM instances from a networking perspective

## Cloud VPN Gateways
In order to create a connection between two VPN gateways, you must establish two VPN tunnels. Each tunnel defines the connection from the perspective of its gateway, and traffic can only pass when the pair of tunnels is established.

1.  Classic VPN: Classic VPN securely connects your on-premises network to your Google Cloud VPC network through an **IPsec VPN tunnel**. Traffic is **encrypted** by one VPN gateway, then **decrypted** by the other VPN gateway. Classic VPN is useful **for low-volume data** connections (max 1460 bytes). 
Supports:
    *   Site-to-site VPN
    *   Static and dynamic routes (**with Cloud Router**)
    *   IKEv1 and IKEv2 ciphers
Classic VPN doesn't support use cases where client computers need to **“dial in” to a VPN using client VPN software**.
2.  High availability or HA VPN: That lets you securely connect your on-premises network to your Virtual Private Cloud (VPC) network through an **IPsec VPN connection in a single region**. For high availability, you must properly **configure two or four tunnels** from your HA VPN gateway to your peer VPN gateway or to another HA VPN gateway. Each of the HA VPN gateway interfaces **supports multiple tunnels** and you can also create multiple HA VPN gateways.
VPN tunnels connected to HA VPN gateways **must use dynamic (BGP) routing**.
You can create an active/active or active/passive **routing configuration**.
Site-to-site VPN: 
    *   HA VPN gateway to peer VPN devices: 
    *   An HA VPN gateway to an Amazon Web Services (AWS) virtual private gateway
    *   Two HA VPN gateways connected to each other

### Cloud Router (to use dynamyc routes and BGP)

Cloud Router can manage routes for a Cloud VPN tunnel using Border Gateway Protocol, or BGP. This routing method allows for routes to be updated and exchanged without changing the tunnel configuration.
To set up BGP, an additional IP address has to be **assigned to each end of the VPN tunnel**. These addresses are not part of IP address space of either network and are used exclusively **for establishing a BGP session**.

## Cloud Interconnect and Peering
Useful to connect your infrastructure to Google’s network.
-   Dedicated connections provide a **direct** connection to Google’s network
-   Shared connections provide a connection to Google’s network **through a partner**.
-   Layer 2 connections use a VLAN that pipes **directly into your GCP environment**, providing connectivity to internal IP addresses in the RFC 1918 address space.
-   Layer 3 connections provide **access to Google Workspace services**, YouTube, and Google Cloud APIs using public IP addresses.
Cloud VPN is a useful addition to Direct Peering and Carrier Peering.

![cloud-interconnect-and-peering](/img/cloud-interconnect-and-peering.png)

### Cloud Interconnect
Traffic is done by exchanging BGP routes.
1.  Dedicated Interconnect: provides **direct physical connections** between your on-premises network and Google’s network. Your network must physically meet Google’s network in a supported colocation facility.
2.  Partner Interconnect: provides connectivity between your on-premises network and your VPC network **through a supported service provider**.  These service providers have existing physical connections to Google's network
3.  Cross-Cloud Interconnect: helps you to **establish high-bandwidth dedicated connectivity** between Google Cloud and another cloud service provider. Google provisions a **dedicated physical connection between** the Google network and that of another cloud service provider.

![network-interconnect](/img/network-interconnect.png)
Google recommends using Cloud Interconnect instead of Direct Peering and Carrier Peering, which you would only use in certain circumstances.

### Cloud Peering
These services are useful when you require **access to Google and Google Cloud properties (GCP)**. Traffic is done by exchanging BGP routes- All of these options provide **public IP address** access to all of Google's services. The main differences are **capacity** and the **requirements** for using a service.

1.  Direct peering: you will be able to exchange Internet traffic between **your network and Google's**. Direct peering does **not have an SLA**. In order to use direct peering you need to satisfy the **peering requirements**.
2.  Carrier peering: In this case you need to satisfy the **partner requeriments**.

![network-peering](/img/network-peering.png)

## Features

- A single VPN can securely connect your on-premises network to your Google Cloud network through a VPN gateway
- VMs within the same network can communicate using their internal IP addresses, this means that a single firewall rule can be applied to both VMs. In different network must to comunicate with their external IP addresses. 
- The subnet is simply an IP address range, and you can use IP addresses within that range. Every subnet has four reserved IP addresses in its primary IP range
- Each IP range for all subnets in a VPC network must be a unique valid CIDR block.
- The hostname is the same as the instance name.
- FQDN (fully qualified domain name) is: [hostname][zone].c.[projectId].internal
- When you create an automatic subnet this comes with predeterminaded CIDR range. These IP address ranges wich you can expand later but not define it in auto subnet.
- You cannot create VM instances without a VPC network.
- VM instances without external IP addresses are isolated from external networks. When instances don't have external IP addresses, they can only be reached by other instances on the network, VPN gateway or Cloud IAP (through SSH and RDP without a bastion host)
- Google Cloud Router dynamically exchanges routes between your VPC and on-premise networks by using Border gateway protocol (BGP). This can be created in region on network. 

## Related network services for private instances

### Cloud NAT
- The Cloud NAT gateway only implements outbound net, not inbound net
- Network address translation service.
- Provides controlled and efficient internet access to private instances (without public IP addresses). Access the internet for updates, patching, configuration management, and more, which is referred to as outbound NAT. Access the internet using a Shared public IP address.
- Cloud NAT does not implement inbound NAT
- Hosts outside your VPC network cannot directly access any of the private instances behind the cloud NAT gateway
- This helps you keep your VPC networks isolated and secure.
- You can set in region level on network.

### Private Google Access
- You should enable private Google access to allow VM instances that only have internal IP addresses to reach the external IP addresses of Google APIs and services. Private Google access has no effect on instances that have external IP addresses
- Private Google Access can be enabled/disabled at the subnet level.

### Cloud IAP (Identity-Aware Proxy)

- IAP allows you to set a central authorization layer for applications reached by HTTP request. That is, an access control at application level, instead of an access control at network level with firewall rules. 
- You can access a private VM (without external IP address and therefore with SSH disabled) via IAP using SSH, by other instances on the network or VPN gateway
- You can use at instance level

## Pricing

### Traffic
- Egress or traffic coming into GCP's network is not charged, unless there is a resource, such as a load balancer that is processing egress traffic
- Responses to request account as egress and are charged.
- Egress traffic to the same zone, is not charged as long as that egress is through the internal IP address of an instance.
- Egress traffic to Google products like YouTube, maps, drive, or traffic to a different GCP service within the same region, is not charged for.
- There is a charge for egress ($0.01 per GB):
    1.  Between zones in the same region
    2.  Within a zone, if the traffic is through the external IP address of an instance
    3.  Between regions

### External IP address (central1)

- Static IP address unused: $0.010
- Static and ephemeral IP address in use on Standard VM: $0.004
- Static and ephemeral IP address in use on Preemptible VM: $0.002
- No charges for static or ephemeral IP addres attached to firewall rules

## Best Practices
1. Avoid creating large subnets: overly large subnets are more likely to cause CIDR range collisions when using Multiple Network Interfaces
2. Do not scale your subnet beyond what you actually need.
3. Expand a subnet in GCP without any workload shutdown or downtime
4. Google strongly recommends using zonal DNS because it offers higher reliability guarantees by isolating failures in the DNS registration to individual zones.
5. by allocating VMs on a single subnet to separate zones, you get improved availability without additional security complexity.
6. As a general security best practice, I recommend only assigning internal IP addresses to your VM instances whenever possible.
7. Google recommends using Cloud Interconnect instead of Direct Peering and Carrier Peering, which you would only use in certain circumstances.