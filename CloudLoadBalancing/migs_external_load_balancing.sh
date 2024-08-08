
# Create the instance template 
gcloud compute instance-templates create mig-template --project=admin-project-a --machine-type=f1-micro --network-interface=network=default,network-tier=PREMIUM \
 --metadata=startup-script=\#\!\ /bin/bash$'\n'NAME=\$\(curl\ -H\ \"Metadata-Flavor:\ Google\"\ http://metadata.google.internal/computeMetadata/v1/instance/name\)$'\n'ZONE=\$\(curl\ -H\ \"Metadata-Flavor:\ Google\"\ http://metadata.google.internal/computeMetadata/v1/instance/zone\ \|\ sed\ \'s@.\*/@@\'\)$'\n'sudo\ apt-get\ update$'\n'sudo\ apt-get\ install\ -y\ stress\ apache2$'\n'sudo\ systemctl\ start\ apache2$'\n'cat\ \<\<EOF\>\ /var/www/html/index.html$'\n'\<html\>$'\n'\	\<head\>$'\n'\	\	\<title\>\ Managed\ Bowties\ \</title\>$'\n'\ \ \ \ \</head\>$'\n'\ \ \ \ \<style\>$'\n'h1\ \{$'\n'\ \ text-align:\ center\;$'\n'\ \ font-size:\ 50px\;$'\n'\}$'\n'h2\ \{$'\n'\ \ text-align:\ center\;$'\n'\ \ font-size:\ 40px\;$'\n'\}$'\n'h3\ \{$'\n'\ \ text-align:\ right\;$'\n'\}$'\n'\</style\>$'\n'\ \ \ \ \<body\ style=\"font-family:\ sans-serif\"\>\</body\>$'\n'\	\<body\>$'\n'\	\	\<h1\>Aaaand....\ Success\!\</h1\>$'\n'\ \ \ \ \ \ \ \ \<h2\>MACHINE\ NAME\ \<span\ style=\"color:\ \#3BA959\"\>\$NAME\</span\>\ DATACENTER\ \<span\ style=\"color:\ \#5383EC\"\>\$ZONE\</span\>\</h2\>$'\n'\	\	\<section\ id=\"photos\"\>$'\n'\	\	\	\<p\ style=\"text-align:center\;\"\>\<img\ src=\"https://storage.googleapis.com/tony-bowtie-pics/managing-bowties.svg\"\ alt=\"Managing\ Bowties\"\>\</p\>$'\n'\	\	\</section\>$'\n'\	\</body\>$'\n'\</html\>$'\n'EOF \
 --maintenance-policy=MIGRATE --provisioning-model=STANDARD --service-account=242048989354-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/trace.append \
 --tags=http-server,https-server --create-disk=auto-delete=yes,boot=yes,device-name=mig-template,image=projects/debian-cloud/global/images/debian-12-bookworm-v20240709,mode=rw,size=10,type=pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any

# Using the template, create the managed instance group
gcloud beta compute health-checks create tcp health-mig --project=admin-project-a --port=80 --proxy-header=NONE --no-enable-logging --check-interval=5 --timeout=5 --unhealthy-threshold=2 --healthy-threshold=2
gcloud beta compute instance-groups managed create mig --project=admin-project-a --base-instance-name=mig --template=projects/admin-project-a/global/instanceTemplates/mig-template --size=3 --zones=us-east1-b,us-east1-c,us-east1-d --target-distribution-shape=EVEN --instance-redistribution-type=proactive --default-action-on-vm-failure=repair --health-check=projects/admin-project-a/global/healthChecks/health-mig --initial-delay=300 --no-force-update-on-repair --standby-policy-mode=manual --list-managed-instances-results=pageless 
gcloud beta compute instance-groups managed set-autoscaling mig --project=admin-project-a --region=us-east1 --mode=on --min-num-replicas=3 --max-num-replicas=6 --target-cpu-utilization=0.6 --cool-down-period=60

# Define firewall rules that allows health checks
gcloud compute --project=admin-project-a firewall-rules create mig-allow-health-check --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:80 --source-ranges=130.211.0.0/22,35.191.0.0/16

# Create de Load balancer
POST https://compute.googleapis.com/compute/v1/projects/admin-project-a/global/securityPolicies
{
  "description": "Default security policy for: lb-backend",
  "name": "default-security-policy-for-backend-service-lb-backend",
  "rules": [
    {
      "action": "allow",
      "match": {
        "config": {
          "srcIpRanges": [
            "*"
          ]
        },
        "versionedExpr": "SRC_IPS_V1"
      },
      "priority": 2147483647
    },
    {
      "action": "throttle",
      "description": "Default rate limiting rule",
      "match": {
        "config": {
          "srcIpRanges": [
            "*"
          ]
        },
        "versionedExpr": "SRC_IPS_V1"
      },
      "priority": 2147483646,
      "rateLimitOptions": {
        "conformAction": "allow",
        "enforceOnKey": "IP",
        "exceedAction": "deny(403)",
        "rateLimitThreshold": {
          "count": 500,
          "intervalSec": 60
        }
      }
    }
  ]
}

POST https://compute.googleapis.com/compute/beta/projects/admin-project-a/global/backendServices
{
  "backends": [
    {
      "balancingMode": "UTILIZATION",
      "capacityScaler": 1,
      "group": "projects/admin-project-a/regions/us-east1/instanceGroups/mig",
      "maxUtilization": 0.8
    }
  ],
  "connectionDraining": {
    "drainingTimeoutSec": 300
  },
  "consistentHash": {
    "minimumRingSize": "1024"
  },
  "description": "",
  "enableCDN": false,
  "healthChecks": [
    "projects/admin-project-a/global/healthChecks/health-mig"
  ],
  "ipAddressSelectionPolicy": "IPV4_ONLY",
  "loadBalancingScheme": "EXTERNAL_MANAGED",
  "localityLbPolicy": "RING_HASH",
  "logConfig": {
    "enable": false
  },
  "name": "lb-backend",
  "portName": "http",
  "protocol": "HTTP",
  "securityPolicy": "projects/admin-project-a/global/securityPolicies/default-security-policy-for-backend-service-lb-backend",
  "sessionAffinity": "NONE",
  "timeoutSec": 30
}

POST https://compute.googleapis.com/compute/v1/projects/admin-project-a/global/backendServices/lb-backend/setSecurityPolicy
{
  "securityPolicy": "projects/admin-project-a/global/securityPolicies/default-security-policy-for-backend-service-lb-backend"
}

POST https://compute.googleapis.com/compute/v1/projects/admin-project-a/global/urlMaps
{
  "defaultService": "projects/admin-project-a/global/backendServices/lb-backend",
  "name": "global-lb"
}

POST https://compute.googleapis.com/compute/v1/projects/admin-project-a/global/targetHttpProxies
{
  "name": "global-lb-target-proxy",
  "urlMap": "projects/admin-project-a/global/urlMaps/global-lb"
}

POST https://compute.googleapis.com/compute/beta/projects/admin-project-a/global/forwardingRules
{
  "IPProtocol": "TCP",
  "ipVersion": "IPV4",
  "loadBalancingScheme": "EXTERNAL_MANAGED",
  "name": "frontend-lb",
  "networkTier": "PREMIUM",
  "portRange": "80",
  "target": "projects/admin-project-a/global/targetHttpProxies/global-lb-target-proxy"
}

POST https://compute.googleapis.com/compute/beta/projects/admin-project-a/regions/us-east1/instanceGroups/mig/setNamedPorts
{
  "namedPorts": [
    {
      "name": "http",
      "port": 80
    }
  ]
}


# Run stress test using one of the instances in the group
stress --cpu 2 --io 1 --vm 1 --vm-bytes 128M --timeout 30s