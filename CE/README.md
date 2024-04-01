# Compute Engine

VMs consists of a virtual CPU, some amount of memory, disk storage, and an IP address (networking).
Virtual machine Instances and persistent disks live in a zone. 
To attach a persistent disk to a virtual machine instance, both resources must be in the same zone. I
If you want to assign a static IP address to an instance, the instance must be in the same region as the static IP.
It is best practice to run the Cloud Logging agent on all your VM instances.
you cannot create a VM instance without a VPC network
Preemptible VMs to reduce cost

# Firewall rules 
Firewall rules allow you to control which packets are allowed to travel to which destinations

# VPC (Virtual Private CLoud Network)
Each Google Cloud project has a default network to get you started.
The size of a subnet can be increased by expanding the range of IP addresses allocated to it
VPCs have routing tables.
They’re used to forward traffic from one instance to another within the same network. without requiring an external IP address.
VPCs provide a global distributed firewall, which can be controlled. Firewall rules can be defined through network tags on Compute Engine instances
VPC Peering, a relationship between two VPCs can be established to exchange traffic.
Shared VPC
Routes tell VM instances and the VPC network how to send traffic from an instance to a destination
Subnets have regional scope

## Connecting networks to Cloud VPC
- Use Cloud VPN to create a “tunnel” connection. And use feature Cloud Router to make the connection dynamic. This allows us to exchange info between networks and Google VPC using Border Gateway Protocol. highly depend on internet
- Using Direct Peering, Peering means putting a router in the same public data center as a Google point of presence and using it to exchange traffic between networks.
- Carrier Peering
- Dedicated interconnected allows for one or more direct, private connections to Google.
- Partner interconnect provides connectivity between an on-premises network and a VPC network through a supported service provide. This is useful if a data center is in a physical location that can't reach a Dedicated Interconnect, or if the data needs don’t warrant an entire 10 GigaBytes per second connection.
- Cross-Cloud Interconnect helps you establish high-bandwidth dedicated connectivity between Google Cloud and another cloud service provider.

# Load balancing
The job of a load balancer is to distribute user traffic across multiple instances of an application.
You can put Cloud Load Balancing in front of all of your traffic.
No “pre-warming” is required.
For traffic coming into the Google network from the internet: Global HTTP, Global SSL proxy, Global TCP Proxy, Regional External Passthrough Network and Regional External Application load balancer
For traffic inside your project: The Regional Internal load balancer. It accepts traffic on a Google Cloud internal IP address and load balances it across Compute Engine VMs.
Balances traffic Across multiple Compute Engine regions

# CLoud DNS (Domain name service) & Cloud CDN (Content delivery network)
DNS is what translates internet hostnames to addresses
The DNS information you publish is served from redundant locations around the world.
You can publish and manage millions of DNS zones and records 
Google also has a global system of edge caches. Edge caching refers to the use of caching servers to store content closer to end users.
to accelerate content delivery in your application by using Cloud CDN
lower network latency, the origins of your content will experience reduced load
