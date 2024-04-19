
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
CLuster have a control plane and a set of nodes (instances) that run containers.
A software layer that sits between your applications and your hardware infrastructure

- Kubernetes supports **declarative configurations**. Which means that you describe the **desired state** you want to achieve, instead of issuing a series of commands to achieve that desired state. Kubernetes’s job is to make the deployed system conform to your desired state and to keep it there in spite of failures. It reduces the risk of error.
- Kubernetes also allows **imperative configuration**, in which you issue commands to **change the system’s state**. Experienced Kubernetes administrators use imperative configuration **only for quick temporary fixes** and as a tool when building a declarative configuration.

- Features:
    1. Suports Stateless applications: such as Nginx or Apache web servers
    2. Suports Stateful applications: where user and session data can be stored persistently. Also supports Batch jobs and daemon tasks
    3. Autoscale contanerized applications
 
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


-----------------------

etcd: is the database to save operativo information from kubernetes
cloud controller manager: Allows to kubernetes comunicate with Cloud provider to deploy services. 
kubelet: is the way how a worker get workloads from master.
namespace: to distribute the traffic or the workload
livenessprove: check if a port is avaible. this way we can check if an container has started. 
kube-proxy: receive the traffic and redirect all to pods
readinessprobe: check if it is avaible to get traffic through sending a request and hoping a response. 
pod networking: each pod have its own ip. And each container inside of pod have the same ip. 

Load balancers:
- cluster ip: fix a static ip to a cluster. And the cluster send traffic to pods with dinamic ip. Labels connect the cluster with pods.
- node port: expone the port of an external ip of and node. And node send the traffic to pods. You have to know the ip of each node
- load balancer
- ingress: is like a map of address to distributate workloads

Ways to create pod:
- Deployment: is a template to create pods. And replicas is the amount of pods to this deployment. 
- daemonset: usually used to monitoring and logging. Create a pods for each node. 
- statefulset: create a pod with persistent disk. Useful to Database.

# POD 
Pod is a conatiner or a set of. It represents a running process on your cluster as either a component of your application or an entire app. 
Generally, you only have one container per pod. When you have more than one, it is because them have a high dependence on each other. 
The pod provides a unique network IP and set of ports for your containers. Kubernetes creates a service with a fixed IP address for your pods.
kubectl command to run a container in a pod, which starts a deployment with a container running inside a pod
kubectl get pods to see of the running pods

## Deployment 
A deployment represents a group of replicas of the same pod and keeps your pods running even when the nodes they run on fail
kubectl get deployments
kubectl describe deployments.
## Service
A service is an abstraction which defines a logical set of pods and a policy by which to access them
A service group is a set of pods and provides a stable endpoint or fixed IP address for them.
kubectl get services to get the external IP of the service 

# Disadventage
Google Kubernetes Engine, which consists of containerized workloads, may not be as easily transferable as what you’re used to from on-premises.

# Best practice
it’s not a best practice to build your application in the same container where you ship and run it.