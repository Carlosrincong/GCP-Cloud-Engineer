
# CONTAINER

The idea of a container is to give the independent scalability of workloads in PasA and an abstraction layer of the OS and hardware in IaaS.
A configurable system, lets you install your favorite run time, web server, database or middleware.
Docker compose an alternative when is necesary to run several containers. This soluction don´t scale with containers above 20 containers. Kubernetes is better. 

# GKE

Google Kubernetes Engine (GKE) provides a managed environment for deploying, managing, and scaling your containerized applications using Google infrastructure. The GKE environment consists of multiple machines (specifically Compute Engine instances) grouped to form a container cluster.
You use Kubernetes commands and resources to deploy and manage your applications, perform administrative tasks, set policies, and monitor the health of your deployed workloads.
A cluster consists of at least one cluster master machine and multiple worker machines called nodes. Nodes are Compute Engine virtual machine (VM) instances that run the Kubernetes processes necessary to make them part of the cluster.

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
pod: is a conatiner set. 
livenessprove: check if a port is avaible. this way we can check if an container has started. 
kube-proxy: receive the traffic and redirect all to pods
readinessprobe: check if it is avaible to get traffic through sending a request and hoping a response. 
pod networking: each pod have its own ip. And each container inside of pod have the same ip. 
cluster ip: fix a static ip to a cluster. And the cluster send traffic to pods with dinamic ip. Labels connect the cluster with pods.


Ways to create pod:
Deployment: is a template to create pods. And replicas is the amount of pods to this deployment. 
daemonset: usually used to monitoring and logging. Create a pods for each node. 
statefulset: create a pod with persistent disk. Useful to Database.