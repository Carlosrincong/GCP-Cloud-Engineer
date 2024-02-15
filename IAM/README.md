# IAM

Al asignar una politica se debe asociar una identidad/principal a un grupo. Y a dicho grupo asignarle un rol. Donde un rol, es un conjunto logico de permisos. Un permiso contiene operaciones que se pueden realizar sobre un recurso (service.resource.verb). La politica mapea quien tiene acceso aque, y cuando un principal intenta usar un recursos AIM verifica la politica antes de garantizar el acceso. 

El principal puede ser: Google workspace o Dominio Cloud identity (domain), Grupo de google (group), Cuenta de Google (user) y Cuenta de servicio (serviceAccount). Donde dominio Cloud identity es similar a un dominio workspace, pero sin acceso a las aplicaciones empresariales. Identidad federada: Federación con Cloud Identity/ Google Workspace o Federación de de Workforce Identity, para que identidades externas puedan acceder a Google Cloud con credenciales externas.

## Federación de Workforce Identity
Es la preferida para usar proveedor de identidad externo (IdP). No requiere la sincronizacion de Identidades con el servicio Google Cloud Directory Sync (GCDS). 

## Identidades para cargas de trabajo
Workload identity en GKE, Cuenta de servicio y Clave de cuenta de servicio. 