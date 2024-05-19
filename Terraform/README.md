# TERRAFORM

*   Terraform to **automate the deployment** of infrastructure on-demand. Let´s you can focus on the **definition** of the infrastructure.
*   Infrastructure as code (**IaC**) to provisioning and removing infrastructure. When the deployment complexity is managed in code.This is useful for **continuous deployment**. 
*   Configurations can be modularized using **templates** which allow the abstraction of resources into reusable components across deployments.
*   Terraform lets you **provision Google Cloud resources**—such as virtual machines, containers, storage, and networking—with **declarative** configuration files, which Deployments are described and documented. Thas configuration tells Terraform how to manage a given collection of infrastructure.
*   The benefit of a **declarative** approach is that it allows you to specify **what the configuration should be** and let the system figure out the steps to take.
*   Unlike Cloud Shell, Terraform will **deploy resources in parallel**.

### How to use
- create the configuration file with the definition of infrastructure
- Initialize terraform in the same folder as configuration file: terraform init
- Get plan to achieve the infratructure defined, before the provisioning: terraform plan
- Create the infrastructure defined: terraform apply
