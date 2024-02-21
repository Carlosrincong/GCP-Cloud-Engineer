# Set up 3 VM:

# instance name: www1
  gcloud compute instances create www1 \
    --zone=Zone \
    --tags=network-lb-tag \
    --machine-type=e2-small \
    --image-family=debian-11 \
    --image-project=debian-cloud \
    --metadata=startup-script='#!/bin/bash
      apt-get update
      apt-get install apache2 -y
      service apache2 restart
      echo "<h3>Web Server: www1</h3>" | tee /var/www/html/index.html'

# instance name: www2
  gcloud compute instances create www2 \
    --zone=Zone \
    --tags=network-lb-tag \
    --machine-type=e2-small \
    --image-family=debian-11 \
    --image-project=debian-cloud \
    --metadata=startup-script='#!/bin/bash
      apt-get update
      apt-get install apache2 -y
      service apache2 restart
      echo "<h3>Web Server: www2</h3>" | tee /var/www/html/index.html'

# instance name: www3
  gcloud compute instances create www3 \
    --zone=Zone  \
    --tags=network-lb-tag \
    --machine-type=e2-small \
    --image-family=debian-11 \
    --image-project=debian-cloud \
    --metadata=startup-script='#!/bin/bash
      apt-get update
      apt-get install apache2 -y
      service apache2 restart
      echo "<h3>Web Server: www3</h3>" | tee /var/www/html/index.html'

# Create firewall rule with name 'www-firewall-network-lb' to allow external traffic to 3 VM.
gcloud compute firewall-rules create www-firewall-network-lb \
    --target-tags network-lb-tag --allow tcp:80
# --allow protocol:port

# Generate list of VM to check if each one is running
gcloud compute instances list
curl http://[IP_ADDRESS]

# Create external IP address named 'network-lb-ip-1'
gcloud compute addresses create network-lb-ip-1 \
  --region Region

# Create legacy HTTP health check. Checks if the instaces are responding to the traffic. Usefull to Load balancing
gcloud compute http-health-checks create basic-check

# Create target pool to set a group of instances which receive the traffic
gcloud compute target-pools create www-pool \
  --region Region --http-health-check basic-check

# Add instances to the pool
gcloud compute target-pools add-instances www-pool \
    --instances www1,www2,www3

# Create forwarding rules. Forwarding rules specifies how to route the traffic to a loand balancer.
gcloud compute forwarding-rules create www-rule \
    --region  Region \
    --ports 80 \
    --address network-lb-ip-1 \
    --target-pool www-pool
