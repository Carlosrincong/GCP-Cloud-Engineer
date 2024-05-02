# Cloud shell

export PROJECT_ID=project-id

###############
## CONTAINER ##
###############

# write a simple Node.js server
vi server.js
i
# --------------------------------------- Node.js
var http = require('http');
var handleRequest = function(request, response) {
  response.writeHead(200);
  response.end("Hello World!");
}
var www = http.createServer(handleRequest);
www.listen(8080);
# -----------------------------------------------
# ESC and [:wq] to save the file

# start de node server
node server.js

# Create a Dockerfile
vi Dockerfile
i
# ----------------------
FROM node:6.9.2
EXPOSE 8080
COPY server.js .
CMD node server.js
# ----------------------
# ESC and [:wq] to save the file

# build an image based on files of directory 
docker build -t gcr.io/$PROJECT_ID/hello-node:v1 .

# run de image
docker run -d -p 8080:8080 gcr.io/PROJECT_ID/hello-node:v1

# To test de container
curl http://localhost:8080

# get list of Docker container ID
docker ps

# Stop container by using container id
export CONTAINER_ID=container-id
docker stop $CONTAINER_ID

#######################
## ARTIFACT REGISTRY ##
#######################

# configure docker auth (Now you can use docker commands)
gcloud auth configure-docker

# push image in ArtifactRegistry
# gcr.io generic domain for the registry
docker push gcr.io/$PROJECT_ID/hello-node:v1

################
## KUBERNETES ##
################

gcloud config set project $PROJECT_ID

# Create cluster
export ZONE=zone
export CLUSTER=hello-world
gcloud container clusters create $CLUSTER \
 --num-nodes 2 --machine-type e2-medium --zone $ZONE

# Now you can use kubectl

# Create a pod by creating deployment object. 
# Deployments are the recommended way to create and scale pods
export DEPLOYMENT=hello-node
kubectl create deployment $DEPLOYMENT \
 --image=gcr.io/$PROJECT_ID/hello-node:v1

# view deployments
kubectl get deployments

# View pods
kubectl get pods

# Relevant commands
kubectl cluster-info
kubectl config view

# troubleshooting commands
export POD_NAME=pod-name
kubectl get events
kubectl logs $POD_NAME

# allow external traffic
kubectl expose deployment $DEPLOYMENT --type="LoadBalancer" --port=8080

# list all cluster services and get the external ip address
kubectl get services

##############
## SCALE UP ##
##############

# Scale up  the number of replicas of pod
kubectl scale deployment $DEPLOYMENT --replicas=4

# View deployments
kubectl get deployment
# View pods
kubectl get pods

##################
## UPDATE IMAGE ##
##################

vi server.js
i
# ------------------------------ Node.js
response.end("Hello Kubernetes World!");
# --------------------------------------
# ESC + :wq

# Build image on version 2
docker build -t gcr.io/PROJECT_ID/hello-node:v2 .
# Push the image to ArtifactRegistry
docker push gcr.io/PROJECT_ID/hello-node:v2

# Edit the deployment to edit the version
kubectl edit deployment $DEPLOYMENT
# Editing spec.template.spec.containers.image line
# ESC + :wq

# view deployments
kubectl get deployments