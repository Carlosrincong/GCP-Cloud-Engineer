# Google Cloud CLI (version local de Cloud Shell)

gcloud init # para inicializar el CLI. En cloud shell no es necesario.
## ES posible que requiera iniciar sesion. 

gcloud components list # list of all components and commands such as bq, kubectl, gsutil, and so on. 
gcloud components install $COMPONENT_NAME # install a specific component that is not installed
gcloud components remove $COMPONENT_NAME # Remove a specific component
gcloud components update # update all components
# To install a tool which can help us with the commands and their description and options:
gcloud components install beta
gcloud beta interactive


gcloud config set project VALUE # Sets the default project to the active configuration
gcloud config set compute/region REGION # Sets the default region to compute to the active configuration
gcloud config set compute/zone ZONE # Sets the default zone to compute to the active configuration
gcloud config get-value project # To view the project id
gcloud compute project-info describe --project $(gcloud config get-value project) # To view details about the project

gcloud -h # list of commands
gcloud config --help # getting help
gcloud config list # get details of the current configuration in the selected configuration
gcloud config list --all
gcloud config configurations activate $CONFIGURATION_NAME # To change the selected configuration
gcloud config configurations describe $CONFIGURATION_NAME # Get details of the specific configuration

gcloud logging logs list # View logs
gcloud logging logs list --filter="compute"
gcloud logging read "resource.type=instance_name" --limit 5 # View logs related with resource named: 'instance_name'
gcloud logging read "resource.type=instance_name AND labels.instance_name='gcelab2'" --limit 5 # View logs related with instance 'gcelab2' in resource 'instance_name'

gcloud auth list # Get the list of all accounts and the active account in the SDK
gcloud config set account $ACCOUNT_USER # Change the active account
gcloud auth revoke $ACCOUNT_USER # to delete a specific account 