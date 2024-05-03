
# Get the repository 
gsutil -m cp -r gs://spls/gsp053/orchestrate-with-kubernetes .

# Change directory
cd orchestrate-with-kubernetes/kubernetes

# Create a cluster
export CLUSTER=bootcamp
gcloud container clusters create $CLUSTER \
 --machine-type e2-small \
 --num-nodes 3 \
 --scopes "https://www.googleapis.com/auth/projecthosting,storage-rw"

# Get details about which are the deployments
kubectl explain deployment
kubectl explain deployment --recursive # see all avaible fields
kubectl explain deployment.metadata.name # Get details about one specific field

# Edit 'deployments/auth.yaml' file, to change the image used to deploy the cluster
vi deployments/auth.yaml
i
# ---------------------------- changes
...
containers:
- name: auth
  image: "kelseyhightower/auth:1.0.0"
...
# ------------------------------------
# ESC + :wq

# View the file edited
cat deployments/auth.yaml

# Create a deployment with 1 replica (1 pod)
kubectl create -f deployments/auth.yaml

# Verify if the deployment was created
kubectl get deployments

# Verify the number of replicas
kubectl get replicasets

# Verify the number of pods
kubectl get pods

# Create services and deployments. For auth and hello
kubectl create -f services/auth.yaml # kind: Service
kubectl create -f deployments/hello.yaml # kind: Deployment
kubectl create -f services/hello.yaml # kind: Service

# Create service and deployment for frontend and expose it
export SECRET_NAME=tls-certs
kubectl create secret generic $SECRET_NAME --from-file tls/ # using files in tls/ directory
export CONFIG_MAP_NAME=nginx-frontend-conf
kubectl create configmap $CONFIG_MAP_NAME --from-file=nginx/frontend.conf # using nginx/frontend.conf file
# configMap is used for the frontend
kubectl create -f deployments/frontend.yaml # kind: Deployment
kubectl create -f services/frontend.yaml # kind: Service

# Get external IP address of frontend
kubectl get services frontend 

# Test the frontend
export EXTERNAL_IP=1.1.1.1.
curl -ks https://$EXTERNAL_IP

###########
## SCALE ##
###########

export HELLO_DEPLOY=hello
# You can scale by updating the number od replicas which is specified in spec.replicas field of deployment
# view the current number of replicas
kubectl explain deployment.spec.replicas

# Edit the deployment file to increase the number of replicas
kubectl scale deployment $HELLO_DEPLOY --replicas=5

# Verify the number of replicas
kubectl get pods | grep hello- | wc -l

# sclae back
kubectl scale deployment $HELLO_DEPLOY --replicas=3

# Verify the number of replicas
kubectl get pods | grep hello- | wc -l

#####################
## 1. UPDATE IMAGE ##
#####################

#########################
## 1.1. ROLLING UPDATE ##
#########################

# to update applications without downtime.
# Rollout refers to the process of changing version of a deployment. As new replicas with the new version are being deployed, replicas with old version are removed

# Edit deployment
kubectl edit deployment $HELLO_DEPLOY
# ---------------------------- changes
...
containers:
  image: kelseyhightower/hello:2.0.0
...
# -----------------------------------
# Then begin a rolling update

# View the number of replicas
kubectl get replicaset

# view the history changes and versions of deployments
kubectl rollout history deployment/$HELLO_DEPLOY

# Pause a rollout
kubectl rollout pause deployment/$HELLO_DEPLOY

# Verify the status of rollout
kubectl rollout status deployment/$HELLO_DEPLOY
kubectl get pods -o jsonpath --template='{range .items[*]}{.metadata.name}{"\t"}{"\t"}{.spec.containers[0].image}{"\n"}{end}'

# Continue the rollout
kubectl rollout resume deployment/$HELLO_DEPLOY

# Verify if the rollout has finished
kubectl rollout status deployment/$HELLO_DEPLOY

# Rollback a rollout
kubectl rollout undo deployment/$HELLO_DEPLOY

# View the rollout history
kubectl rollout history deployment/$HELLO_DEPLOY
# Verify if has finished
kubectl get pods -o jsonpath --template='{range .items[*]}{.metadata.name}{"\t"}{"\t"}{.spec.containers[0].image}{"\n"}{end}'

#############################
## 1.2. CANARY DEPLOYMENTS ##
#############################

# to test a new deployment in production with a subset of your users

# Create a deployment
kubectl create -f deployments/hello-canary.yaml # Kind: deployment

# Verify deployments
kubectl get deployments

# verify that some of request are served by hello-canary
curl -ks https://`kubectl get svc frontend -o=jsonpath="{.status.loadBalancer.ingress[0].ip}"`/version

# sessionAffinity to set specific IP users

#################################
## 1.3. BLUE-GREEN DEPLOYMENTS ##
#################################

# The deployments will be accessed via a service which will act as the router. 
# Once the new "green" version is up and running, you'll switch over to using that version by updating the service.

# Update the hello service to blue
kubectl apply -f services/hello-blue.yaml

# Create a green deployment (new)
kubectl create -f deployments/hello-green.yaml

# Verify that is running the new version on green deployment
curl -ks https://`kubectl get svc frontend -o=jsonpath="{.status.loadBalancer.ingress[0].ip}"`/version

# Update de hello service to green
kubectl apply -f services/hello-green.yaml

# Verify
curl -ks https://`kubectl get svc frontend -o=jsonpath="{.status.loadBalancer.ingress[0].ip}"`/version

# The rollback goes in the same direction

# Update the hello service to blue
kubectl apply -f services/hello-blue.yaml

# Verify
curl -ks https://`kubectl get svc frontend -o=jsonpath="{.status.loadBalancer.ingress[0].ip}"`/version