
# Create a custom network with two subnets
# Create a firewall rule to allow traffic from any sources in backend which is in specific IP range
# Create a health check rule (firewall rule to allow health checks) to allow traffic from health check
# Create Cloud NAT to works with instances without external IP address. 
## Therefore, outbound traffic will send through Cloud NAT from the instance and inbound through the load balancer
# Create a instance templeates for instance group creating (as backend of load balancer)
# Create the internal load balancer and setup the frontend and backend


