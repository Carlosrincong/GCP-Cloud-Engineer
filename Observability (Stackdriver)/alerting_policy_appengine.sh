# https://www.cloudskillsboost.google/paths/11/course_templates/99/labs/432500

## Update the python environment
 python3 -m pip install --upgrade pip
 python3 -m venv myenv
 source myenv/bin/activate 

# Clone a repository
git clone --depth 1 https://github.com/GoogleCloudPlatform/training-data-analyst.git

# Go to the repository folder
cd ~/training-data-analyst/courses/design-process/deploying-apps-to-gcp

# View the flask python application
edit main.py

# Load dependencies and then start de app
pip3 install -r requirements.txt
python3 main.py

# Now yo can check on port 8080
# CTRL+C to exit the running Flask server

# Create a YAML file and paste into it:
runtime: python312

# Create an App Egine application:
export REGION=REGION
echo REGION
gcloud app create --region=$REGION

# Deploy the app using the YAML file and the contento of the directory
gcloud app deploy --version=one --quiet

# In the App Engine console the applications and its link will appear

# In the App Engine console, Select Logs from the Diagnose column

# In Monitoring console, you can set a metric in the metric explorer: 
# Set the metric: GAE Application > Http > Response latency. with the agregation: 99th percentile

# In Alerting console, add a new notification channel
# Then create an alerting policy selecting the same metric: GAE Application > Http > Response latency
# And Set rolling window to 1 min
# Then Set up a condition so that:
#    if Any time series violates the Threshold postion is above and Threshold value to 8000ms, 
#    it should trigger an alert. 
# finally set the condition name
# Set the alert adding the notification channel and alert name

# Go to the main file of app and edit it, to add a sleep command
# ------------------------------
import time
import random
import json

@app.route("/")
def main():
    model = {"title": "Hello GCP."}
    time.sleep(10)
    return render_template('index.html', model=model)
    
# -------------------------------------------

# Re-deploy the app with the changes
gcloud app deploy --version=two --quiet

# To generate some consistent load
while true; do curl -s https://$DEVSHELL_PROJECT_ID.appspot.com/ | grep -e "<title>" -e "error";sleep .$[( $RANDOM % 10 )]s;done
# Use CTRL+C to finish the lop when the you receive the alert via email

###############################
## Alerting Policy using CLI ##
###############################


# Go to the directory and create a new file named: app-engine-error-percent-policy.json.
# Add the following content:
# ---------------------------------------------------------------------------------------------------------------
{
    "displayName": "HTTP error count exceeds 1 percent for App Engine apps",
    "combiner": "OR",
    "conditions": [
        {
            "displayName": "Ratio: HTTP 500s error-response counts / All HTTP response counts",
            "conditionThreshold": {
                 "filter": "metric.label.response_code>=\"500\" AND metric.label.response_code<\"600\" AND metric.type=\"appengine.googleapis.com/http/server/response_count\" AND resource.type=\"gae_app\"",
                 "aggregations": [
                    {
                        "alignmentPeriod": "60s",
                        "crossSeriesReducer": "REDUCE_SUM",
                        "groupByFields": [
                          "project",
                          "resource.label.module_id",
                          "resource.label.version_id"
                        ],
                        "perSeriesAligner": "ALIGN_DELTA"
                    }
                ],
                "denominatorFilter": "metric.type=\"appengine.googleapis.com/http/server/response_count\" AND resource.type=\"gae_app\"",
                "denominatorAggregations": [
                   {
                      "alignmentPeriod": "60s",
                      "crossSeriesReducer": "REDUCE_SUM",
                      "groupByFields": [
                        "project",
                        "resource.label.module_id",
                        "resource.label.version_id"
                       ],
                      "perSeriesAligner": "ALIGN_DELTA"
                    }
                ],
                "comparison": "COMPARISON_GT",
                "thresholdValue": 0.01,
                "duration": "0s",
                "trigger": {
                    "count": 1
                }
            }
        }
    ]
}
# ---------------------------------------------------------------------------------------------------------------

# Deploy the alerting policy:
gcloud alpha monitoring policies create --policy-from-file="app-engine-error-percent-policy.json"

# Replace the main.py file to recreate an error to test the alerting policy
# --------------------------------------------------------------------
@app.route("/")
def main():
    num = random.randrange(49)
    if num == 0:
        return json.dumps({"error": 'Error thrown randomly'}), 500
    else:
        model = {"title": "Hello GCP."}
        return render_template('index.html', model=model)
    
# --------------------------------------------------------------------

# Redeploy the app
gcloud app deploy --version=two --quiet

# Rerun the load generator
while true; do curl -s https://$DEVSHELL_PROJECT_ID.appspot.com/ | grep -e "<title>" -e "error";sleep .$[( $RANDOM % 10 )]s;done

# In Monitoring > Alerting you will see the alert generated
#  CTRL+C to stop the requests