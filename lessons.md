

An Associate Cloud Engineer deploys and secures applications and infrastructure, monitors operations of multiple projects and maintains enterprise solutions to ensure that they meet target performance metrics. This individual has experience working with public clouds and on-premises solutions. They are able to use Google Cloud Console and the command line interface to perform common platform based tasks to maintain and scale one or more deployed solutions that leverage Google-managed or self-managed services on Google Cloud. The professional level certification expects the exam taker to know how to evaluate case studies and design solutions to meet business requirements. The associate level is mainly concerned with technical requirements and customer implementation.

Los roles básicos establecen permisos a nivel de proyecto y, a menos que se especifique lo contrario, controlan el acceso y la administración de todos los servicios de Google Cloud. TRUE

1

Establishing a resource hierarchy (organization-folders-projects), implementing organizational policies, managing projects and quotas, managing users and groups*, and applying access management (who, can do what, on wich resourse). Setting up billing and monitoring the use of your cloud resources are also things to consider. Finally, choosing how you interact with Google Cloud is an important decision as well.

*Managing permission and roles at a group level is easier than keeping track of permissions for individual users. This also can be done with Google Workspace instead IAM of GCP. 

Google Cloud's operations suite, which used to be called stack driver, provides metrics and logging services for all your services, resources and projects in your cloud environment. To monitor metrics for multiple projects, you set up project scoping and monitored projects. Where scoping project can monitor to monitored projects. 

It is necesary create a billing account linked with the project, set up alerts and billing exports to track charges

You can use the command "gcloud config set" to configure default options, such as the project and compute region..

Basic roles apply to the project level and do not provide least privilege.
Best practice is to manage role assignment by groups, not by individual users.
Project name is set by the user at creation. It does not have to be unique. It can be changed after creation time.
The Cloud SDK provides a local CLI environment. Cloud Shell provides a cloud-based CLI environment.
Use gcloud storage to interact with Cloud Storage via the Cloud SDK.
Pub/Sub is for programmatic use of alert content.
Get is read-only. Viewer has this permission. Viewers can perform read-only actions that do not affect state.
A billing account can handle billing for more than one project. A project can only be linked to one billing account at a time.

Question 1 tested your ability to assign users to IAM roles. 
- You should not assign roles to an individual user. Users should be added to groups and groups assigned roles to simplify permissions management.
- Roles are combinations of individual permissions. You should assign roles, not individual permissions, to users.
- Best practice is to manage role assignment by groups, not by individual users.
- A policy is a binding that is created when you associate a user with a role. Policies are not "assigned" to a user.



Question 2 explored using organization resource hierarchies in Google Cloud
Question 3 tested your knowledge of the relationship between resources and projects to track resource usage, billing, or permissions. 
Question 4 examined concepts of permission hierarchy
Questions 5 and 6 tested your knowledge of roles in Google Cloud.