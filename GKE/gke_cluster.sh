export REGION=Region
export CLUSTER=autopilot-cluster

# Create kubernetes autopilot cluster
gcloud container clusters create-auto $CLUSTER --region $REGION

# Get the config file:
gcloud container clusters get-credentials $CLUSTER --region $REGION # create a .kube/config file 

# open kubeconfig
nano ~/.kube/config

############# 
## kubectl ##
#############

# View config file
kubectl config view

# Describes the active context cluster:
kubectl cluster-info

# Print the active context
kubectl config current-context

# Print all contexts
kubectl config get-contexts

# Change the context
export PROJECT_ID=project-id
kubectl config use-context gke_${PROJECT_ID}_Region_autopilot-cluster-1

# Deploy PODS:
export POD_NAME=pod-name

# deploy a nginx pod
kubectl create deployment --image nginx $POD_NAME

# list of pods
kubectl get pods

# View complete details about a pod
kubectl describe pod $POD_NAME

# Copy a [test.html] file into the nginx pod
kubectl cp ~/test.html $POD_NAME:/usr/share/nginx/html/test.html

# expose pod to external traffic
kubectl expose pod $POD_NAME --port 80 --type LoadBalancer

# view details about services in the cluster and view the external IP
kubectl get services
export EXTERNAL_IP=1.1.1.1

# test the access to the pod
curl http://[$EXTERNAL_IP]/test.html

# view the resources that are being used by the nginx Pod
kubectl top pods

################
## Introspect ##
################

# clone repository to cloud shell
git clone https://github.com/GoogleCloudPlatform/training-data-analyst

# Create a soft link as a shortcut to the working directory
ln -s ~/training-data-analyst/courses/ak8s/v1.1 ~/ak8s

# change to the directory
cd ~/ak8s/GKE_Shell/ # in this directory is the YAML file (manifest) called new-nginx-pod.yaml

# To deploy your manifest. To create new-nginx pod
kubectl apply -f ./new-nginx-pod.yaml

# list of pods, with their status
kubectl get pods

# to start an interactive bash shell in the nginx container
export NEW_POD=new-nginx
kubectl exec -it $NEW_POD -- /bin/bash

#--------------------- interactive bash shell in the container
apt-get update
apt-get install nano # install nano text editor
cd /usr/share/nginx/html # cd
nano test.html # create file
exit
# ---------------------

# to set up port forwarding from Cloud Shell to the nginx Pod (from port 10081 of the Cloud Shell VM to port 80 of the nginx container)
kubectl port-forward new-nginx 10081:80

# then test the modificated pod
curl http://127.0.0.1:10081/test.html

# view the logs
kubectl logs $NEW_POD -f --timestamps