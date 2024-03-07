
# CONTAINER

The idea of a container is to give the independent scalability of workloads in PaaS and an abstraction layer of the OS and hardware in IaaS.
A configurable system, lets you install your favorite run time, web server, database or middleware.
A container, is an invisible box around your code and its dependencies with limited access to its own partition of the file system and hardware.
All that's needed on each host is an OS kernel that supports containers and a container runtime.
This lets each developer deploy their own operating system, OS, access the hardware, and build their applications in a self contained environment with access to RAM, file systems, networking interfaces, etc. The OS is being virtualized This makes code ultra portable, and the OS and hardware can be treated as a black box.
Microservices: If you build them this way and connect them with network connections, you can make them modular, deploy easily and scale independently across a group of hosts.

Docker compose an alternative when is necesary to run several containers. This soluction don´t scale with containers above 20 containers. Kubernetes is better. 

# GKE

Google Kubernetes Engine (GKE) provides a managed environment for deploying, managing, and scaling your containerized applications using Google infrastructure. The GKE environment consists of multiple machines (specifically Compute Engine instances) grouped to form a container cluster (or nodes). A node represents a computing instance like a virtual machine. It makes it easy to orchestrate many containers on many hosts
You use Kubernetes commands and resources to deploy and manage your applications, perform administrative tasks, set policies, and monitor the health of your deployed workloads.
A cluster consists of at least one cluster master machine and multiple worker machines called nodes. Nodes are Compute Engine virtual machine (VM) instances that run the Kubernetes processes necessary to make them part of the cluster.
GKE use a network load balancer with public ip address, instead a external load balancer with a public IP address.

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