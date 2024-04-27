
# Create a cluster:
gcloud container clusters create --machine-type=e2-medium --zone=ZONE cluster-name
# Retrieve the credentials for the cluster (to use kubectl)
# this command writes configuration information into a config file in the .kube directory in the $HOME directory.
gcloud container clusters get-credentials cluster-name --region $REGION

# With KUBECTL:
# the kubectl command automatically references config file and connects to the default cluster without prompting for credentials

# New deployment using a container image: 
kubectl create deployment server-name --image=gcr.io/google-samples/hello-app:1.0
# Expose the application to external traffic
kubectl expose deployment server-name --type=LoadBalancer --port 8080
# To inspect the server
kubectl get service # this will return the EXTERNAL IP 
# Then, using the EXTERNAL-IP you can view the applicartion
http://[EXTERNAL-IP]:8080

# Delete de cluster
gcloud container clusters delete cluster-name
