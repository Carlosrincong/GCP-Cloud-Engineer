
export REGION="REGION"

# Creating the file that will run when the container is up:
nano quickstart.sh
#------------------------------------------
#!/bin/sh
echo "Hello, world! The time is $(date)."
#-------------------------------------------

# Creating a dockerfile:
nano Dockerfile
#-----------------------------
FROM alpine
COPY quickstart.sh /
CMD ["/quickstart.sh"]
#-----------------------------

# This makes the file an executable:
chmod +x quickstart.sh

# Creating a new repository:
export REPOSITORY=docker-repo
echo REPOSITORY

gcloud artifacts repositories create $REPOSITORY --repository-format=docker \
    --location=$REGION --description="Docker repository"

# To build de container image and pushed the image to Artifact registry:
export IMAGE=image-name
echo IMAGE
gcloud builds submit --tag $REGION-docker.pkg.dev/${DEVSHELL_PROJECT_ID}/$REPOSITORY/$IMAGE:tag1

# Create a build configuration file
# This file instructs Cloud Build to use Docker to build an image using the Dockerfile specification in the current local directory
# and then push that image to Artifact Registry
nano cloudbuild.yaml
#----------------------------------------------------------------------------------------------
steps:
- name: 'gcr.io/cloud-builders/docker'
  args: [ 'build', '-t', 'YourRegionHere-docker.pkg.dev/$PROJECT_ID/$REPOSITORY/$IMAGE:tag1', '.' ]
images:
- 'YourRegionHere-docker.pkg.dev/$PROJECT_ID/$REPOSITORY/$IMAGE:tag1'
#----------------------------------------------------------------------------------------------

# Insert region to yaml file by replacing "YourRegionHere"
sed -i "s/YourRegionHere/$REGION/g" cloudbuild.yaml

# verify the file:
cat cloudbuild.yaml

# Use the file as configuration file to start cloud build, build an image and push it to artifact registry
gcloud builds submit --config cloudbuild.yaml