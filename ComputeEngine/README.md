
# Compute Engine

VMs consists of a virtual CPU, some amount of memory, disk storage, and an IP address (networking).
Both predefined and custom machine types allow you to choose how much memory (RAM) and how much CPU (cores) you want.
You can choose the type of storage to use: persistent disk (HDD or SSD), local SSD or Cloud Storage. 
You can run a combination of Linux and Windows machines.

### CPU
CPU will affect your network throughput. Your network will scale at 2 gigabits per second for each CPU core, except for instances with 2 or 4 CPUs which receive up to 10 gigabits per second of bandwidth.
Theorical max of 200 gigabits per second for an instance with 176 vCPU (C3)

### Disk
Every single VM comes with a single root persistent disk. 
It's going to be attached to the VM through the network interface. 
Even though it's persistent, it's **not physically attached to the machine**. This separation of disk and compute allows the disk to survive if the VM terminates.
You can **dynamically resize** them, even while they are running and attached to a VM.
You can also attach a disk in read-only mode to multiple VMs. This allows you to **share static data between multiple instances**, which is cheaper than replicating your data to unique disks for individual instances. 
Regional persistent disks provide **active-active disk replication** across two zones in the same region. That is **synchronously replicated across zones** and are a great option for high-performance databases and enterprise applications that also require high availability.
So if you plan on having a large amount of Disk IO throughput, it will also **compete with any network egress or ingress throughput**.
![disk-options](/img/disk-options.png)

#### Persistent disks
Persistent disks can be rebooted and snapshotted. The persistent disks offer data redundancy because the data on each persistent disk is distributed across several physical disks.
- HDD (Zonal or Regional): standard spinning hard disk drives. HDDs will give you a higher amount of capacity for your dollar. HDD can be sized up to 257 TB for each instance. Great choise for workloads that primarily use sequential I/Os of bulk sile storage.
- SSD (Zonal or Regional): flash memory solid-state drives. SSDs are designed to give you a higher number of IOPS per dollar. SSD can be sized up to 257 TB for each instance. Ideal for high-performance databases that require lower latency and more IOPS than standard persistent disks provide.
- Balanced SSD (Zonal or Regional): These disks have the same maximum IOPS as SSD persistent disks and lower IOPS per gigabyte. This disk type offers performance levels suitable for most general-purpose applications
- Extreme SSD (Zonal) This desk is ideal for both random access workloads and bulk throughput. Unlike other disk types, you can provision your desired IOPS.
#### Attached disks
local SSDs and RAM disks are ephemeral. Local SSDs provide even higher performance (than persistent disks), but without the data redundancy.
- Local SSD : have higher throughput and lower latency than SSD persistent disks, because they are attached to the physical hardware. The data that you store on local SSDs persists only until you stop or delete the instance. Local SSD is used as a swap disk. Data on these disks will survive a reset but not a VM stop or terminate, because these disks can’t be reattached to a different VM.
- RAM Disk: You can simply use **tmpfs** if you want to store data in memory.

### OS
- Linux: the creator has SSH capability and can grant SSH capability to other users. Requeries firewall rules to allow tpc:22
- Windows: the creator can use RDP and can generate a username and password to other users. Requeries firewall rules to allow tpc:3389

### Machine Type
There are several machine families you can choose from and each machine family is further organized into machine series and predefined machine types within each series. Machine family is a curated set of processor and hardware configurations optimized for specific workloads.

- General-purpose: the best price-performance with the most flexible vCPU to memory ratios. Oriented to the most standard and cloud-native workloads.
    1.  E2: The E2 machine series is suited for day-to-day computing at a lower cost, especially where there are no application dependencies on a specific CPU architecture. Good for small applications that don't have strict performance requirements (non-resource intensive). The E2 machine series also contains shared-core machine types that use context-switching to share a physical core between vCPUs for multitasking.
    2.  N2, N2D, N1: provide a balance between price and performance. N2 supports Intel with up to 128 vCPUs, Cascade Lake with up to 8 vCPUs and Ice Lake for larger machine types. N2D are AMD-based general purpose VMs with both processors EPYC Milan and EPYC Rome. 
    3.  Tau T2D, Tau T2A: optimized for cost-effective performance of demanding scale-out workloads. T2D VMs are built on the latest 3rd Gen AMD EPYCTM processors and offer full x86 compatibility. Tau T2A run on Arm processor, best for containerized workloads. 
    ![general-purpose-vm](/img/general-purpose-vm.png)
- Compute-optimized: The compute-optimized machine family has the highest performance per core on Compute Engine and is optimized for compute-intensive workloads.
    1.  C2: the best fit VM type for compute-intensive workloads. Powered by high-frequency Intel-scalable processors, Cascade Lake. 
    2.  C2D: provides the largest VM sizes and are best-suited for high-performance computing, also has the largest available last-level cache per core. C2D VMs are available on the third generation AMD EPYC Milan platform.
    3.  H3: available on the Intel Sapphire Rapids CPU platform and Google's custom Intel Infrastructure Processing Unit (IPU).
    ![compute-optimized-vm](/img/compute-optimized-vm.png)
- Memory-optimized: The memory-optimized machine family provides the most compute and memory resources. They are ideal for workloads that require higher memory-to-vCPU ratios. 
    1.  M1, M2: great choice for workloads that utilize higher memory configurations with low compute resource requirements. Both the M1 and M2 machine series offer the lowest cost per GB of memory on Compute
    ![memmory-optimized-vm](/img/memmory-optimized-vm.png)
- Accelerator-optimized: ideal for massively parallelized Compute Unified Device Architecture (CUDA) compute workloads, such as machine learning and high-performance computing. This family is the optimal choice for workloads that require GPUs.
    1.  A2: A2 has a fixed number (up to 16) of NVIDIA’s Ampere A100 GPUs attached, with 40 GB of GPU memory.
    2.  G2: G2 are available on the Intel Cascade Lake CPU platform
    ![acelerator-optimized-vm](/img/acelerator-optimized-vm.png)

Custom machine types are ideal for the following scenarios: When you have workloads that are not a good fit for the predefined machine types that are available to you. Or when you have workloads that require more processing power or more memory, but don't need all of the upgrades that are provided by the next larger predefined machine type. It costs slightly more to use a custom machine type than an equivalent predefined machine type, and there are still some limitations. 

### Images (boot disk image):
Images are bootable in that you can attach it to a VM and boot from it, and it is durable in that it can survive if the VM terminates.
Premium images will have per-second charges after a 1-minute minimum, with exceptions.  It price vary with the machine type. 
Custom images by either pre-configuring and pre-installing software or importing images from your own premises, cloud provider or workstation. 
Machine image is a resource that stores all the configuration, metadata, permissions, and data required to create a virtual machine. You can use a machine image in many system maintenance scenarios, such as creation, backup and recovery, and instance cloning. Machine images are the most ideal resources for disk backups as well as instance cloning and replication.
The image includes: Boot loader, operating system, file system structure, software and customizations

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
        *   Preemptible VM instances: lower price (up to 91%). Ideal for workloads that can be interrupted safely. These VMs might be preempted at any time, and there is no charge if that happens within the first minute. Also, preemptible VMs are only going to live for up to 24 hours, and you only get a 30-second notification before the machine is preempted. You can actually create monitoring and load balancers that can start up new preemptible VMs in case of a failure. One major use case for preemptible VMs is running batch processing jobs. If some of those instances terminate during processing, the job slows but it does not completely stop.
        *   Spot VM instances: these are the lates version of preemptible VM instances with the same pricing model. Spot VMs do not have a maximum runtime. Spot VM are finite and not always be avaible. Like preemptible VMs, it's worth noting that Spot VMs can't live-migrate to become standard VMs while they are running or be set to automatically restart when there is a maintenance event. It is often easier to get for smaller machine types
- Sole-tenant nodes: ideal if you have workloads that require physical isolation from other workloads or virtual machines in order to meet compliance requirements. A sole-tenant node is a physical server that is dedicated to hosting VM instances only for your specific project. Usefull if you want bring yours operating system licenses. 
- Shielded VM: Shielded VMs offer verifiable integrity to your VM instances, so you can be confident that your instances haven't been compromised by boot or kernel-level malware or rootkits. These offers features, like vTPM shielding or sealing, that help prevent data exfiltration. you need to select a shielded image to create these instances. 
- Confidential VMs: Confidentials are a breakthrough technology that allows you to encrypt data in use, while it's been processed.
- Snapshots: Snapshots are available only to persistent disks and not to local SSDs. Snapshots are incremental and automatically compressed. Snapshots can be used to **backup critical data into a durable storage** solution to meet application, availability, and recovery requirements. Snapshots can also be used to **migrate data** between zones and **transferring data to a different disk type**.

## Manage Instance group
A managed instance group is a collection of **identical** VM instances that you control as a single entity using an **instance template**. Managed instance groups can **scale automatically (and under what circumstances)** to the number of instances in the group. Managed instance groups can **work with load balancing services** to distributor network traffic to all of the instances in the group (**resize group**). If you setup a health check defining a protocol, port, and **health criteria**, managed instance groups can automatically identify and **recreate unhealthy instances** in a group to ensure that all instances are running optimally. The instance group manager then **automatically populates the instance group** based on the instance template.
You can use managed instance groups for:
*   **Stateless** serving or batch workloads. Such as website front end or image processing from a queue
*   **Stateful** applications. Such as databases or legacy applications.

**Autoscaling** helps your applications gracefully **handle increases in traffic** and reduces cost when the need for resources is lower. You just **define the autoscaling policy**, and the autoscaler performs automatic scaling based on the measured load. Such as **CPU** utilization, **load balancing** capacity, or monitoring metrics, or by a **queue-based workload** like Pub/Sub or **schedule** such as start-time, duration and recurrence.
The **health criteria** define how often to check whether an instance is healthy (that’s the check interval); how long to wait for a response (that’s the timeout); how many successful attempts are decisive (that’s the healthy threshold); and how many failed attempts are decisive (that’s the unhealthy threshold).
Configuring **stateful IP addresses** in a managed instance group ensures that applications **continue to function** seamlessly during autohealing, update, and recreation events.

## Key considerations
Physical cores have hyperthreading (On-premise). On compute engine, a vCPU is equal to one hardware hyper-thread
To attach a persistent disk to a virtual machine instance, both resources must be in the same zone. Similarly, if you want to assign a static IP address to an instance, the instance must be in the same region as the static IP.
You cannot create a VM instance without a VPC network
When a VM is terminated, you do not pay for memory and CPU resources. However, you are charged for any attached disks and reserved IP addresses.
You could keep your boot disk and just reattach that boot disk later on
A custom machine is generally going to be slightly more expensive than standard.
Every VM instance stores its metadata on a metadata server.
The metadata server is particularly useful in combination with startup and shutdown scripts, because you can use the metadata server to programmatically get unique information about an instance, without additional authorization.
To move your VM, you must shut down the VM, move it to the destination zone or region, and then restart it.
you can grow disks in size, you can never shrink them

## Best practices
It is best practice to run the Cloud Logging agent on all your VM instances.
Preemptible VMs to reduce cost
Managing patches effectively is a great way to keep your infrastructure up-to-date and reduce the risk of security vulnerabilities
If you building and redundancy for availability, remember to allocate excess capacity to meet performance requirements.
I recommend that you first configure the instance through the Google Cloud console and then ask Compute Engine for the equivalent REST request or command line
I recommend a high-memory virtual machine if you need to take advantage of RAM Disk, along with a persistent disk to back up the RAM disk data.
We recommend storing the startup and shutdown scripts in Cloud Storage
You can create regular snapshots on a persistent disk faster and at a much lower cost than if you regularly created a full image of the disk. full image of the disk = image + snapshot.
Regional managed instance groups are generally recommended **over zonal managed instance groups** because they allow you to spread the application load **across multiple zones** instead of confining your application to a single zone

# Related Services
## VPC (Virtual Private CLoud Network)
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

## Load balancing
The job of a load balancer is to distribute user traffic across multiple instances of an application.
You can put Cloud Load Balancing in front of all of your traffic.
No “pre-warming” is required.
For traffic coming into the Google network from the internet: Global HTTP, Global SSL proxy, Global TCP Proxy, Regional External Passthrough Network and Regional External Application load balancer
For traffic inside your project: The Regional Internal load balancer. It accepts traffic on a Google Cloud internal IP address and load balances it across Compute Engine VMs.
Balances traffic Across multiple Compute Engine regions

## CLoud DNS (Domain name service) & Cloud CDN (Content delivery network)
DNS is what translates internet hostnames to addresses
The DNS information your publish is served from redundant locations around the world.
You can publish and manage millions of DNS zones and records 
Google also has a global system of edge caches. Edge caching refers to the use of caching servers to store content closer to end users.
to accelerate content delivery in your application by using Cloud CDN
lower network latency, the origins of your content will experience reduced load

## Cloud TPU
TPUs are Google’s custom-developed application-specific integrated circuits (ASICs) used to accelerate machine learning workloads. 
TPUs act as domain-specific hardware, as opposed to general-purpose hardware with CPUs and GPUs. 
TPUs are generally faster than current GPUs and CPUs for AI applications and machine learning.
TPUs are mostly recommended for models that train for long durations and for large models with large effective batch sizes.