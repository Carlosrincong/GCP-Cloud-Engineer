
# Edit the policy to enable the Audit Logs

# Save the current policy 
gcloud projects get-iam-plicy $PROJECT_ID > new-policy.yaml

# Using the Editor, add the following lines in the file
# ---------------------------
auditConfigs:
- auditlogConfigs:
 - logType: ADMIN_READ
 - logtype: DATA_READ
 - logtype: DATA_WRITE
 service: allservices
# ---------------------------

# Update de policy using the file:
gcloud projects get-iam-plicy $PROJECT_ID new-policy.yaml
