
##### PYTHON & GITHUB
# Clone the repository to deploy the function
git clone https://github.com/GoogleCloudPlatform/python-docs-samples.git
cd python-docs-samples/functions/helloworld/

# Deploy the function
gcloud functions deploy function-name \
--gen2 \
--runtime=python312 \
--region=REGION \
--source=. \
--entry-point=hello_get \
--trigger-http \
--allow-unauthenticated

# Get the uri to call the function
gcloud functions describe function-name --gen2 --region REGION --format="value(serviceConfig.uri)"

# Call the function
URI = $(gcloud functions describe function-name --gen2 --region REGION --format="value(serviceConfig.uri)")
curl -m 70 -X POST URI \
    -H "Authorization: Bearer $(gcloud auth print-identity-token)" \
    -H "Content-Type: application/json" \
    -d '{}'

# Delete the function
gcloud functions delete python-http-function --gen2 --region REGION 


##### NODEJS & CLOUD STORAGE


