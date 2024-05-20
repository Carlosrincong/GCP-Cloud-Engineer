
# Verify if Terraform is already installed
terraform --version

# To create directory 
mkdir tfinfra

# To create a file (provider.tf) and copy into: 
# -----------------------------------------
provider "google" {}
# -----------------------------------------

# Go to the folder and intialize Terraform
cd tfinfra
terraform init

# Network
# Create a configuration file (mynetwork.tf) for network definition and copy into:
    # -----------------------------------------
    # Create the mynetwork network
    resource [RESOURCE_TYPE] "mynetwork" {
    name = [RESOURCE_NAME]
    # RESOURCE properties go here
    }
    # -----------------------------------------
    # where [RESOURCE_TYPE]: "google_compute_network"
    #       [RESOURCE_NAME]: "mynetwork"
    # properties: auto_create_subnetworks = "true"

    # -------------------------------------------------
    # Create the mynetwork network
    resource "google_compute_network" "mynetwork" {
    name = "mynetwork"
    # RESOURCE properties go here
    auto_create_subnetworks = "true"
    }
    # -------------------------------------------------

## Firewall rule
    # Add into the network configuration the firewall rules:
    ## -------------------------------------------------------------------------
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
    ## -------------------------------------------------------------------------

# VM instance
    # Create a subfoler and a file (instance/maint.tf) to save the instance definition into:
    # ---------------------------------------------------
    resource "google_compute_instance" "vm_instance" {
    name         = "${var.instance_name}"
    # RESOURCE properties:
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
    # ---------------------------------------------------

    # ${var. ...} are variables which you create in instance/variables.tf:
    # -----------------------------
    variable "instance_name" {}
    variable "instance_zone" {}
    variable "instance_type" {
    default = "e2-micro"
    }
    variable "instance_network" {}
    # -----------------------------

    # You define this variables in mynetwork.tf file
    # -------------------------------------------------------------
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
    # -------------------------------------------------------------

# Formating tf files
terraform fmt
# Intialize terraform
terraform init
# Get execution plan
terraform plan
# Run the execution plan that was give you
terraform apply
