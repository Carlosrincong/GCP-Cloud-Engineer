
###################################
## PRIVATE GOOGLE ACCESS AND IAP ##
###################################

# Set project
gcloud config set project $PROJECT_ID

# Once a private vm is created you can ssh it via IAP:
export PRIVATE_VM=vm-internal
echo $PRIVATE_VM
gcloud compute ssh $PRIVATE_VM --zone ZONE --tunnel-through-iap

# Create a bucket in cloud storage and copy file. This is done to test Private Google Access. 
export MY_BUCKET=my-bucket-name
echo $MY_BUCKET

gcloud storage cp gs://cloud-training/gcpnet/private/access.svg gs://$MY_BUCKET

# In cloud shell
gcloud storage cp gs://$MY_BUCKET/*.svg . # This should work because Cloud Shell has an external IP address

# Connect to private vm via IAP:
gcloud compute ssh $PRIVATE_VM --zone ZONE --tunnel-through-iap
gcloud storage cp gs://$MY_BUCKET/*.svg . # This should not work because vm has not both external IP address and private google access

###############
## CLOUD NAT ##
###############

# In cloud shell (has an external IP address)
sudo apt-get update

# In private vm (withou external IP address)
gcloud compute ssh $PRIVATE_VM --zone ZONE --tunnel-through-iap
sudo apt-get update # This should only work for Google Cloud packages because $PRIVATE_VM only has access to Google APIs and services with Private google access

# Activating Cloud NAT 
gcloud compute ssh $PRIVATE_VM --zone ZONE --tunnel-through-iap
sudo apt-get update # This works using NAT gateway


