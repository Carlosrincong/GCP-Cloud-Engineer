
# Create the cluster
gcloud beta container --project "admin-project-a" clusters create "gke-cluster" --zone "us-east1-b" --no-enable-basic-auth --cluster-version "1.29.6-gke.1326000" \
 --release-channel "regular" --machine-type "e2-micro" --image-type "COS_CONTAINERD" --disk-type "pd-standard" --disk-size "10" --metadata disable-legacy-endpoints=true \
 --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" \
 --num-nodes "3" --logging=SYSTEM,WORKLOAD --monitoring=SYSTEM,STORAGE,POD,DEPLOYMENT,STATEFULSET,DAEMONSET,HPA,CADVISOR,KUBELET --enable-ip-alias --network "projects/admin-project-a/global/networks/default" \
 --subnetwork "projects/admin-project-a/regions/us-east1/subnetworks/default" --no-enable-intra-node-visibility --default-max-pods-per-node "110" --enable-autoscaling --min-nodes "1" --max-nodes "3" \
 --location-policy "BALANCED" --security-posture=standard --workload-vulnerability-scanning=disabled --no-enable-master-authorized-networks --addons HorizontalPodAutoscaling,HttpLoadBalancing,GcePersistentDiskCsiDriver \
 --enable-autoupgrade --enable-autorepair --max-surge-upgrade 1 --max-unavailable-upgrade 0 --binauthz-evaluation-mode=DISABLED --enable-managed-prometheus --enable-shielded-nodes --node-locations "us-east1-b"

# get credentials and configurate kubectl
gcloud container clusters get-credentials gke-cluster --zone "us-east1-b"

# kubectl command line tool test: 

kubectl get pods
kubectl get nodes

# In cloud shell, clone the github repository on home directory
git clone https://github.com/antonitz/google-cloud-associate-cloud-engineer.git

# Change the directory
cd google-cloud-associate-cloud-engineer
cd 09-Kubernetes-Engine-and-Containers/box_of_bowties/container
ls

# Enable Cloud Build API
gcloud services enable cloudbuild.googleapis.com

# Build the image and post in artifact registry
gcloud builds submit --tag gcr.io/$(GOOGLE_CLOUD_PROJECT)/boxofbowties:1.0.0 .

# In GKE Console, create a deployment using the image

# Check out the deployment
kubectl get all
kubectl get deployments
kubectl get pods
kubectl describe pod $PODNAME

# Expose the deployment in the console to activate a service (load balancer)

