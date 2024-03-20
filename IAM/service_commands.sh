gcloud init ## Cuando se ejecute desde CLI

gcloud projects create nombre-proyecto ## Crear el proyecto en caso de que no exista
gcloud config set projec nombre-proyecto ## Seleccionar el proyecto

gcloud services enable cloudresourcemanager.googleapis.com ## Habilitar la API

gcloud projects add-iam-policy-binding nombre-proyecto --member="user:EMAIL_ADDRESS" --role=ROLE ### Otorgar permisos a una identidad
# Donde ROLE es un rol predefinido individual
# Donde member puede ser: user, group, serviceAccount, domain. 

## -------- Roles --------

# Para obtener mas detalle sobre un rol predefinido
gcloud iam roles describe roles/accessapproval.invalidator

# Lista de roles que se pueden otorgar para un servicio:
gcloud iam list-grantable-roles full-resource-name

# Lista de permisos que se pueden otorgar para un servicio:
gcloud iam list-testable-permissions FULL_RESOURCE_NAME \
    --filter="customRolesSupportLevel!=NOT_SUPPORTED"

## -------- Roles personalizados  -----------

# Crear un rol personalizado YAML
# A nivel de organizacion
gcloud iam roles create ROLE_ID --organization=ORGANIZATION_ID \
    --file=YAML_FILE_PATH.yaml
# A nivel de proyecto:
gcloud iam roles create ROLE_ID --project=nombre-proyecto \
    --file=YAML_FILE_PATH
# Crear el rol presupone crear un archivo YAML que contiene la informacion del rol personalizado:
[
title: "My Company Admin"
description: "My custom role description."
stage: "ALPHA"
includedPermissions:
- iam.roles.get
- iam.roles.list
]

# Crear un rol personalizado con marcas:
# A nivel de organizacion
gcloud iam roles create ROLE_ID--organization=ORGANIZATION_ID \
    --title=ROLE_TITLE --description=ROLE_DESCRIPTION \
    --permissions="PERMISSIONS_LIST" --stage=LAUNCH_STAGE
# A nivel de proyecto:
gcloud iam roles create ROLE_ID --project=nombre-proyecto \
    --title=ROLE_TITLE --description=ROLE_DESCRIPTION \
    --permissions="PERMISSIONS_LIST" --stage=LAUNCH_STAGE

# Donde PERMISSIONS_LIST es la lista de permisos separados por coma (,)

# Actualizar rol a nivel de organizacion
gcloud iam roles update ROLE_ID --organization=ORGANIZATION_ID \
    --title=ROLE_TITLE --description=ROLE_DESCRIPTION \
    --stage=LAUNCH_STAGE

# Actualizar rol a nivel de proyecto
gcloud iam roles update ROLE_ID --project=nombre-proyecto \
    --title=ROLE_TITLE --description=ROLE_DESCRIPTION \
    --stage=LAUNCH_STAGE

# Deshabilitar rol personalizado a nivel de organizacion
gcloud iam roles update ROLE_ID --organization=ORGANIZATION_ID \
    --stage=DISABLED
# Deshabilitar rol personalizado a nivel de proyecto
gcloud iam roles update ROLE_ID --project=nombre-proyecto \
    --stage=DISABLED

# Enlistar roles a nivel de organizacion
gcloud iam roles list --organization=ORGANIZATION_ID
# Enlistar roles a nivel de proyecto
gcloud iam roles list --project=nombre-proyecto

# Borrar roles a nivel de organizacion
gcloud iam roles delete ROLE_ID --organization=ORGANIZATION_ID
# Borrar roles a nivel de proyecto
gcloud iam roles delete ROLE_ID --project=nombre-proyecto

# Recuperar roles a nivel de organizacion
gcloud iam roles undelete ROLE_ID --organization=ORGANIZATION_ID
# Recuperar roles a nivel de proyecto
gcloud iam roles undelete ROLE_ID --project=nombre-proyecto

## -------- Cuentas de servicio -----------
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

# Habilitar y deshabilitar cuentas de servicio:
gcloud iam service-accounts disable SA_NAME@nombre-proyecto.iam.gserviceaccount.com
gcloud iam service-accounts enable SA_NAME@nombre-proyecto.iam.gserviceaccount.com

# Borrar cuenta de servicio
gcloud iam service-accounts delete SA_NAME@nombre-proyecto.iam.gserviceaccount.com

## --------- Claves de cuenta de servicio ------------
## Crear clave de cuenta de servicio:
gcloud iam service-accounts keys create KEY_FILE \
    --iam-account=SA_NAME@nombre-proyecto.iam.gserviceaccount.com
# donde KEY_FILE es la ruta del archivo json en el que se almacena la clave privada

## Borrar clave de cuenta de servicio:
gcloud iam service-accounts keys delete KEY_ID \
    --iam-account=SA_NAME@nombre-proyecto.iam.gserviceaccount.com
# Donde KEY_ID es el id de la clave.
## Para saber el id de la clave se puede enlistar las claves de una cuenta de servicio, asi:
gcloud iam service-accounts keys list \
    --iam-account=SA_NAME@nombre-proyecto.iam.gserviceaccount.com

# Habilitar y deshabilitar claves de cuenta de servicio:
gcloud iam service-accounts keys disable KEY_ID \
    --iam-account=SA_NAME@nombre-proyecto.iam.gserviceaccount.com \
    --project=nombre-proyecto
gcloud iam service-accounts keys enable KEY_ID \
    --iam-account=SA_NAME@nombre-proyecto.iam.gserviceaccount.com\
    --project=nombre-proyecto

# Use key service account, with credentials.json file:
gcloud auth activate-service-account --key-file credentials.json