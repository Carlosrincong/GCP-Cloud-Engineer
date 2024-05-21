# verify that Terraform is available
terraform

# Create the configuration file
touch instance.tf

# add the following content in it
# -----------------------------------------------
resource "google_compute_instance" "terraform" {
  project      = ""
  name         = "terraform"
  machine_type = "e2-medium"
  zone         = ""

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }
}
# -----------------------------------------------

# Initialize terraform
terraform init # To install The Google provider plugin needed and Initializing provider plugins

# Create the execution plan
terraform plan

# If you agree the plan, then apply it
terraform apply

# view the current state
terraform show