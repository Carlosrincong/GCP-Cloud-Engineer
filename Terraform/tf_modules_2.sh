
# Create the directory
mkdir tfinfra

# With the text editor, create the provider.ft file and type into:
provider "google" {} 

# Go to the new directory and run the init terraform command to install the needed plugins for the specified provider
cd tfinfra
terraform init

# With the text editor, create the mynetwork.ft file and type into:
# -----------------------------------------------------------------------------
# Create the mynetwork network
resource "google_compute_network" "mynetwork" {
name = "mynetwork"
# RESOURCE properties go here
auto_create_subnetworks = "true"
}
# Add a firewall rule to allow HTTP, SSH, RDP and ICMP traffic on mynetwork
resource "google_compute_firewall" "mynetwork-allow-http-ssh-rdp-icmp" {
name = "mynetwork-allow-http-ssh-rdp-icmp"
# RESOURCE properties go here
network = google_compute_network.mynetwork.self_link
allow {
    protocol = "tcp"
    ports    = ["22", "80", "3389"]
    }
allow {
    protocol = "icmp"
    }
source_ranges = ["0.0.0.0/0"]
}
# -----------------------------------------------------------------------------

# Then create a module called instance and inside create a main.tf file where the configurations will go
# Inside the main.tf file type:
# -------------------------------------------------------
resource "google_compute_instance" "vm_instance" {
  name         = "${var.instance_name}"
  zone         = "${var.instance_zone}"
  machine_type = "${var.instance_type}"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      }
  }
  network_interface {
    network = "${var.instance_network}"
    access_config {
      # Allocate a one-to-one NAT IP to the instance
    }
  }
}
# -------------------------------------------------------
# Inside the variables.tf file type:
# ---------------------------------
variable "instance_name" {}
variable "instance_zone" {}
variable "instance_type" {
  default = "e2-micro"
  }
variable "instance_network" {}
# ---------------------------------

# In the mynetwork.tf file reference and use the module to create two VM:
# ------------------------------------------------------------------
# Create the mynet-us-vm instance
module "mynet-us-vm" {
  source           = "./instance"
  instance_name    = "mynet-us-vm"
  instance_zone    = "Zone"
  instance_network = google_compute_network.mynetwork.self_link
}

# Create the mynet-eu-vm" instance
module "mynet-eu-vm" {
  source           = "./instance"
  instance_name    = "mynet-eu-vm"
  instance_zone    = "Zone 2"
  instance_network = google_compute_network.mynetwork.self_link
}
# ------------------------------------------------------------------

# To rewritte the files in terraform format:
terraform fmt

# Initialize terraform
terraform init

# Review the plan to create the defined infrastructure:
terraform plan

# Apply the plan 
terraform apply