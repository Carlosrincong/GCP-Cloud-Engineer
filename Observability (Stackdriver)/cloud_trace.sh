# https://www.cloudskillsboost.google/paths/11/course_templates/864/labs/467987

# In Cloud shelll, Clone the repository to deploy a GKE Cluster
git clone https://github.com/GoogleCloudPlatform/python-docs-samples.git

# Enable the GKE API
gcloud services enable container.googleapis.com

# Create a GKE cluster 
export ZONE=zone
echo ZONE
export GKE_cluster=cloud-trace-demo
echo GKE_cluster
gcloud container clusters create $GKE_cluster --zone $ZONE

# Get credentials for the cluster, to use kubectl command line
gcloud container clusters get-credentials $GKE_cluster --zone $ZONE

# Check the running nodes
kubectl get nodes

# Go to the directory where are the configuration files for the app. Then run the setup.sh file
cd python-docs-samples/trace/cloud-trace-demo-app-opentelemetry && ./setup.sh

# Call the application
curl $(kubectl get svc -o=jsonpath='{.items[?(@.metadata.name=="cloud-trace-demo-a")].status.loadBalancer.ingress[0].ip}')

# Now go to the Cloud Trace console to check the traces