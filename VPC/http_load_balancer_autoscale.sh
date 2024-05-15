
# Create firewall rule to allow http traffic for anywhere
# Create health check rule: firewall rule to allow health checks 

# Create a cumpute engine instance and attach it the firewall rule created previously.
# Create a custom image for compute engine instances using the compute engine instance created 
# Use the instance to set configurations to the Persistent Disk
# Delete the instance but keep the persistent disk
# Create an image from Disk (persistent)
# Once the image is created, we can delete the persistent disk

# Create an instance group: 
# First setup the Instance template, which is going to use the Custom image as Boot disk and be tagged with the firewall rule
# Create one instance group that will use the template, with autoscaling on and Http load balancer
# At the creating instance, you can create the health check service too. 

# Create the HTTP load balancer for our instances groups
# For that, you have to create a backend service. Backend which our instances group must to be attached. And health check active for this service

# Create another compute enfine instance for stress testing.
