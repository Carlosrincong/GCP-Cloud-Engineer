
# CONTAINER

For On-Premise applications you would need: physical space, power, cooling, network connectivity. You aldo need a Operating system, software dependencies and the application. In case, more processing power is needed, you have to add more computers. 
Virtualization: The software layer that breaks the dependencies of an operating system on the underlying hardware and allows several virtual machines to share that hardware is called a  **hypervisor** (such as Kernel-based Virtual Machine or KVM).
With Virtualization, a virtual machines can be imaged and easily moved.
The idea of a container is to give the independent scalability of workloads in PaaS and an abstraction layer of the OS and hardware in IaaS. Independent means that you have an user space, which is all the code that resides above the kernel, and it includes applications and their dependencies.
A configurable system, lets you install your favorite run time, web server, database or middleware. Containersdon’t carry a full operating system
A container, is an invisible box around your code and its dependencies with limited access to its own partition of the file system and hardware.
Containers are a way to package and run code that's more efficient than virtual machines
An application and its dependencies are called an **image**, and a **container** is simply a running instance of an image.
A container **image is structured in layers**, and the tool used to build the image reads instructions from a file called the container **manifest**. Each instruction specifies a layer inside the container image.
All that's needed on each host is an **OS kernel** that supports containers and a **container runtime**.
Container runtime is the software used to **launch a container from a container image**-
**Containerd**, the runtime component of Docker.
**Docker**: you need software and container runtime, to build and run container images. For Docker-formatted container images, container manifest is called a **Dockerfile**.
A Dockerfile contains four commands, each of which creates a layer: 
    - FROM: create a base layer. It’s common to use publicly available open-source container images as the base for your own images. Artifact Registry contains public, open source images and you can privately store your own images. Thera are also, other public repositories such as Docker Hub Registry and GitLab.
    - COPY: copy files
    - RUN: build the aplication using commands
    - CMD: specifies what command to run within the container
The **container deploying procces** consists of one container builds the final executable image, and a separate container receives only what is needed to run the application.

**Linux tecnology allows containers tecnology** due to: Linux process, Linux namespaces, Linux cgroups and union file systems.

This lets each developer deploy their own operating system, OS, access the hardware, and build their applications in a self contained environment with access to RAM, file systems, networking interfaces, etc. The OS is being virtualized This makes code ultra portable, and the OS and hardware can be treated as a black box.
Microservices: If you build them this way and connect them with network connections, you can make them modular, deploy easily and scale independently across a group of hosts. This modular design pattern allows the operating system to scale and upgrade components of an application without affecting the application as a whole.

# DOCKER COMPOSE
Docker compose is an alternative when It´s necesary to run several containers. This soluction don´t scale with containers above 20 containers. Kubernetes is better. 

# KUBERNETES 
Kubernetes is an orchestration framework for software containers. 
Kubernetes provides the tools you need to run and manage containerized applications in production and at scale as microservices.
Kubernetes is a set of APIs that you can use to deploy containers on a set of nodes called a cluster.
Cluster have a control plane and a set of nodes (instances) that run containers.
Kubernetes is a software layer that sits between your applications and your hardware infrastructure
Kubernetes objects are identified by a unique name and a unique identifier.

## Declarative management and objects
- Kubernetes supports **declarative configurations**. Which means that you describe the **desired state** you want to achieve, instead of issuing a series of commands to achieve that desired state. Kubernetes’s job is to make the deployed system conform to your desired state and to keep it there in spite of failures. It reduces the risk of error.
- Kubernetes also allows **imperative configuration**, in which you issue commands to **change the system’s state**. Experienced Kubernetes administrators use imperative configuration **only for quick temporary fixes** and as a tool when building a declarative configuration.

- Features:
    1. Suports Stateless applications: such as Nginx or Apache web servers
    2. Suports Stateful applications: where user and session data can be stored persistently. Also supports Batch jobs and daemon tasks
    3. Autoscale contanerized applications

Each item Kubernetes manages is represented by an **object**. Kubernetes needs to be told (with **declarative management**) how objects should be managed, and it will work through **watch loop** to achieve and maintain that desired state.
A **Kubernetes object or kind** is defined as a persistent entity that represents the state of something running in a cluster: its desired state (**object spec**) and its current state (**object state**) provided by the Kubernetes control plane.
**“Kubernetes control plane”** refers to the various system processes that collaborate to make a Kubernetes cluster work.
Kubernetes will compare the desired state to the current state. And eventually its control plane, will remedy the state as needed.

## PODS
**Pods** are the smallest deployable Kubernetes object and every running container is in a Pod. A Pod creates the **environment** (shared networking and storage) where the containers live, and that can accommodate **one or more** containers. 
Kubernetes assigns each **Pod a unique IP address**, and every container within a Pod shares the network namespace, including IP address and network ports.
Containers **within the same Pod** can communicate through localhost, **127.0.0.1**.

## Components
A **cluster** is composed of virtual machines.
One VM is called the **control plane**, and the others are called **nodes**.
The node’s job is to **run Pods**, and the control plane’s is to **coordinate** the entire cluster.

![kubernetes-components](/img/kubernetes-components.png)

### Control plane
1.  kube-APIserver component: which is the only single component that **you'll interact with directly**. The job of this component is to **accept commands or requests** (authorized and valid) that view or change the state of the cluster. This includes **launching Pods**.
2.  kubectl command: his job is **connect to the kube-APIserver** and communicate with it using the Kubernetes API.
3.  etcd component: which is the cluster’s **database** to store the state of the cluster such as cluster configuration data, what nodes are part of the cluster, what Pods should be running, and where they should be running. You will not interact with it directly.
4.  kube-scheduler: which is responsible for scheduling Pods onto the nodes. It doesn’t do the work of actually launching Pods on nodes. It **assing unassigned pods to nodes** based on contraints (define by you), affinity parameters, anti-affinity parameters and the state of all nodes. 
5. kube-controller-manager component: This monitors the state of a cluster through the kube-APIserver. Whenever the current state of the cluster doesn’t match the desired state, kube-controller-manager will attempt to **make changes to achieve the desired state**. **Controllers** handle the process of remediation. Also, manage workloads and have system-level responsibilities.
6.  kube-cloud-manager component: This manages controllers that interact with underlying cloud providers.

### Nodes
1.  kubelet: This is a small family of **control-plane** components and Kubernetes’s **agent** on each node. **The kube-APIserver connects to the node’s kubelet** when it wants start a Pod on that node. Kubelet starts Pods and monitors its lifecycle, and **reports back** to the kube-APIserver.
2.  kube-proxy component: which maintains network connectivity among the Pods in a cluster.

# Manifest file
You define the **objects** you want Kubernetes to **create and maintain** with manifest files. That files can be written in YAML or JSON. This manifest file defines a **desired state** for a Pod: its **name** and a specific container **image** for it to run.
Required fields:
    1.  apiVersion: refers to Kubernetes API version used
    2.  kind: the object
    3.  metadata: you can specify:
        *   name: object name
        *   uid: uinque id
        *   namespace
        *   labels: key value pairs (key: value). A way to select Kubernetes resources by label is through the **kubectl command**.
If several objects are related, it’s a best practice to define them all in the same YAML file.
Objects must to have an unique name up in the same **Kubernetes namespace**.

## kind: the object

#### POD 
Pod is a conatiner or a set of. It represents a running process on your cluster as either a component of your application or an entire app. 
Generally, you only have one container per pod. When you have more than one, it is because them have a high dependence on each other. 
The pod provides a unique network IP and set of ports for your containers. Kubernetes creates a service with a fixed IP address for your pods.
kubectl command to run a container in a pod, which starts a deployment with a container running inside a pod
kubectl get pods to see of the running pods

#### Controller objects
A controller object's job is to **manage the state of the Pods**. Because Pods are designed to be ephemeral and disposable, they **don't heal or repair themselves** and are not meant to run forever. Deployment controller job is to **monitor and maintain up** the desired pods.
    1.  Deployments: Deployments are a great choice for long-lived software components like web servers, especially when you want to manage them as a group. Instead of using multiple YAML manifests or files for each Pod, you used a single Deployment YAML to launch three replicas of the same container. Within a Deployment object spec, the number of **replica Pods**, which containers should run the Pods, and which volumes should be mounted the following elements are defined. Based on these templates, controllers maintain the Pod’s desired state within a cluster.
    -    kubectl get deployments
    -    kubectl describe deployments

    2.  StatefulSets: apps which requires persistent storage. Useful to Database.
    3.  DaemonSets: ensures that every node in the cluster runs a copy of a pod. usually used to monitoring and logging. Create a pods for each node. 
    4.  Jobs: run finite task until completion
    5.  CronJobs: schedule jobs
    6.  ConfigMaps

#### Services, Load Balancing, and Networking objects

Service:
A service is an abstraction which defines a logical set of pods and a policy by which to access them
A service group is a set of pods and provides a stable endpoint or fixed IP address for them. 
Provides a single persistent IP address for ephemeral pods
service send traffic to pods with the established label in the both selector and pod definition
kubectl get services to get the external IP of the service 
- Multi-port services: expose more than one port. Useful to distribute traffic based on ports and names of the ports
- Headless services: None type in the manifest. When is not necessary any load balancer. Often used with stateful sets

Service Type:
- ClusterIp: fix a static ip to a cluster. And the cluster send traffic to pods with dinamic ip. Labels connect the cluster with pods.
- NodePort: expose the port of and the external ip of a node. And node send the traffic to pods. You have to know the ip of each node and its exposed port
- loadBalancer: create an internal load balancer service which is conected to the cloud load balancer
- ExternalName: provides an internal alias for an external dns name. Useful for outside resources

Ingress
Ingress is like a map of address to distributate workloads

  
## kubectl command
kubectl is a command-line tool used by administrators to **control and interact with Kubernetes clusters**. It’s used to **communicate** with the Kube-APIserver on the **control plane**.
kubectl transforms command-line entries into **API calls** and sends them via HTTP to the Kube-APIserver on Control plane. The Kube-APIserver then returns the results to kubectl through HTTPS. Finally, kubectl display us the response.
kubectl must be configured with the location and credentials of a Kubernetes cluster.
Although kubectl is a tool for administering the internal state of an **existing cluster**, it **can’t create new clusters** or **change the shape of existing** clusters. **Control plane** can do it and you can comunicate with this through kubeclt.
By configurating the **config file (with credentials)**, you automatically can use kubectl command line.
The kubectl command has many **uses**, from creating Kubernetes objects, to viewing them, deleting them, and viewing or exporting configuration files. 

kubectl’s syntax is composed of four parts: the command, the type, the name, and optional flags.
![kubectl-syntaxis-1](/img/kubectl-syntaxis-1.png)
![kubectl-syntaxis-2](/img/kubectl-syntaxis-2.png)

## Introspection
Debug problems when an application is running.
t’s the act of gathering information about the objects running in cluster.
kubectl commands: 
    1.  get: [kubectl get pods] shows the Pod’s phase status:
        +   Pending: Kubernetes has accepted a Pod, but it’s still being scheduled (not created).
        +   Running: When a pod was attached to a node, and all its containers are created.
        +   Succeeded: When all containers had either finished running or terminated succesfully.
        +   Failed: when a container terminated with a failure. 
        +   Unknown: When state can´t be retrivied. (comunication error between kubectl and control plane)
        +   CrashLoopBackOff: Pod isn’t configured correctly, this is a common error. 
    2.  describe: [kubectl describe pod_name] To investigate a Pod and its containers in detail
        +   For pods: the name, namespace, node name, labels, status, and IP address are displayed.
        +   For containers: the state (waiting, running, or terminated), images, ports, commands, and restart counts–are displayed.
    3.  exec: lets you run a single command inside a container and view the results in your own command shell
    4.  logs: when you need to find out more information about containers that are failing to run successfully.

## Best practices
1.  Don´t install software directly into a container. Instead, consider building container images that have exactly the software you need
2.  When you resolve a failure, those changes must to go into your container images and redeploy them.

# GKE

Google Kubernetes Engine (GKE) provides a managed environment for deploying, managing, and scaling your containerized applications using Google infrastructure. The GKE environment consists of multiple machines (specifically Compute Engine instances or nodes) grouped to form a container cluster. The virtual machines (or compute instance) that host containers in a GKE cluster are called nodes. It makes it easy to orchestrate many containers on many hosts
You use Kubernetes commands and resources to deploy and manage your applications, perform administrative tasks, set policies, and monitor the health of your deployed workloads (unhealthy nodes are drained and recreated).
A cluster consists of at least one cluster master machine and multiple worker machines called nodes. Nodes are Compute Engine virtual machine (VM) instances that run the Kubernetes processes necessary to make them part of the cluster.
GKE use a network load balancer with public ip address, instead a external load balancer with a public IP address.

GKE Autopilot is designed to manage your cluster configuration, like nodes, scaling, security, and other preconfigured settings.
The GKE auto-upgrade feature ensures that clusters are always upgraded with the latest stable version of Kubernetes.
GKE has a node auto-repair feature that was designed to repair unhealthy nodes.
Related services: Cloud build, Artifact Registry, Cloud monitoring, IAM and VPC (load balancers and ingress access)

- Load balancing for Compute Engine instances
- Node pools to designate subsets of nodes within a cluster for additional flexibility
- Automatic scaling of your cluster's node instance count
- Automatic upgrades for your cluster's node software
- Node auto-repair to maintain node health and availability
- Logging and Monitoring with Cloud Monitoring for visibility into your cluster

## Components
![GKE-components](/img/GKE-components.png)
GKE manages all the control plane components for us.
It still exposes an IP address to which we send all of our Kubernetes API requests
Node configuration and management depends on the type of GKE mode you use.

1.  The Autopilot mode (recommended), GKE manages the underlying infrastructure such as node configuration, autoscaling, auto-upgrades, baseline security configurations, and baseline networking configuration. 
    *   Less management overhead means less configuration options. GKE Autopilot are more restrictive than in GKE Standard.
    *   You only pay for what you use. You only pay for Pods, not nodes.
    *   Create clusters according to battle-tested and hardened best practices. 
    *   Defines the underlying machine type for your cluster based on workloads. 
    *   Google monitors the entire Autopilot cluster, including control plane, worker nodes and core Kubernetes system components. 
    *   It ensures that Pods are always scheduled and keep cluster up to date. Autopilot has a pod-scheduling service level agreement.
    *   Provides a way to configure update windows for clusters to ensure minimal disruption to workloads.
    *   SSH and privilege escalation were removed on node and there are limitations on node affinity and host access.

2.  The Standard mode, you manage the underlying infrastructure, including configuring the individual nodes. Infrastructure can be configured in many different ways (fine-grained control). You pay for all of the provisioned infrastructure. You’re responsible for the configuration, management, and optimization of the cluster.

## AUTH
For GKE, authentication is typically handled with OAuth2 tokens and can be managed through Cloud Identity and Access Management across the project as a whole and, optionally, through role-based access control which can be defined and configured within each cluster. In GKE, cluster containers can use service accounts to authenticate to and access external resources.

-----------------------

etcd: is the database to save operativo information from kubernetes
cloud controller manager: Allows to kubernetes comunicate with Cloud provider to deploy services. 
kubelet: is the way how a worker get workloads from master.
namespace: to distribute the traffic or the workload
livenessprove: check if a port is avaible. this way we can check if an container has started. 
kube-proxy: receive the traffic and redirect all to pods
readinessprobe: check if it is avaible to get traffic through sending a request and hoping a response. 
pod networking: each pod have its own ip. And each container inside of pod have the same ip. 

# Disadventage
Google Kubernetes Engine, which consists of containerized workloads, may not be as easily transferable as what you’re used to from on-premises.

# Best practice
it’s not a best practice to build your application in the same container where you ship and run it.