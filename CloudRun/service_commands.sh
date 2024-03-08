
# Enable CLoud Run API
gcloud services enable run.googleapis.com

# Create a project:
mkdir helloworld && cd helloworld
# Create a file
nano package.json
# With this content:
#-----------------------------------------------------------
{
  "name": "helloworld",
  "description": "Simple hello world sample in Node",
  "version": "1.0.0",
  "main": "index.js",
  "scripts": {
    "start": "node index.js"
  },
  "author": "Google LLC",
  "license": "Apache-2.0",
  "dependencies": {
    "express": "^4.17.1"
  }
}
# CTRL + X
#----------------------------------------------------------

# Create other file:
nano index.js
# with this content:
#----------------------------------------------------------
const express = require('express');
const app = express();
const port = process.env.PORT || 8080;

app.get('/', (req, res) => {
  const name = process.env.NAME || 'World';
  res.send(`Hello ${name}!`);
});

app.listen(port, () => {
  console.log(`helloworld: listening on port ${port}`);
});
#------------------------------------------------------------
# CTRL + X

# Create a Dockerfile, to containerize de app in the same directory:
nano Dockerfile
# And edit its content:
#------------------------------------------------------------------
# Use the official lightweight Node.js 12 image.
# https://hub.docker.com/_/node
FROM node:12-slim

# Create and change to the app directory.
WORKDIR /usr/src/app

# Copy application dependency manifests to the container image.
# A wildcard is used to ensure copying both package.json AND package-lock.json (when available).
# Copying this first prevents re-running npm install on every code change.
COPY package*.json ./

# Install production dependencies.
# If you add a package-lock.json, speed your build by switching to 'npm ci'.
# RUN npm ci --only=production
RUN npm install --only=production

# Copy local code to the container image.
COPY . ./

# Run the web service on container startup.
CMD [ "npm", "start" ]
#-----------------------------------------------------------------
# CTRL + X


# build the container image in the directory with the docker file:
gcloud builds submit --tag gcr.io/$GOOGLE_CLOUD_PROJECT/helloworld
# The image is stored in Artifact Registry and can be re-used if desired.

# Get list of images:
gcloud container images list

# Test app locally from cloud shell:
docker run -d -p 8080:8080 gcr.io/$GOOGLE_CLOUD_PROJECT/helloworld

# Deploy containerizied app to cloud run using the created image:
gcloud run deploy --image gcr.io/$GOOGLE_CLOUD_PROJECT/helloworld --allow-unauthenticated --region=$LOCATION

# Delete a image
gcloud container images delete gcr.io/$GOOGLE_CLOUD_PROJECT/helloworld

# Delete a cloud run deploy:
gcloud run services delete helloworld --region="REGION"