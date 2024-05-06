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

# Create a firewall rule to allow all custom traffic within the network
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
# tunnel0 (external) and tunnel1 (internal)
export VPC_TUNNEL0=vpc-demo-tunnel0
gcloud compute vpn-tunnels create $VPC_TUNNEL \
 --peer-gcp-gateway $ONPREM_HAGW \
 --region $REGION \
 --ike-version 2 \
 --shared-secret [SHARED_SECRET] \
 --router $VPC_ROUTER \
 --vpn-gateway $VPC_HAGW \
 --interface 0

export VPC_TUNNEL1=vpc-demo-tunnel1
gcloud compute vpn-tunnels create $VPC_TUNNEL1 \
    --peer-gcp-gateway $ONPREM_HAGW \
    --region $REGION \
    --ike-version 2 \
    --shared-secret [SHARED_SECRET] \
    --router $VPC_ROUTER \
    --vpn-gateway $VPC_HAGW \
    --interface 1

export ONPREM_TUNNEL0=on-prem-tunnel0
gcloud compute vpn-tunnels create $ONPREM_TUNNEL0 \
    --peer-gcp-gateway $VPC_HAGW \
    --region $REGION \
    --ike-version 2 \
    --shared-secret [SHARED_SECRET] \
    --router $ONPREM_ROUTER \
    --vpn-gateway $ONPREM_HAGW \
    --interface 0

export ONPREM_TUNNEL1=on-prem-tunnel1
gcloud compute vpn-tunnels create $ONPREM_TUNNEL1 \
    --peer-gcp-gateway $VPC_HAGW \
    --region $REGION \
    --ike-version 2 \
    --shared-secret [SHARED_SECRET] \
    --router $ONPREM_ROUTER \
    --vpn-gateway $ONPREM_HAGW \
    --interface 1

# Create the interfaces in each VPN gateway. 
# Iterfaces are the tunnel connection point inside the VPN gateway to facilitate the traffic through the tunnel 0 or 1
export ONPREM_IF_0=if-tunnel0-to-on-prem
gcloud compute routers add-interface $VPC_ROUTER \
    --interface-name $ONPREM_IF_0 \
    --ip-address 169.254.0.1 \
    --mask-length 30 \
    --vpn-tunnel $VPC_TUNNEL0 \
    --region $REGION

export ONPREM_IF_1=if-tunnel1-to-on-prem
gcloud compute routers add-interface $VPC_ROUTER \
    --interface-name $ONPREM_IF_1 \
    --ip-address 169.254.1.1 \
    --mask-length 30 \
    --vpn-tunnel $VPC_TUNNEL1 \
    --region $REGION

export VPC_IF_0=if-tunnel0-to-vpc-demo
gcloud compute routers add-interface $ONPREM_ROUTER \
    --interface-name $VPC_IF_0 \
    --ip-address 169.254.0.2 \
    --mask-length 30 \
    --vpn-tunnel $ONPREM_TUNNEL0 \
    --region $REGION

export VPC_IF_1=if-tunnel1-to-vpc-demo
gcloud compute routers add-interface $ONPREM_ROUTER \
    --interface-name $VPC_IF_1 \
    --ip-address 169.254.1.2 \
    --mask-length 30 \
    --vpn-tunnel $ONPREM_TUNNEL01 \
    --region $REGION

# Create Border Gateway Protocol (BGP) peer for each tunnel (0 and 1) in each networks
gcloud compute routers add-bgp-peer $VPC_ROUTER \
    --peer-name bgp-on-prem-tunnel0 \
    --interface $ONPREM_IF_0\
    --peer-ip-address 169.254.0.2 \
    --peer-asn 65002 \
    --region $REGION

gcloud compute routers add-bgp-peer $VPC_ROUTER \
    --peer-name bgp-on-prem-tunnel1 \
    --interface $ONPREM_IF_1 \
    --peer-ip-address 169.254.1.2 \
    --peer-asn 65002 \
    --region $REGION

gcloud compute routers add-bgp-peer $ONPREM_ROUTER \
    --peer-name bgp-vpc-demo-tunnel0 \
    --interface $VPC_IF_0 \
    --peer-ip-address 169.254.0.1 \
    --peer-asn 65001 \
    --region $REGION

gcloud compute routers add-bgp-peer $ONPREM_ROUTER \
    --peer-name bgp-vpc-demo-tunnel1 \
    --interface $VPC_IF_1 \
    --peer-ip-address 169.254.1.1 \
    --peer-asn 65001 \
    --region $REGION

# Get details about Cloud Routers
gcloud compute routers describe $VPC_ROUTER \
 --region $REGION

gcloud compute routers describe $ONPREM_ROUTER \
 --region $REGION

# Define Firewall rules to allow all traffic between the two networks
gcloud compute firewall-rules create vpc-demo-allow-subnets-from-on-prem \
 --network $VPC \
 --allow tcp,udp,icmp \
 --source-ranges 192.168.1.0/24

gcloud compute firewall-rules create on-prem-allow-subnets-from-vpc-demo \
 --network $ONPREM_VPC \
 --allow tcp,udp,icmp \
 --source-ranges 10.1.1.0/24,10.2.1.0/24

# Get status of tunnels
gcloud compute vpn-tunnels list
gcloud compute vpn-tunnels describe $VPC_TUNNEL0 --region $REGION # for specific tunnel

# Verify connectovity over VPN 
# SSH On prem instance and ping VPC IP address to reach instances in this network:
ping -c 4 10.1.1.2

# Update VPC routing to Global
gcloud compute networks update $VPC --bgp-routing-mode GLOBAL
# Verify tha change
gcloud compute networks describe $VPC

# Verify if the traffic is sent even if one tunnel is down
# Bring a tunnel down
gcloud compute vpn-tunnels delete $VPC_TUNNEL0  --region $REGION
# Verify that the tunnel is down
gcloud compute vpn-tunnels describe $ONPREM_TUNNEL0  --region $REGION
# Now send traffic and see how you get response 
ping -c 3 10.1.1.2

