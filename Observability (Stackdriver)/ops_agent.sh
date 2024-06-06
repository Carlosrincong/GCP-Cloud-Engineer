#https://cloudskillsboost.google/paths/11/course_templates/864/labs/467971

# Create a compute engine instance
# boot disck: Debian GNU/Linux. Machine type: e2-small. Allow HTTP/s traffic

# SSH the vm and Install apache web server
sudo apt-get update 
sudo apt-get install apache2 php7.0

# Install the Ops agent
curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh
sudo bash add-google-cloud-ops-agent-repo.sh --also-install

# Configures Ops Agent to collect telemetry from the app and restart Ops Agent.

set -e

# Create a back up of the existing file so existing configurations are not lost.
sudo cp /etc/google-cloud-ops-agent/config.yaml /etc/google-cloud-ops-agent/config.yaml.bak

# Configure the Ops Agent.
sudo tee /etc/google-cloud-ops-agent/config.yaml > /dev/null << EOF
metrics:
  receivers:
    apache:
      type: apache
  service:
    pipelines:
      apache:
        receivers:
          - apache
logging:
  receivers:
    apache_access:
      type: apache_access
    apache_error:
      type: apache_error
  service:
    pipelines:
      apache:
        receivers:
          - apache_access
          - apache_error
EOF

sudo service google-cloud-ops-agent restart
sleep 60

# Generate traffic to check if the logs were uploaded to monitoring console
timeout 120 bash -c -- 'while true; do curl localhost; sleep $((RANDOM % 4)) ; done'
# Monitoring > Dashboard > All Dashboards > Apache Overview 

# Create an alerting policy using the logs
# Fisrt create a notification channel
    # Monitoring > Alerting > Notification channels
# Then Create the policy 
    # Monitoring > Alerting > Create policy
    # VM instance > Apache > workload/apache.traffic
    # Rolling window: 1 min. Rolling window function: rate
    # Alert trigger: Any time series violates. Threshold position: Above threshold. Threshold value: 4000

# SSH and verify the alert
timeout 120 bash -c -- 'while true; do curl localhost; sleep $((RANDOM % 4)) ; done'