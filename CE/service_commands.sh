

gcloud config set compute/region REGION # Donde REGION es la region para compute service
gcloud config set compute/zone ZONE # Donde ZONE es la zona para compute 

gcloud compute instances list # List of all instances in the project 
gcloud compute instances list --filter="name=('gcelab2')"

gcloud compute firewall-rules list # List of firewall rules
gcloud compute firewall-rules list --filter="network='default'"
gcloud compute firewall-rules list --filter="NETWORK:'default' AND ALLOW:'icmp'"
gcloud compute firewall-rules list --filter=ALLOW:'80'

gcloud compute instances create name-instance --machine-type e2-medium --zone=$ZONE # Create a VM instance
gcloud compute ssh gcelab2 --zone=$ZONE ## Use SSH to connect with VM

gcloud compute instances get-serial-port-output instance-name # To know if instance is ready to RDP Connection
gcloud compute reset-windows-password instance-name --zone ZONE --user USERNAME # To set a pasword an username to windows instance

gcloud compute instances add-tags gcelab2 --tags http-server,https-server # Tag a VM

# test of connectivity
ping -c 3 IP # Where IP is the internal IP

# Update firewall rules
gcloud compute firewall-rules create default-allow-http \
    --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:80 \
    --source-ranges=0.0.0.0/0 --target-tags=http-server

# Verify connection with filtered VM
curl http://$(gcloud compute instances list --filter=name:gcelab2 --format='value(EXTERNAL_IP)')