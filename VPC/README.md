
# VIRTUAL PRIVATE CLOUD 

VPC is a comprehensive set of Google managed networking objects
- Networks come in three different flavors; default, auto mode, and custom mode. These networks do not have IP ranges
    1. Default: a subnet is allocated for each region with non-overlapping CIDR blocks and firewall rules that allow ingress traffic for ICMP, RDP, and SSH traffic from anywhere, as well as ingress traffic from within the default network for all protocols and ports.
    2. Auto: one subnet from each region is automatically created within it. Subnets wich use a set of predefined IP ranges with a /20 mask that can be expanded to /16. All of these subnets fit within the 10.128.0.0/9 CIDR block. As new Google Cloud regions become available, new subnets in those regions are automatically added
    3. Custom: It does not automatically create subnets and provides you with complete control over its subnets and IP ranges
- Subnetworks allow you to divide or segregate your environment.
- IP addresses for internal and external use along with granular IP address range selections
- VM instances from a networking perspective
- Routes
- Firewall rules



A single VPN can securely connect your on-premises network to your Google Cloud network through a VPN gateway
VMs within the same network can communicate using their internal IP addresses, this means that a single firewall rule can be applied to both VMs. In different network must to comunicate with their external IP addresses. 
The subnet is simply an IP address range, and you can use IP addresses within that range. Every subnet has four reserved IP addresses in its primary IP range
Each IP range for all subnets in a VPC network must be a unique valid CIDR block.

Best Practices:
1. Avoid creating large subnets: overly large subnets are more likely to cause CIDR range collisions when using Multiple Network Interfaces
2. Do not scale your subnet beyond what you actually need.
3. Expand a subnet in GCP without any workload shutdown or downtime