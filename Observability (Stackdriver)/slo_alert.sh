
# Clone a repository to  create an application to app engine
git clone https://github.com/haggman/HelloLoggingNodeJS.git

# Go to the directory and open index.js
cd HelloLoggingNodeJS
edit index.js

# In the editor, update the app.yaml file:
# -----------------
runtime: nodejs20
# -----------------

# In the current directory create the App Engine app 
export REGION=REGION
gcloud app create --region=$REGION
# Deploy the app
gcloud app deploy

# generate load on your application
while true; \
do curl -s https://$DEVSHELL_PROJECT_ID.appspot.com/random-error \
-w '\n' ;sleep .1s;done

# In Monitoring console create a SLO:
# Availability metric >> Request-based >> Period length to 7 days >> Goal to 99.5%
# When the SLO is created you can see the Service level indicator, Error budget, and Alerts firing.
# In Alerts firing you can create an alert. 
#   Set Lookback duration to 10 minutes and the burn rate threshold to 1.5. Finally select a notification channel

# Test de new alert

# Edit the index.js file in the line 126 approximately from 1000 to 20
# This is going to generate an error every 20 requests
# Then re-deploy the app
gcloud app deploy

# The alert will be generated due to the active loop
