
# Create a configuration file
touch main.tf

# Add the following content for a VPC infrastructure:
# ---------------------------------------------------
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {

  project = "PROJECT ID"
  region  = "REGION"
  zone    = "ZONE"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}
# ---------------------------------------------------

# Initialize terraform in the same directory where is main.tf
terraform init

# provisioning infrastructure specified in the config file
terraform apply

# inspect the current state
terraform show

######################
## CHANGE THE INFRA ##
######################

# Add a vm instance to the end of the file:
# --------------------------------------------------
resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}
# --------------------------------------------------

# apply the changes
terraform apply

# change the instance definition
# --------------------------------------------------
resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "e2-micro"
  tags         = ["web", "dev"]
  # ...
}
# --------------------------------------------------

# apply the changes
terraform apply

# change the boot disk definition of the instance
# --------------------------------------------------
terraform apply

  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-stable"
    }
  }
# --------------------------------------------------

# apply the changes
terraform apply

# Destroy infrastructure
terraform destroy

##################
## DEPENDENCIES ##
##################

# Recreate the destroyed infrastructure
terraform apply

# Add static ip to main.tf file
# -------------------------------------------------
resource "google_compute_address" "vm_static_ip" {
  name = "terraform-static-ip"
}
# -------------------------------------------------

# Show the plan
terraform plan

# update the network interface
# ----------------------------------------------------------
  network_interface {
    network = google_compute_network.vpc_network.self_link
    access_config {
      nat_ip = google_compute_address.vm_static_ip.address
    }
  }
# ----------------------------------------------------------

# Show and save the plan
terraform plan -out static_ip


# Add cloud storage resource using explicit dependencie
# -----------------------------------------------------------------------
# New resource for the storage bucket our application will use.
resource "google_storage_bucket" "example_bucket" {
  name     = "<UNIQUE-BUCKET-NAME>"
  location = "US"

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}

# Create a new instance that uses the bucket
resource "google_compute_instance" "another_instance" {
  # Tells Terraform that this VM instance must be created only after the
  # storage bucket has been created.
  depends_on = [google_storage_bucket.example_bucket] #explicit

  name         = "terraform-instance-2"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-stable"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.self_link # implicit
    access_config {
    }
  }
# -----------------------------------------------------------------------

# Show plan and execute it
terraform plan
terraform apply