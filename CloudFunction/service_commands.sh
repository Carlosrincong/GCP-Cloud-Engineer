
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

# View the logs of function
gcloud functions logs read function-name

# Delete the function
gcloud functions delete python-http-function --gen2 --region REGION 


##### NODEJS

mkdir gcf_hello_world
cd gcf_hello_world
nano index.js # Edit the text file with code to function

# Create a storge as stage to the function
gsutil mb -p project-id gs://bucket-name

# Deploy the function
gcloud functions deploy function-name \
  --stage-bucket gs://bucket-name \
  --trigger-topic hello_world \
  --runtime nodejs20

# Get status of function
gcloud functions describe function-name

# Testing
DATA=$(printf 'Hello World!'|base64) && gcloud functions call function-name --data '{"data":"'$DATA'"}'

# View the logs of function
gcloud functions logs read function-name