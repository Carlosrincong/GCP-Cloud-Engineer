####################################
## IMPORT TERRAFORM CONFIGURATION ##
####################################

# Create a container
docker run --name hashicorp-learn --detach --publish 8080:80 nginx:latest
# verify whether is running
docker ps

# Clone terraform repository
git clone https://github.com/hashicorp/learn-terraform-import.git
# go to the directory
cd learn-terraform-import

# initialize the workspace
terraform init

# Update provider in main.tf file from repository files
# ------------------------------------------------
provider "docker" {
#   host    = "npipe:////.//pipe//docker_engine"
}
# ------------------------------------------------

# Add the following into the docker.tf file
# -----------------------------------
resource "docker_container" "web" {}
# -----------------------------------

# Import docker that is running into backend state
terraform import docker_container.web $(docker inspect -f {{.ID}} hashicorp-learn)

# Verify importing and what is in the state
terraform show

# When it is imported terraform know how the docker is create but the definition (terraform configuration) is not created
# Now you need to create a configuration to match the imported state

# Add the not imported data into a config file
terraform show -no-color > docker.tf

# verify and see the warinings o errors to modify the configuration file
terraform plan

# Removing warnings and errors, the configuration file should looks like:
# ------------------------------------------------------------------------------------
resource "docker_container" "web" {
    image = "sha256:87a94228f133e2da99cb16d653cd1373c5b4e8689956386c1c12b60a20421a02"
    name  = "hashicorp-learn"
    ports {
        external = 8080
        internal = 80
        ip       = "0.0.0.0"
        protocol = "tcp"
    }
}
# ------------------------------------------------------------------------------------

# Verify again
terraform plan

# sync the configuration file, Terraform state, and the container
terraform apply

# The image imported is an ID sha. It is necessary to change it
# Get the image
docker image inspect  -f {{.RepoTags}}

# Add the image in docker.tf file to create an image
# --------------------------------------
resource "docker_image" "nginx" {
  name         = "nginx:latest"
}
# --------------------------------------

# apply changes to create the image
terraform apply

# change the image reference to the new image in docker.tf file
# --------------------------------------
resource "docker_container" "web" {
    image = docker_image.nginx.image_id
    name  = "hashicorp-learn"
    ports {
        external = 8080
        internal = 80
        ip       = "0.0.0.0"
        protocol = "tcp"
    }
}
# --------------------------------------

# sync changes to replace the image
terraform apply