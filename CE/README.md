
# Compute Engine

VMs consists of a virtual CPU, some amount of memory, disk storage, and an IP address (networking).
Both predefined and custom machine types allow you to choose how much memory (RAM) and how much CPU (cores) you want.
You can choose the type of storage to use: persistent disk (HDD or SSD), local SSD or Cloud Storage. 
You can run a combination of Linux and Windows machines.

- CPU
CPU will affect your network throughput. Your network will scale at 2 gigabits per second for each CPU core, except for instances with 2 or 4 CPUs which receive up to 10 gigabits per second of bandwidth.
Theorical max of 200 gigabits per second for an instance with 176 vCPU (C3)
- Disk
HDD, standard spinning hard disk drives. HDDs will give you a higher amount of capacity for your dollar. HDD can be sized up to 257 TB for each instance.
SSD, flash memory solid-state drives. SSDs are designed to give you a higher number of IOPS per dollar. SSD can be sized up to 257 TB for each instance
Local SSD, have higher throughput and lower latency than SSD persistent disks, because they are attached to the physical hardware. The data that you store on local SSDs persists only until you stop or delete the instance. Local SSD is used as a swap disk
- OS
Linux: the creator has SSH capability and can grant SSH capability to other users. Requeries firewall rules to allow tpc:22
Windows: the creator can use RDP and can generate a username and password to other users. Requeries firewall rules to allow tpc:3389
- Machine Type
There are several machine families you can choose from and each machine family is further organized into machine series and predefined machine types within each series. Machine family is a curated set of processor and hardware configurations optimized for specific workloads.
    * General-purpose: the best price-performance with the most flexible vCPU to memory ratios. Oriented to the most standard and cloud-native workloads.
        1.  E2: The E2 machine series is suited for day-to-day computing at a lower cost, especially where there are no application dependencies on a specific CPU architecture. Good for small applications that don't have strict performance requirements (non-resource intensive). The E2 machine series also contains shared-core machine types that use context-switching to share a physical core between vCPUs for multitasking.
        2.  N2, N2D, N1: provide a balance between price and performance. N2 supports Intel with up to 128 vCPUs, Cascade Lake with up to 8 vCPUs and Ice Lake for larger machine types. N2D are AMD-based general purpose VMs with both processors EPYC Milan and EPYC Rome. 
        3.  Tau T2D, Tau T2A: optimized for cost-effective performance of demanding scale-out workloads. T2D VMs are built on the latest 3rd Gen AMD EPYCTM processors and offer full x86 compatibility. Tau T2A run on Arm processor, best for containerized workloads. 
        ![general-purpose-vm](/img/general-purpose-vm.png)
    * Compute-optimized: The compute-optimized machine family has the highest performance per core on Compute Engine and is optimized for compute-intensive workloads.
        1.  C2: the best fit VM type for compute-intensive workloads. Powered by high-frequency Intel-scalable processors, Cascade Lake. 
        2.  C2D: provides the largest VM sizes and are best-suited for high-performance computing, also has the largest available last-level cache per core. C2D VMs are available on the third generation AMD EPYC Milan platform.
        3.  H3: available on the Intel Sapphire Rapids CPU platform and Google's custom Intel Infrastructure Processing Unit (IPU).
        ![compute-optimized-vm](/img/compute-optimized-vm.png)
    * Memory-optimized: The memory-optimized machine family provides the most compute and memory resources. They are ideal for workloads that require higher memory-to-vCPU ratios. 
        1.  M1, M2: great choice for workloads that utilize higher memory configurations with low compute resource requirements. Both the M1 and M2 machine series offer the lowest cost per GB of memory on Compute
        ![memmory-optimized-vm](/img/memmory-optimized-vm.png)
    * Accelerator-optimized: ideal for massively parallelized Compute Unified Device Architecture (CUDA) compute workloads, such as machine learning and high-performance computing. This family is the optimal choice for workloads that require GPUs.
        1.  A2: A2 has a fixed number (up to 16) of NVIDIA’s Ampere A100 GPUs attached, with 40 GB of GPU memory.
        2.  G2: G2 are available on the Intel Cascade Lake CPU platform
        ![acelerator-optimized-vm](/img/acelerator-optimized-vm.png)

Custom machine types are ideal for the following scenarios: When you have workloads that are not a good fit for the predefined machine types that are available to you. Or when you have workloads that require more processing power or more memory, but don't need all of the upgrades that are provided by the next larger predefined machine type. It costs slightly more to use a custom machine type than an equivalent predefined machine type, and there are still some limitations. 

## VM Lifecycle

![VM_lifecycle](/img/VM_lifecycle.png)

- Provisioning: when you define all the properties of an instance and click Create, the instance enters the provisioning state. the resources are being reserved for the instance, but the instance itself isn’t running yet.
- Staging: where resources have been acquired and the instance is prepared for launch. Compute Engine is adding IP addresses, booting up the system image, and booting up the system.
- Running: it will go through pre-configured startup scripts and enable SSH or RDP access. While your instance is running, you can also move your VM to a different zone, take a snapshot of the VM’s persistent disk, export the system image, or reconfigure metadata.
- Stopping: When the instance enters this state, it will go through pre-configured shutdown scripts and end in the terminated state. Some actions require you to stop your virtual machine; for example, if you want to upgrade your machine by adding more CPU.
- Terminated: The result of stopping cycle. From this state, you can choose to either restart the instance, which would bring it back to its provisioning state, or delete it.

        When a VM is terminated, you do not pay for memory and CPU resources. However, you are charged for any attached disks and reserved IP addresses.
    ![VM_terminated state](/img/VM_terminated_state.png)
- Reset VM: This action wipes the memory contents of the machine and resets the virtual machine to its initial state. The instance remains in the running state through the reset.
- Repairing: Repairing occurs when the VM encounters an internal error or the underlying machine is unavailable due to maintenance. During this time, the VM is unusable. You are not billed when a VM is in repair.
- Suspending: before of this state you can then resume the VM or delete it.

![changing state](/img/changing_vm_state.png)

## Features
- Machine rightsizing: recomendations for optimum machine size, after of 24 hrs of earlier VM create or resize.
- Startup and shutdown scripts: the shutdown process will take about 90 sec.
- Metadata
- Availability policies: A VM’s availability policy determines how the instance behaves in such an event, such as a crash or other maintenance event. These availability policies can be configured both during the instance creation and while an instance is running by configuring the Automatic restart and On host maintenance options.
- OS patch management: Managing patches effectively is a great way to keep your infrastructure up-to-date and reduce the risk of security vulnerabilities. The OS patch management service has two main components: Patch compliance reporting (insights on the patch) and Patch deployment (schedules patch jobs).
    1.  Create patch approvals
    2.  select patches to apply from set of updates
    3.  Set up flexible scheduling, when to run patch updates
    4.  Apply advanced patch configuration settings, pre and post patching scripts.
- Pricing and usage discounts: Committed use and sustained use discounts.
    1.  Per-second billing, with  minimum of 1 minute for vCPUs, GPUs and GB of memmory usage.
    2.  Resource-based princing: vCPUS and GB of memmory ara charged separetly. 
    3.  Discounts: discounts can´t be combine 
        *   Sustained use: These are automatic discounts wich increase with the use. these can be applied to N1, N2, N2D, C2, M1 y M2 VMs. Id addition, discount can be applied over VM created with Compute engine and Kubernetes engine. App engine (flexible and standard) and dataflow are not inclued. Discounts are monthly and start on the 1st day of each month. Google combines the total usage of VMs in one month by region, desglosing in terms of vCPUs and Memmory to apply higher discounts based on their use. 
        *   Commited use
        *   Preemptible VM instances: lower price (up to 91%). These VMs might be preempted at any time, and there is no charge if that happens within the first minute. Also, preemptible VMs are only going to live for up to 24 hours, and you only get a 30-second notification before the machine is preempted. You can actually create monitoring and load balancers that can start up new preemptible VMs in case of a failure. One major use case for preemptible VMs is running batch processing jobs. If some of those instances terminate during processing, the job slows but it does not completely stop.
        *   Spot VM instances: these are the lates version of preemptible VM instances with the same pricing model. Spot VMs do not have a maximum runtime. Spot VM are finite and not always be avaible. Like preemptible VMs, it's worth noting that Spot VMs can't live-migrate to become standard VMs while they are running or be set to automatically restart when there is a maintenance event. It is often easier to get for smaller machine types
- Sole-tenant nodes: ideal if you have workloads that require physical isolation from other workloads or virtual machines in order to meet compliance requirements. A sole-tenant node is a physical server that is dedicated to hosting VM instances only for your specific project. Usefull if you want bring yours operating system licenses. 
- Shielded VM: Shielded VMs offer verifiable integrity to your VM instances, so you can be confident that your instances haven't been compromised by boot or kernel-level malware or rootkits. These offers features, like vTPM shielding or sealing, that help prevent data exfiltration. you need to select a shielded image to create these instances. 
- Confidential VMs are a breakthrough technology that allows you to encrypt data in use, while it's been processed.

# Key considerations
Physical cores have hyperthreading (On-premise). On compute engine, a vCPU is equal to one hardware hyper-thread
To attach a persistent disk to a virtual machine instance, both resources must be in the same zone. I
If you want to assign a static IP address to an instance, the instance must be in the same region as the static IP.
You cannot create a VM instance without a VPC network
When a VM is terminated, you do not pay for memory and CPU resources. However, you are charged for any attached disks and reserved IP addresses.
You could keep your boot disk and just reattach that boot disk later on
A custom machine is generally going to be slightly more expensive than standard.

# Best practice
It is best practice to run the Cloud Logging agent on all your VM instances.
Preemptible VMs to reduce cost
Managing patches effectively is a great way to keep your infrastructure up-to-date and reduce the risk of security vulnerabilities
If you building and redundancy for availability, remember to allocate excess capacity to meet performance requirements.
I recommend that you first configure the instance through the Google Cloud console and then ask Compute Engine for the equivalent REST request or command line

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