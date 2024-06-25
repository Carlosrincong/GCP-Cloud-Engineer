
# To retrieve your Project ID
gcloud config list --format 'value(core.project)'

# Create the main.tf file with a local state file
# ------------------------------------------------------------
provider "google" {
  project     = "Project ID"
  region      = "Region"
}
resource "google_storage_bucket" "test-bucket-for-state" {
  name        = "Project ID"
  location    = "US" # Replace with EU for Europe region
  uniform_bucket_level_access = true
}
terraform {
  backend "local" {
    path = "terraform/state/terraform.tfstate"
  }
}
# ------------------------------------------------------------

# Intialize terraform
terraform init

# Apply tha changes
terraform apply

# View the state file
terraform show

# Update the main.tf file with the remote state file
# -------------------------------
provider "google" {
  project     = "Project ID"
  region      = "Region"
}
resource "google_storage_bucket" "test-bucket-for-state" {
  name        = "Project ID"
  location    = "US" # Replace with EU for Europe region
  uniform_bucket_level_access = true
}
terraform {
  backend "gcs" {
    bucket  = "Project ID"
    prefix  = "terraform/state"
  }
}
# -------------------------------

# Initialize terraform again
terraform init -migrate-state # The state file in the Cloud Storage will be created

# To update the remote state file, without modify the infrastructure
terraform refresh

# Destroy the resources
# First migrate the remote state file to the local state file

# Edit the main.tf file
# -----------------------------------------------
terraform {
  backend "local" {
    path = "terraform/state/terraform.tfstate"
  }
}
# -----------------------------------------------

# Initialize terraform to update the backend
terraform init -migrate-state

# Edit the bucket configuration
# -----------------------------------------------------------
resource "google_storage_bucket" "test-bucket-for-state" {
  name        = "Project ID"
  location    = "US" # Replace with EU for Europe region
  uniform_bucket_level_access = true
  force_destroy = true
}
# -----------------------------------------------------------

# Apply the changes and destroy the infrastructure
terraform apply
terraform destroy