################
## CLOUD SIDE ##
################

# Create a VPC network
export VPC=vpc-demo
gcloud compute networks create $VPC --subnet-mode custom

# Create two subnets
export REGION1=region1
export VPC_subnet1=vpc-demo-subnet1
gcloud compute networks subnets create $VPC_subnet1 \
 --network $VPC --range 10.1.1.0/24 --region $REGION1

export REGION2=region2
export VPC_subnet2=vpc-demo-subnet2
gcloud compute networks subnets create $VPC_subnet2 \
 --network $VPC --range 10.2.1.0/24 --region $REGION2

# Create a firewall rule to allow all custom traffic within the network
export FIREWALL_IN_RULE_VPC=vpc-demo-allow-custom
gcloud compute firewall-rules create $FIREWALL_RULE_VPC \
  --network $VPC \
  --allow tcp:0-65535,udp:0-65535,icmp \
  --source-ranges 10.0.0.0/8

# Create a firewall rule to allow SSH, ICMP traffic from anywhere
export FIREWALL_EXT_RULE_VPC=vpc-demo-allow-ssh-icmp
gcloud compute firewall-rules create $FIREWALL_EXT_RULE_VPC \
 --network $VPC \
 --allow tcp:22,icmp

# Create two instances in one of those subnets
export VPC_INSTANCE1=vpc-demo-instance1
export ZONE1=zone1
gcloud compute instances create $VPC_INSTANCE1 --machine-type=e2-medium --zone $ZONE1 --subnet $VPC_subnet1

export ZONE2=zone2
export VPC_INSTANCE2=vpc-demo-instance2
gcloud compute instances create $VPC_INSTANCE2 --machine-type=e2-medium --zone $ZONE2 --subnet $VPC_subnet2

##########################
## ON-PREMISE SIMULATED ##
##########################

# Create an on-premise custom network
export ONPREM_VPC=on-prem
gcloud compute networks create $ONPREM_VPC --subnet-mode custom

# Create a subnet
export ONPREM_VPC_subnet=on-prem-subnet1
export REGION=region
gcloud compute networks subnets create $ONPREM_VPC_subnet \
 --network $ONPREM_VPC --range 192.168.1.0/24 --region $REGION

# Create a firewall rule to allow all custom traffic within the networ
export ONPREM_FIREWALL_IN_RULE=on-prem-allow-custom
gcloud compute firewall-rules create $ONPREM_FIREWALL_RULE \
 --network $ONPREM_VPC \
 --allow tcp:0-65535,udp:0-65535,icmp \
 --source-ranges 192.168.0.0/16

# Create a firewall rule to allow SSH, RDP, HTTP, and ICMP traffic to the instances
export ONPREM_FIREWALL_RULE_SSH=on-prem-allow-ssh-icmp
gcloud compute firewall-rules create $ONPREM_FIREWALL_RULE_SSH \
    --network $ONPREM_VPC \
    --allow tcp:22,icmp

# Create an instance in the subnet
export ONPREM_INSTANCE=on-prem-instance1
export ZOne=zone
gcloud compute instances create $ONPREM_INSTANCE --machine-type=e2-medium --zone $ZONE --subnet $ONPREM_VPC_subnet

####################
## HA VPN GATEWAY ##
####################

# Set up HA VPN gateway in each network both on-premise (simulated) and cloud
export VPC_HAGW=vpc-demo-vpn-gw1
gcloud compute vpn-gateways create $VPC_HAGW --network $VPC --region $REGION

export ONPREM_HAGW=on-prem-vpn-gw1
gcloud compute vpn-gateways create $ONPREM_HAGW --network $ONPREM_VPC --region $REGION

# Get details about each HA VPN Gateway
gcloud compute vpn-gateways describe $VPC_HAGW --region $REGION
gcloud compute vpn-gateways describe $ONPREM_HAGW --region $REGION

#  Create a Cloud Router in each network
export VPC_ROUTER=vpc-demo-router1
gcloud compute routers create $VPC_ROUTER \
 --region $REGION \
 --network $VPC \
 --asn 65001

export ONPREM_ROUTER=on-prem-router1
gcloud compute routers create $ONPREM_ROUTER \
 --region $REGION \
 --network $ONPREM_VPC \
 --asn 65002

# Create two VPN tunnels from each HA VPN Gateway in the networks. 
# Used to connect the two interfaces with the two interfaces on the remote gateway
export VPC_TUNNEL0=vpc-demo-tunnel0
gcloud compute vpn-tunnels create $VPC_TUNNEL \
 --peer-gcp-gateway on-prem-vpn-gw1 \
 --region "REGION" \
 --ike-version 2 \
 --shared-secret [SHARED_SECRET] \
 --router vpc-demo-router1 \
 --vpn-gateway vpc-demo-vpn-gw1 \
 --interface 0

export VPC_TUNNEL1=vpc-demo-tunnel1
gcloud compute vpn-tunnels create $VPC_TUNNEL1 \
    --peer-gcp-gateway on-prem-vpn-gw1 \
    --region "REGION" \
    --ike-version 2 \
    --shared-secret [SHARED_SECRET] \
    --router vpc-demo-router1 \
    --vpn-gateway vpc-demo-vpn-gw1 \
    --interface 1


