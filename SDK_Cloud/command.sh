# Google Cloud CLI (version local de Cloud Shell)

gcloud init # para inicializar el CLI 

## ES posible que requiera iniciar sesion. 

gcloud config set project VALUE # Sets the default project
gcloud config set compute/region REGION # Sets the default region to compute
gcloud config set compute/zone ZONE # Sets the default zone to compute
gcloud config get-value project # To view the project id
gcloud compute project-info describe --project $(gcloud config get-value project) # To view details about the project

gcloud -h # list of commands
gcloud config --help # getting help
gcloud config list # list of config in enviroment
gcloud config list --all
gcloud components list # list of our components

gcloud logging logs list # View logs
gcloud logging logs list --filter="compute"
gcloud logging read "resource.type=instance_name" --limit 5 # View logs related with resource named: 'instance_name'
gcloud logging read "resource.type=instance_name AND labels.instance_name='gcelab2'" --limit 5 # View logs related with instance 'gcelab2' in resource 'instance_name'
