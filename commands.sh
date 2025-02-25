gcloud init

gcloud projects (create, delete, describe, list)
gcloud projects add-iam-policy-binding $PROJECT_NAME (member + role + condition)
gcloud projects set-iam-policy $PROJECT_NAME
gcloud projects get-iam-policy $PROJECT_NAME

gcloud services enable pubsub.googleapis.com (or disable)
gcloud services list --enabled

gcloud compute instances (create, delete, describe, list, attach-disk)
gcloud compute instances (start, stop, suspend, update, resume, reset) $MACHINE_NAME

gcloud compute ssh --project=PROJECT_ID --zone=ZONE $MACHINE_NAME
gcloud compute snapshots (create, delete, describe, list) $SNAPSHOT_NAME 
gcloud compute disks (create, delete, describe, list, resize) $DISK_NAME
gcloud compute images (create, delete, describe, export, import, list) $IMAGE_NAME
gcloud compute instance-templates (create, delete, list) $TEMPLATE_NAME
gcloud compute instance-groups managed (create, delete) $MIG_NAME

gcloud compute networks (create, list)
gcloud compute networks subnets (create, list)
gcloud compute networks peerings create
gcloud compute firewall-rules
gcloud compute addresses list

gcloud container clusters create 

gcloud sql instances create

gcloud functions deploy

gcloud app deploy

gcloud iam service-accounts (create, ...) $SERVICE_ACC
gcloud iam service-accounts add-iam-policy-binding $SERVICE_ACC $USER
gcloud iam roles (describe, list, create, edit, delete)

gcloud logging 
gcloud monitoring

gcloud docker


