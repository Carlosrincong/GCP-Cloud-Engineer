# Enable data access logs on the service
# IAM & Admin > Audit Logs
# Select the resource (Cloud storage in this case)
# Select the log types: Admin Read, Data Read and Data Write

# Create a bucket
export BUCKET_NAME=bucket-name
echo BUCKET_NAME
gsutil mb gs://$BUCKET_NAME
gsutil ls # Check

# Create a file
echo "Hello World!" > sample.txt
gsutil cp sample.txt gs://$BUCKET_NAME
gsutil ls gs://$BUCKET_NAME # Check

# Create a network with an automode subnet
export NETWORK_NAME=mynetwork
echo NETWORK_NAME
gcloud compute networks create $NETWORK_NAME --subnet-mode=auto

# Create a virtrual machine
export VM=default-us-vm
echo VM
gcloud compute instances create $VM \
 --zone=Zone --network=$NETWORK_NAME \
 --machine-type=e2-medium

# Delete the bucket
gsutil rm -r gs://$BUCKET_NAME

# Check the logs in the logging console
# Logging > Logs Explorer
# Show query > Log name > CLOUD AUDIT > Run query

# Check the logs with the Cloud SDK 
gcloud logging read \
 "logName=projects/$BUCKET_NAME/logs/cloudaudit.googleapis.com%2Fdata_access"


