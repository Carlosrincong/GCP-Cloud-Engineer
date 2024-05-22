
# Create main.tf file
touch main.tf

# Get the project id
gcloud config list --format 'value(core.project)'

# Add the following into the maint.tf file:
# ---------------------------------------------------------
provider "google" {
  project     = "# REPLACE WITH YOUR PROJECT ID"
  region      = "REGION"
}

resource "google_storage_bucket" "test-bucket-for-state" {
  name        = "# REPLACE WITH YOUR PROJECT ID"
  location    = "US"
  uniform_bucket_level_access = true
}
# ---------------------------------------------------------

# Add the backend into the main.tf file:
# ----------------------------------------------
terraform {
  backend "local" {
    path = "terraform/state/terraform.tfstate"
  }
}
# ----------------------------------------------

# initialize terraform and apply the defintion
terraform init
terraform apply

# Examine the state file
terraform show

########################
## STORAGE AS BACKEND ##
########################

# Edit the main.tf file, replacing the backend:
# ----------------------------------------------
terraform {
  backend "gcs" {
    bucket  = "# REPLACE WITH YOUR BUCKET NAME"
    prefix  = "terraform/state"
  }
}
# ----------------------------------------------

# Migrate the state
terraform init -migrate-state

## change the state

# In terraform update the state file
terraform refresh

# Show changes
terraform show




