
# List running containers
docker ps
docker ps -a # to see all containers (even finished containers)

# Create a directory and go into taht folder
mkdir test && cd test

# Create a Dockerfile
cat > Dockerfile <<EOF
# Use an official Node runtime as the parent image
FROM node:lts

# Set the working directory in the container to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
ADD . /app

# Make the container's port 80 available to the outside world
EXPOSE 80

# Run app.js using node when the container launches
CMD ["node", "app.js"]
EOF

# write the node application in app.js file
cat > app.js << EOF;
const http = require("http");

const hostname = "0.0.0.0";
const port = 80;

const server = http.createServer((req, res) => {
	res.statusCode = 200;
	res.setHeader("Content-Type", "text/plain");
	res.end("Hello World\n");
});

server.listen(port, hostname, () => {
	console.log("Server running at http://%s:%s/", hostname, port);
});

process.on("SIGINT", function () {
	console.log("Caught interrupt signal and will exit");
	process.exit();
});
EOF

# Build the image using files in the current directory
export IMAGE_NAME=image-name
export TAG_VERSION=0.1 # Escpecify the version of an image
docker build -t $IMAGE_NAME:$TAG_VERSION .

# List the images
docker images

# Run container based on the image
export CONTAINER_NAME=container-name
docker run -p 4000:80 --name $CONTAINER_NAME $IMAGE_NAME:$TAG_VERSION

# Test the server
curl http://localhost:4000

# Stop and remove the container
docker stop $CONTAINER_NAME && docker rm $CONTAINER_NAME

# Start the container in background
docker run -p 4000:80 --name $CONTAINER_NAME -d $IMAGE_NAME:$TAG_VERSION
docker ps # Identify the container id and status

# View logs of the container
export CONTAINER_ID=id
docker logs $CONTAINER_ID

# In cloud shell go to the directory
cd test

# Edit app.js
nano app.js
....
const server = http.createServer((req, res) => {
    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/plain');
    res.end('Welcome to Cloud\n');
});
....

# build the new version of the app 
export TAG_NEW_VERSION=0.2 # Escpecify the version of an image
docker build -t $IMAGE_NAME:$TAG_NEW_VERSION .

# run other container deploying the new version of the image
export NEW_CONTAINER_NAME=container-name-new
docker run -p 8080:80 --name $NEW_CONTAINER_NAME -d $IMAGE_NAME:TAG_NEW_VERSION
docker ps # list of containers and them id

# Test the container
curl http://localhost:8080

# Get container id
docker ps # list of containers and them id

# View logs
export CONTAINER_ID=id
docker logs -f $CONTAINER_ID

# Start an interactive bash session inside the running container
docker exec -it $CONTAINER_ID bash
# -----------------  bash session
...
exit
# --------------------------------

# View container metadata with inspect
docker inspect $CONTAINER_ID
# --format= to get specific fields of metadata
docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $CONTAINER_ID

#######################
## Artifact Registry ##
#######################

# format: docker.pkg.dev/my-project/my-repo/my-image

# Create repository
export REPOSITORY=my-repository
gcloud artifacts repositories create $REPOSITORY \
 --repository-format=docker --location="REGION" --description="Docker repository"

# Go to the directory and build an image
cd ~/test
export REGION=region
docker build -t $REGION-docker.pkg.dev/$PROJECT_ID/$REPOSITORY/$IMAGE_NAME:$TAG_NEW_VERSION . 

# List of images
docker images

# Push the image
docker push $REGION-docker.pkg.dev/$PROJECT_ID/$REPOSITORY/$IMAGE_NAME:$TAG_NEW_VERSION

# Test the image

# Stop and remove all containers
docker stop $(docker ps -q)
docker rm $(docker ps -aq)

# Remove all images
docker rmi $REGION-docker.pkg.dev/$PROJECT_ID/$REPOSITORY/$IMAGE_NAME:$TAG_NEW_VERSION
docker rmi node:lts
docker rmi -f $(docker images -aq) # remove remaining images
docker images

# Pull and run the image 
docker run -p 4000:80 -d $REGION-docker.pkg.dev/$PROJECT_ID/$REPOSITORY/$IMAGE_NAME:$TAG_NEW_VERSION

# Test the running container
curl http://localhost:4000