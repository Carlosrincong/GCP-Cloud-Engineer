
# To test connectivity between VM´s
export INTERNAL_IP = 10.10.10.3
echo INTERNAL_IP
ping -c 3 $INTERNAL_IP

# Create network with custom subnets
export NETWORK_NAME = 'privatenet'
echo NETWORK_NAME
gcloud compute networks create $NETWORK_NAME --subnet-mode=custom

# Create custom subnet
export SUBNET_US_NAME = 'privatesubnet-us'
echo SUBNET_US_NAME
gcloud compute networks subnets create $SUBNET_US_NAME --network=$NETWORK_NAME --region=Region 1 --range=172.16.0.0/24

export SUBNET_EU_NAME = 'privatesubnet-eu'
echo SUBNET_EU_NAME
gcloud compute networks subnets create $SUBNET_EU_NAME --network=$NETWORK_NAME --region=Region 2 --range=172.20.0.0/20

# Get list of networks
gcloud compute networks list

# Get list of subnets
gcloud compute networks subnets list --sort-by=NETWORK

# Create firewall rules}
export FIREWALL_RULE_NAME = 'privatenet-allow-icmp-ssh-rdp'
echo FIREWALL_RULE_NAME
gcloud compute firewall-rules create $FIREWALL_RULE_NAME --direction=INGRESS --priority=1000 \
    --network=$NETWORK_NAME --action=ALLOW --rules=icmp,tcp:22,tcp:3389 --source-ranges=0.0.0.0/0

# Get list of firewall rules
gcloud compute firewall-rules list --sort-by=NETWORK

# Create compute engine instance
export CE_NAME = 'privatenet-us-vm'
echo CE_NAME
gcloud compute instances create $CE_NAME --zone=Zone 1 --machine-type=e2-micro --subnet=$SUBNET_US_NAME \
    --image-family=debian-11 --image-project=debian-cloud --boot-disk-size=10GB --boot-disk-type=pd-standard \
    --boot-disk-device-name=$CE_NAME

# Get list of compute engine instances
gcloud compute instances list --sort-by=ZONE