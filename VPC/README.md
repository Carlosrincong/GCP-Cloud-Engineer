
# VIRTUAL PRIVATE CLOUD 

VPC is a comprehensive set of Google managed networking objects:
- Networks: networks do not have IP ranges and come in three different flavors; default, auto mode, and custom mode. 

    1.  Default: a subnet is allocated for each region with non-overlapping CIDR blocks and firewall rules that allow ingress traffic for ICMP, RDP, and SSH traffic from anywhere, as well as ingress traffic from within the default network for all protocols and ports.
    2.  Auto: one subnet from each region is automatically created within it. Subnets wich use a set of predefined IP ranges with a /20 mask that can be expanded to /16. All of these subnets fit within the 10.128.0.0/9 CIDR block. As new Google Cloud regions become available, new subnets in those regions are automatically added
    3.  Custom: It does not automatically create subnets and provides you with complete control over its subnets and IP ranges

    The network stores a lookup table that matches external IP addresses with the internal IP addresses of the relevant instances

- Subnetworks allow you to divide or segregate your environment. Concepts: CIDR block, Masks, DHCP.  
- IP addresses for internal and external use along with granular IP address range selections. That means, each virtual machine can have two IP addresses assigned:
    1.  Internal IP address: which is going to be assigned from a subnet via DHCP internally. When you create a VM in Google Cloud, its symbolic name is registered with an internal DNS service that translates the name to an internal IP address.
    2.  External IP address (optional): You can assign an external IP address if your device or machine is externally facing (connections from hosts outside of the project). That external IP address can be assigned from a pool, making it ephemeral, or it can be assigned from a reserved external IP address, making it static. VMs doesn´t know external IP address. It´s mapped to the internal IP address.
- DNS: Each instance has a metadata server that also acts as a DNS resolver for that instance. the DNS name always points to a specific instance, no matter what the internal IP address is. Domain name servers can be hosted on Google Cloud, using Cloud DNS. 
Cloud DNS translates requests for domain names like google.com into IP addresses, also lets you create and update millions of DNS records
- Routes: every network has routes that let instances in a network send traffic directly to each other, even across subnets. In addition, every network has a default route that directs packets to destinations that are outside the network. Routes is what enables VMs on the same network to communicate.

    Routes match packets by destination IP addresses if also matching a firewall rule. A route is created when a subnet is created.
    The virtual network router selects the next hop for a packet by consulting the routing table for that instance.
- Firewall rules: firewall rules protect you virtual machine instances from unapproved connections, both inbound and outbound, known as ingress and egress. The default network has pre-configured firewall rules that allow all instances in the network to talk with each other. Firewall rules are stateful, that means allow bidirectional communication once a session is established. 

    A firewall rule is composed of:
    1.  Direction: inbound connections (ingress rules) or outbound connections (egress rules). For egress rules may be specified using IP CIDR ranges
    2.  Source/Destination: Source of connections or Destination of connections
    3.  Protocol and port:  where any rule can be restricted to apply to specific protocols only or specific combinations of protocols and ports only.
    4.  Action: allow or deny packets
    5.  Priority: which governs the order in which rules are evaluated.
    6.  Rule assignament: By default, all rules are assigned to all instances, but you can assign certain rules to certain instances only.

- Alias IP ranges: Alias IP Ranges let you assign a range of internal IP addresses as an alias to a virtual machine's network interface. This is useful if you have multiple services running on a VM, and you want to assign a different IP address to each service without having to define a separate network interface. You just draw the alias IP range from the local subnet's primary or secondary CIDR ranges.
- VM instances from a networking perspective

## Features

A single VPN can securely connect your on-premises network to your Google Cloud network through a VPN gateway
VMs within the same network can communicate using their internal IP addresses, this means that a single firewall rule can be applied to both VMs. In different network must to comunicate with their external IP addresses. 
The subnet is simply an IP address range, and you can use IP addresses within that range. Every subnet has four reserved IP addresses in its primary IP range
Each IP range for all subnets in a VPC network must be a unique valid CIDR block.
The hostname is the same as the instance name.
FQDN (fully qualified domain name) is: [hostname][zone].c.[projectId].internal

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