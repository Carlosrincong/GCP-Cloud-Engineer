gcloud init ## Cuando se ejecute desde CLI

gcloud projects create nombre-proyecto ## Crear el proyecto en caso de que no exista
gcloud config set projec nombre-proyecto ## Seleccionar el proyecto

gcloud services enable cloudresourcemanager.googleapis.com ## Habilitar la API

gcloud projects add-iam-policy-binding nombre-proyecto --member="user:EMAIL_ADDRESS" --role=ROLE ### Otorgar permisos a una identidad
# Donde ROLE es un rol predefinido individual
# Donde member puede ser: user, group, serviceAccount, domain. 

