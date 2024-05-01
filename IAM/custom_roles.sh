
# Permissions structure: <service>.<resource>.<verb>
# To create custom roles you need iam.roles.create permission}

# to get the list of PERMISSIONS available
export DEVSHELL_PROJECT_ID=project-id
gcloud iam list-testable-permissions //cloudresourcemanager.googleapis.com/projects/$DEVSHELL_PROJECT_ID

# to view the ROLE metadata
export ROLE_NAME=role-name
gcloud iam roles describe $ROLE_NAME

# to list grantable ROLES from your project
gcloud iam list-grantable-roles //cloudresourcemanager.googleapis.com/projects/$DEVSHELL_PROJECT_ID

########################
## Create custom role ##
########################

# Using a YAML file:
gcloud iam roles create editor \
 --project $DEVSHELL_PROJECT_ID \
 --file role-definition.yaml # contains the rol definition
 # at project level or "--organization" to organization level

# Rol definition (YAML)
# -------------------------------------------------
title: [ROLE_TITLE]
description: [ROLE_DESCRIPTION]
stage: [LAUNCH_STAGE] # such as ALPHA, BETA, or GA.
includedPermissions:
- [PERMISSION_1]
- [PERMISSION_2]
# -------------------------------------------------

# Using flags:
gcloud iam roles create viewer --project $DEVSHELL_PROJECT_ID \
 --title "Role Tittle" --description "Custom role description." \
 --permissions compute.instances.get, compute.instances.list --stage ALPHA

# List of custom roles
gcloud iam roles list --project $DEVSHELL_PROJECT_ID # or for organization level

# List of predifined roles
gcloud iam roles list

########################
## Update custom role ##
########################

# Using YAML file:
# Get the current definition for the role and update the role definition on YAML 
gcloud iam roles describe $ROLE_NAME --project $DEVSHELL_PROJECT_ID

# Update existing custom role using YAML role definition updated version
gcloud iam roles update $ROLE_NAME --project $DEVSHELL_PROJECT_ID \
 --file new-role-definition.yaml # new definition

# Using flags:
# --add-permissions or --remove-permissions
gcloud iam roles update $ROLE_NAME --project $DEVSHELL_PROJECT_ID \
 --add-permissions storage.buckets.get,storage.buckets.list

####################################
## Disable, delete & restore role ##
####################################

# Disable role
gcloud iam roles update $ROLE_NAME --project $DEVSHELL_PROJECT_ID \
 --stage DISABLED

# Delete role
gcloud iam roles delete $ROLE_NAME --project $DEVSHELL_PROJECT_ID

# Restore role
gcloud iam roles undelete $ROLE_NAME --project $DEVSHELL_PROJECT_ID