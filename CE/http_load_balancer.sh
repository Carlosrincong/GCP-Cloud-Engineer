
## HTTP LOAD BALANCER
# You can configure URL rules to route some URLs to one set of instances and route other URLs to other instances.
# Requests are always routed to the instance group that is closest to the user
# To set up a load balancer with a Compute Engine backend, your VMs need to be in an instance group. 
# This group will run as backend of an external HTTP load balancer

# Create instance template. Template saves a virtual machine's configuration of individual or MIG (Managed instance group)
gcloud compute instance-templates create lb-backend-template \
   --region=Region \
   --network=default \
   --subnet=default \
   --tags=allow-health-check \
   --machine-type=e2-medium \
   --image-family=debian-11 \
   --image-project=debian-cloud \
   --metadata=startup-script='#!/bin/bash
     apt-get update
     apt-get install apache2 -y
     a2ensite default-ssl
     a2enmod ssl
     vm_hostname="$(curl -H "Metadata-Flavor:Google" \
     http://169.254.169.254/computeMetadata/v1/instance/name)"
     echo "Page served from: $vm_hostname" | \
     tee /var/www/html/index.html
     systemctl restart apache2'

# Create MIG based on the template
gcloud compute instance-groups managed create lb-backend-group \
   --template=lb-backend-template --size=2 --zone=Zone

# Create a firewall rule
gcloud compute firewall-rules create fw-allow-health-check \
  --network=default \
  --action=allow \
  --direction=ingress \
  --source-ranges=130.211.0.0/22,35.191.0.0/16 \
  --target-tags=allow-health-check \
  --rules=tcp:80

# Create global static external IP address (to reach the load balancer)
gcloud compute addresses create lb-ipv4-1 \
  --ip-version=IPV4 \
  --global

# Create health check for the load balancer.  Checks if the instaces are responding to the traffic. Usefull to Load balancing
gcloud compute health-checks create http http-basic-check \
  --port 80

# Create backend service. Define how the load balancer distributtes traffic to backend (MIG, NEG)
gcloud compute backend-services create web-backend-service \
  --protocol=HTTP \
  --port-name=http \
  --health-checks=http-basic-check \
  --global

# Add instances as backend of backend service:
gcloud compute backend-services add-backend web-backend-service \
  --instance-group=lb-backend-group \
  --instance-group-zone=Zone \
  --global

# Creat url map to route HTTP request to backend services. setting rules to using different resources for each url on map
gcloud compute url-maps create web-map-http \
    --default-service web-backend-service

# create target http proxies to terminate incoming connections from clients and create new connections from the load balancer to the backends.
gcloud compute target-http-proxies create http-lb-proxy \
    --url-map web-map-http

#Create a global forwarding rule to route incoming requests to the proxy. That represents the front end of load balancer
gcloud compute forwarding-rules create http-content-rule \
   --address=lb-ipv4-1\
   --global \
   --target-http-proxy=http-lb-proxy \
   --ports=80