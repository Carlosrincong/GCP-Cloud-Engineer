
terraform -version

# create the directroy
mkdir tfinfra && cd $_

# using the editor create the provider.tf file:
# --------------------------------

  provider "google" {
  project = "Project ID"
  region  = ""REGION""
  zone    = ""ZONE""
}
# ---------------------------------

# With the provider defined, install the plugins of the provider
terraform init

# Using the editor, create the instance.tf file 
# ------------------------------------------------------
resource google_compute_instance "vm_instance" {
name         = "${var.instance_name}"
zone         = "${var.instance_zone}"
machine_type = "${var.instance_type}"
boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      }
  }
 network_interface {
    network = "default"
    access_config {
      # Allocate a one-to-one NAT IP to the instance
    }
  }
}
# ------------------------------------------------------

# Using the editor, create de variables.tf file, to define variables
# ---------------------------------------------------------
variable "instance_name" {
  type        = string
  description = "Name for the Google Compute instance"
}
variable "instance_zone" {
  type        = string
  description = "Zone for the Google Compute instance"
}
variable "instance_type" {
  type        = string
  description = "Disk type of the Google Compute instance"
  default     = "e2-medium"
  }
# ---------------------------------------------------------

# Using the editor create the output.tf file
# ----------------------------------------------------------
output "network_IP" {
  value = google_compute_instance.vm_instance.instance_id
  description = "The internal ip address of the instance"
}
output "instance_link" {
  value = google_compute_instance.vm_instance.self_link
  description = "The URI of the created resource."
}
# ----------------------------------------------------------

# Using the editor, update the instances.tf file
# ---------------------------------------------------------
 resource "google_compute_address" "vm_static_ip" {
  name = "terraform-static-ip"
}
 resource google_compute_instance "vm_instance" {
name         = "${var.instance_name}"
zone         = "${var.instance_zone}"
machine_type = "${var.instance_type}"
boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      }
  }
 network_interface {
    network = "default"
    access_config {
      # Allocate a one-to-one NAT IP to the instance
      nat_ip = google_compute_address.vm_static_ip.address
    }
  }
}
# ---------------------------------------------------------

# Initialize terraform
terraform init

# Review the plan
terraform plan

# Apply the plan showed
terraform apply

# Explicit dependency
# Using the editor, create the expo.tf file to create a new instance that uses the bucket 
# -------------------------------------------------------------------------
resource "google_compute_instance" "another_instance" {

  name         = "terraform-instance-2"
  machine_type = "e2-micro"
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
  # Tells Terraform that this VM instance must be created only after the
  # storage bucket has been created.
  depends_on = [google_storage_bucket.example_bucket]
}
resource "google_storage_bucket" "example_bucket" {
  name     = "<UNIQUE-BUCKET-NAME>"
  location = "US"
  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}
# -------------------------------------------------------------------------

# Check the plan
terraform plan

# Apply the plan
terraform apply

# View the dependency graph
terraform graph | dot -Tsvg > graph.svg
