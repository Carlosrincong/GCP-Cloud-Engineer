# TERRAFORM

*   Terraform to **automate the deployment** of infrastructure on-demand. Let´s you can focus on the **definition** of the infrastructure.
*   Infrastructure as code refers to frameworks that **manipulate Google Cloud APIs to deploy the infrastructure required** to run application code.
*   Infrastructure as code (**IaC**) to provisioning and removing infrastructure. When the deployment complexity is managed in code.This is useful for **continuous deployment**. 
*   Terraform lets you **provision Google Cloud resources**—such as virtual machines, containers, storage, and networking— with **declarative configuration files**, which Deployments are described and documented. Thas configuration tells Terraform how to manage a given collection of infrastructure.
*   You can use terraform using these authentication methods: Cloud SDK (Cloud shell or CLI), through a service account, or through a service account key. 

### Benefits
*   Declarative configuration files can be managed in the same way as application **source code**: version control, collaborate, commit, trace, comments, auditable history, etc.
*   The benefit of a **declarative** approach is that it allows you to specify **what the configuration should be or desired state** and let the system figure out the steps to take.
*   Unlike Cloud Shell, Terraform will **deploy resources in parallel**. You can create explicit dependencies between resources, so that a given resource can only be created after the creation of another resource.
*   As the configuration **changes**, Terraform can determine what changed and create **incremental execution** plans that can be applied.
*   Configurations can be modularized using **templates** which allow the abstraction of resources into reusable components across deployments.

#### Modules
*   Modules are like a python library. Use the public **Terraform Registry or the Cloud Foundation Toolkit** to find useful modules.
*   The **Registry** provides plugins to manage any infrastructure API, pre-made modules to quickly configure common infrastructure components, and examples of how to write quality Terraform code.
*   Using **modules** has the following benefits: organize configuration, encapsulate configuration, re-use configuration, provide consistency, standardize how a given resource is created and ensure best practices. Terraform implements the DRY principle using modules. Try not to fixate on eliminating all the duplications in your configurations. The definition of a module ia a group of one or more Terraform configuration files in a directory. The configuration files can be:
    ![terraform-structure](/img/terraform-structure.png)
    1.  **main.tf** contains the main set of configurations for your module. You can also create other configuration files and organize them in a way that makes sense for your project.
    2.  **variables.tf** contains the variable definitions for your module. Variables are used to parameterize your configuration. You can parameterize values shared between resources. Variables must be declared in the variable block. To access the value of a variable declared within the module, you can use the expressions var.variable_name. The values of these variables are difined at run time. to define the values at run time you can use: **variables_file.tfvars** text file (recommended), CLI apply options or enviroment variables. Values of the variables can be validate using the validation block includes a condition argument for which the validation rule is assigned.
    3.  **outputs.tf** contains the output definitions for your module. Module outputs are made available to the configuration using the module, so they are often used to pass information about the parts of your infrastructure defined by the module to other parts of your configuration. Resource instances managed by Terraform each export attributes whose values can be used elsewhere in configuration.
    4.  **providers.tf** specify the Terraform block that includes the provider definition you will use. Terraform downloads the provider plugin in the root configuration when the provider is declared.
    5.  **terraform.tfstate** Terraform saves the state of resources that it manages in a state file. it’s created and updated automatically.
*   The root module is where terraform plan and terraform apply are run. Normally, this module contains a main.tf file and sets of other modules. In this file you can call the module to reference the code in the module block. In the module block, you must define the module source, which is where the configuration files of this module are located. Also, in the module block you can pass the value of the variables used in that module.
*   Each module has its own main.tf file. The variables created in the variables.tf file in each module only can be used within the module. Otherwise, in the output.tf file you can expose attributes outside of the module.

### Terraform state
*   Terraform has written some data into the terraform.tfstate file. This **state file** is extremely important: reflect the **current state** of your infrastructure and it keeps track of the IDs of created resources so that Terraform knows **what it is managing**. 
*   Terraform uses the resource type and the resource name together as an identifier for the resource.
*   The primary purpose of **Terraform state** is to store bindings between objects in a **remote** system and resource instances declared in your configuration. This state is stored in **terraform.tfstate**
*   A **backend** in Terraform determines how **state** is loaded and how an operation such as apply is executed. Backends can store their state **remotely**. Some benefit of backends are: Keeping sensitive information off disk, Working in a team and Remote operations
*   when stored remotely, the state file is **automatically updated**. It will also automatically store the state file in that backend after each apply.
*   Remote Cloud Storage buckets natively support **state locking**. The file can be locked so that if multiple developers run terraform apply simultaneously, it won’t be corrupted by simultaneous updates.
*   To set up a **Remote Cloud Storage**, create a bucket in the configuration file of your terraform directory. Next, to change the backend configuration, add the code to a new Terraform configuration file called backend.tf.
*   **Import infrastructure** into terraform:
        1.  Identify the existing infrastructure to be imported.
        2.  Import the infrastructure into your Terraform state.
        3.  Write a Terraform configuration that matches that infrastructure.
        4.  Review the Terraform plan to ensure that the configuration matches the expected state and infrastructure.
        5.  Apply the configuration to update your Terraform state.
        ![import-terraform-configuration](/img/import-terraform-configuration.png)

### Terraform WorkFlow
-   Determine which resources are required for the project
-   Define the provider in the providers.tf text file and put into it the code that you can find in Terraform Registry.
-   Create the configuration file with the definition of infrastructure (Infrastructure as code) with Terraform code in .tf files.
    
    A Terraform configuration consists of: 
    -   A root module or root configuration file is the working directory in which Terraform commands are run.
    -   Optional tree for child modules. Child *modules* are optional, and can be variables, outputs, providers, and so forth.
-   Initialize terraform in the same folder as configuration file: **terraform init**. Terraform init is used to initialize the provider with a plugin or install the plugin needed.
-   Get and review the execution plan to achieve the infratructure defined, before the provisioning: **terraform plan**
-   (optional) The **Terraform validator** is a tool for enforcing policy compliance (and governance policies) as part of an infrastructure CI/CD pipeline. To address this policy, the security and governance teams can set up *guardrails*. These guardrails are in the form of *constraints*. These constraints automate the enforcement of the organization policies. Security teams can create a centralized policy library that is used by all teams across the organization to identify and prevent policy violations.
-   Create the infrastructure defined: **terraform apply**
-   View the current state: **terraform show**
-   Destroys infrastructure resources: **terraform destroy**

Running **terraform fmt** on your modules and code automatically applies all formatting rules and recommended styles to assist with readability and consistency.

### HCL Syntax
*   The keyword resource identifies the block as a cloud infrastructure component. The resource block is used to declare a single infrastructure object.
*   Terraform uses the resource type and the resource name together as an identifier for the resource.
*   Meta-arguments can be used with any resource type to change the behavior of resources:
        1.  count: create multiple resourses of the same type. Ideal for identical resourses. 
        2.  for_each: create multiple resourses of the same type according to a map or set of strings. Useful for resourses which some of their arguments need distinct values that can't be directly derived from an integer
        3.  Depends_on: useful to specify *explicit* dependencies. Dependencies which are unknown to terraform. The depends_on argument gives you the flexibility to control the order in which Terraform processes the resources in a configuration.
            Generate the dependendy graph: **terraform graph | dot -Tsvg > graph.svg**
        4.  Lifecycle: defines the lifecycle of a resource for high availability

![terraform-hcl-syntax](/img/terraform-hcl-syntax.png)

-   Blocks are lines of code that belong to a certain type. The order of the blocks or files does not matter.
-   Arguments are part of a block and used to allocate a value (Expressions) to a name (Identifiers). Arguments can be mandatory or optional.
-   Identifiers are names of an argument, block type, or any Terraform-specific constructs.
-   Expressions can be used to assign a value to an identifier within a code block.
-   Comment syntax start with a # for a single-line comment.

# Best practice
-   It’s recommended that you place similar types of resources in a directory and define resources in the main.tf file.
