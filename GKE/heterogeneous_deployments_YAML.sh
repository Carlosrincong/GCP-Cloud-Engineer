
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