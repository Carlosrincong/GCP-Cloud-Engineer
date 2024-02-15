gcloud init ## Cuando se ejecute desde CLI

gcloud projects create nombre-proyecto ## Crear el proyecto en caso de que no exista
gcloud config set projec nombre-proyecto ## Seleccionar el proyecto

gcloud services enable cloudresourcemanager.googleapis.com ## Habilitar la API

gcloud projects add-iam-policy-binding nombre-proyecto --member="user:EMAIL_ADDRESS" --role=ROLE ### Otorgar permisos a una identidad
# Donde ROLE es un rol predefinido individual
# Donde member puede ser: user, group, serviceAccount, domain. 

gcloud iam service-accounts list ## Devuelve la lista de las cuentas de servicio creadas

## Crea la cuenta de servicio 'SA_NAME@PROJECT_ID.iam.gserviceaccount.com', asi: 
gcloud iam service-accounts create SA_NAME \
    --description="DESCRIPTION" \
    --display-name="DISPLAY_NAME"

## Otorgar permisos a una cuenta de servicio
gcloud projects add-iam-policy-binding nombre-proyecto \
    --member="serviceAccount:SA_NAME@jjh.iam.gserviceaccount.com" \
    --role="ROLE_NAME"

## Otorgar usuario de la cuenta de servicio:
gcloud iam service-accounts add-iam-policy-binding \
    SA_NAME@nombre-proyecto.iam.gserviceaccount.com \
    --member="user:USER_EMAIL" \
    --role="roles/iam.serviceAccountUser"