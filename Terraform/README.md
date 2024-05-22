# TERRAFORM

*   Terraform to **automate the deployment** of infrastructure on-demand. Let´s you can focus on the **definition** of the infrastructure.
*   Infrastructure as code (**IaC**) to provisioning and removing infrastructure. When the deployment complexity is managed in code.This is useful for **continuous deployment**. 
*   Configurations can be modularized using **templates** which allow the abstraction of resources into reusable components across deployments.
*   Terraform lets you **provision Google Cloud resources**—such as virtual machines, containers, storage, and networking—with **declarative** configuration files, which Deployments are described and documented. Thas configuration tells Terraform how to manage a given collection of infrastructure.
*   The benefit of a **declarative** approach is that it allows you to specify **what the configuration should be** and let the system figure out the steps to take.
*   Unlike Cloud Shell, Terraform will **deploy resources in parallel**.
*   As the configuration **changes**, Terraform can determine what changed and create **incremental execution** plans that can be applied.
*   Terraform has written some data into the terraform.tfstate file. This state file is extremely important: it keeps track of the IDs of created resources so that Terraform knows what it is managing.
*   Using **modules** has the following benefits: organize configuration, encapsulate configuration, re-use configuration, provide consistency and ensure best practices. 
    ![terraform-structure](/img/terraform-structure.png)
    1.  **main.tf** contains the main set of configurations for your module. You can also create other configuration files and organize them in a way that makes sense for your project.
    2.  **variables.tf** contains the variable definitions for your module.
    3.  **outputs.tf** contains the output definitions for your module. Module outputs are made available to the configuration using the module, so they are often used to pass information about the parts of your infrastructure defined by the module to other parts of your configuration.
*   modules are like a python library. Use the public **Terraform Registry** to find useful modules. 
*   The primary purpose of **Terraform state** is to store bindings between objects in a remote system and resource instances declared in your configuration. This state is stored in **terraform.tfstate**
*   A **backend** in Terraform determines how **state** is loaded and how an operation such as apply is executed. Backends can store their state remotely. Some benefit of backends are: Keeping sensitive information off disk, Working in a team and Remote operations
*   **Import infrastructure** into terraform:
        1.  Identify the existing infrastructure to be imported.
        2.  Import the infrastructure into your Terraform state.
        3.  Write a Terraform configuration that matches that infrastructure.
        4.  Review the Terraform plan to ensure that the configuration matches the expected state and infrastructure.
        5.  Apply the configuration to update your Terraform state.
        ![import-terraform-configuration](/img/import-terraform-configuration.png)


### How to use
- create the configuration file with the definition of infrastructure (Infrastructure as code)
- Initialize terraform in the same folder as configuration file: terraform init
- Get a execution plan to achieve the infratructure defined, before the provisioning: terraform plan
- Create the infrastructure defined: terraform apply
- View the current state: terraform show