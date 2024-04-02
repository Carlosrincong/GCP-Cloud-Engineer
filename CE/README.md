# Compute Engine

VMs consists of a virtual CPU, some amount of memory, disk storage, and an IP address (networking).
Both predefined and custom machine types allow you to choose how much memory (RAM) and how much CPU (cores) you want.
You can choose the type of storage to use: persistent disk (HDD or SSD), local SSD or Cloud Storage. 
You can run a combination of Linux and Windows machines.

-CPU
CPU will affect your network throughput. Your network will scale at 2 gigabits per second for each CPU core, except for instances with 2 or 4 CPUs which receive up to 10 gigabits per second of bandwidth.
Theorical max of 200 gigabits per second for an instance with 176 vCPU (C3)
-Disk
HDD, standard spinning hard disk drives. HDDs will give you a higher amount of capacity for your dollar. HDD can be sized up to 257 TB for each instance.
SSD, flash memory solid-state drives. SSDs are designed to give you a higher number of IOPS per dollar. SSD can be sized up to 257 TB for each instance
Local SSD, have higher throughput and lower latency than SSD persistent disks, because they are attached to the physical hardware. The data that you store on local SSDs persists only until you stop or delete the instance. Local SSD is used as a swap disk


## Features
- Machine rightsizing: recomendations for optimum machine size, after of 24 hrs of earlier VM create or resize.
- Startup and shutdown scripts
- Metadata
- Availability policies
- OS patch management
- Pricing and usage discounts


# Key considerations
Physical cores have hyperthreading (On-premise). On compute engine, a vCPU is equal to one hardware hyper-thread
To attach a persistent disk to a virtual machine instance, both resources must be in the same zone. I
If you want to assign a static IP address to an instance, the instance must be in the same region as the static IP.
You cannot create a VM instance without a VPC network

# Best practice
It is best practice to run the Cloud Logging agent on all your VM instances.
Preemptible VMs to reduce cost



# VPC (Virtual Private CLoud Network)
Each Google Cloud project has a default network to get you started.
The size of a subnet can be increased by expanding the range of IP addresses allocated to it
VPCs have routing tables. They’re used to forward traffic from one instance to another within the same network. without requiring an external IP address.
VPCs provide a global distributed firewall, which can be controlled. Firewall rules can be defined through network tags on Compute Engine instances
VPC Peering, a relationship between two VPCs can be established to exchange traffic.
Routes tell VM instances and the VPC network how to send traffic from an instance to a destination
Subnets have regional scope

## Firewall rules 
Firewall rules allow you to control which packets are allowed to travel to which destinations

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

# Cloud TPU
TPUs are Google’s custom-developed application-specific integrated circuits (ASICs) used to accelerate machine learning workloads. 
TPUs act as domain-specific hardware, as opposed to general-purpose hardware with CPUs and GPUs. 
TPUs are generally faster than current GPUs and CPUs for AI applications and machine learning.
TPUs are mostly recommended for models that train for long durations and for large models with large effective batch sizes.