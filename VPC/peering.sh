
# Create the first custom vpc-a and its subnet
gcloud compute networks create vpc-a --project=vpc-peering-1-431401 --subnet-mode=custom --mtu=1460 --bgp-routing-mode=regional
gcloud compute networks subnets create subnet-a --project=vpc-peering-1-431401 --range=10.0.0.0/20 --stack-type=IPV4_ONLY --network=vpc-a --region=us-east1

# Create the second custom vpc-b and its subnet
gcloud compute networks create vpc-b --project=vpc-peering-2-431401 --subnet-mode=custom --mtu=1460 --bgp-routing-mode=regional
gcloud compute networks subnets create subnet-b --project=vpc-peering-2-431401 --range=10.4.0.0/20 --stack-type=IPV4_ONLY --network=vpc-b --region=us-east4

# Create the firewall rule in the both vpcs
gcloud compute --project=vpc-peering-1-431401 firewall-rules create vpc-a-allow-in-internet --direction=INGRESS --priority=1000 --network=vpc-a --action=ALLOW --rules=tcp:22,icmp --source-ranges=0.0.0.0/0
gcloud compute --project=vpc-peering-2-431401 firewall-rules create vpc-b-allow-in-internet --direction=INGRESS --priority=1000 --network=vpc-b --action=ALLOW --rules=tcp:22,icmp --source-ranges=0.0.0.0/0

# Create a VM in each vpc
gcloud compute instances create instance-b --project=vpc-peering-2-431401 --zone=us-east4-b --machine-type=e2-micro \
 --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=subnet-b --maintenance-policy=MIGRATE --provisioning-model=STANDARD \
 --service-account=865450397543-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/trace.append \
 --create-disk=auto-delete=yes,boot=yes,device-name=instance-b,image=projects/debian-cloud/global/images/debian-12-bookworm-v20240709,mode=rw,size=10,type=pd-balanced \
 --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=goog-ec-src=vm_add-gcloud --reservation-affinity=any

gcloud compute instances create instance-a --project=vpc-peering-1-431401 --zone=us-east1-d --machine-type=e2-micro \
 --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=subnet-a --maintenance-policy=MIGRATE --provisioning-model=STANDARD \
 --service-account=788836417717-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/trace.append \
 --create-disk=auto-delete=yes,boot=yes,device-name=instance-a,image=projects/debian-cloud/global/images/debian-12-bookworm-v20240709,mode=rw,size=10,type=pd-balanced \
 --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=goog-ec-src=vm_add-gcloud --reservation-affinity=any

# Set the peering connection in each vpc

# Then copy the internal ip address of the instance in the vpc-a and ssh the instance in the vpc-b to ping the instance-a
