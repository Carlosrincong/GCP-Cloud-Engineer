# IAM

Al asignar una politica se debe asociar una identidad/principal a un grupo. Y a dicho grupo asignarle un rol. Donde un rol, es un conjunto logico de permisos. Un permiso contiene operaciones que se pueden realizar sobre un recurso (service.resource.verb). La politica mapea quien tiene acceso aque, y cuando un principal intenta usar un recursos AIM verifica la politica antes de garantizar el acceso. 

El principal puede ser: Google workspace o Dominio Cloud identity (domain), Grupo de google (group), Cuenta de Google (user) y Cuenta de servicio (serviceAccount). Donde dominio Cloud identity es similar a un dominio workspace, pero sin acceso a las aplicaciones empresariales. Identidad federada: Federación con Cloud Identity/ Google Workspace o Federación de de Workforce Identity, para que identidades externas puedan acceder a Google Cloud con credenciales externas.

## Federación de Workforce Identity
Es la preferida para usar proveedor de identidad externo (IdP). No requiere la sincronizacion de Identidades con el servicio Google Cloud Directory Sync (GCDS). 

## Identidades para cargas de trabajo
Workload identity en GKE, Cuenta de servicio y Clave de cuenta de servicio. 

## Best practices:

- Emplearla cuando se requiere que una aplicacion funcione sin interaccion de un usuario.
- Que dicha cuenta solo tenga permisos para el alcance de lo que la aplicacion requiere para funcionar. 
- Emplearla para autenticar identidades con la aplicacion o ante Google Cloud. 
- Usar el prefijo del nombre de la cuenta de servicio para identificar su uso.
- Crear cuentas de servicion de unico proposito
- Rotar frecuentemente las claves de las cuentas de servicio
- Deshabilitar cuentas de servicio que no se usan
- Antes de borrar una cuenta de servicio, deshabilitarla
- Evita usar grupos para otorgar a las cuentas de servicio acceso a los recursos.
- Inhabilita el otorgamiento automático de IAM para las cuentas de servicio predeterminadas y asi no obtendran el rol de editor. 
De este modo se le debe asignar manualmente los permisos a estas cuentas de servicio 
- Evita usar la delegación de todo el dominio 
- Usa la API de Credentials de IAM para la elevación de privilegios temporales
- Estadísticas de movimiento lateral para rastrear cuenta del proyecto A que se hace pasar por cuenta del proyecto B y asi sucesivamente
- Evita permitir que los usuarios actúen en nombre de las cuentas de servicio que tienen más privilegios que ellos. A traves de servicios a los que estos tienen acceso y a cuentas de servicio predeterminadas
- No permitas que los usuarios creen o suban claves de cuenta de servicio.
- Evitar que usuarios puedan elevar sus privilegios con cuentas de servicio, claves de cuentas de servicio o cuentas de servicio predeterminadas.
- Riesgos cuenta de servicio: elevacion de privilegios y falsificacion de identidad.
- Evita permitir que las canalizaciones de implementación administren los controles de seguridad o modifique las políticas.
- Usa estadísticas y métricas para identificar claves de cuenta de servicio sin usar.
- Rota las claves de la cuenta de servicio para reducir el riesgo de seguridad causado por claves filtradas.

https://cloud.google.com/iam/docs/migrate-from-service-account-keys?hl=es-419

# To know
- Custom roles can only be applied to either the project level or organization level.
- A service account is also a resource. This means that Alice can have the editor role on a service account, and Bob can have the viewer role.
- When a user with a G Suite or Cloud Identity Account creates a GCP project an organization resource is automatically provisioned for them
- You cannot use IAM to create or manage your users or groups. Instead, you can use Cloud Identity or Workspace to create and manage users.
- Recommender identifies excess permissions using policy insights.
- With deny policies, you can define deny rules that prevent certain principals from using certain permissions, regardless of the roles they're granted.  When a principal is denied a permission, they can't do anything that requires that permission, regardless of the IAM roles they've been granted.
- Using Google Cloud Directory Sync, your administrators can log in and manage Google Cloud resources using the same usernames and passwords they already use.  This tool synchronizes users and groups from your existing Active Directory or LDAP system with the users and groups in your Cloud Identity domain.
- SSO (single sing-on authentication)
- Workspace or Cloud Identity super admin is responsible of:
    1. assign organization admin role
    2. Recovery issues
    3. Life cicle of Organization resource and its users

- Organization admin is responsible of:
    1. Define policies
    2. Define structure of hierarchy
    3. Delegate responsabilities of networking, billing and hierarchy with roles


### Service Accounts
There are three types of service accounts: user-created or custom, built-in, and Google APIs service accounts.
By default, all projects come with the built-in Compute Engine default service account and it is automatically granted the Editor role on the project. All projects come with a Google Cloud APIs service account

Access scopes are actually the legacy method of specifying permissions for your VM. (By using The default service account)
For user-created service accounts, use IAM roles instead to specify permissions for your VM.

Yo can use a service account to grant access to services. And use it as a service to decide who can use it using ServiceAccountUser. 

There are two types of service account keys. Google-managed service accounts: Google automatically manages the keys for service accounts. User-managed service accounts: if you want to be able to use service accounts outside of Google Cloud, or want a different rotation period.

Consider the other alternatives to service acocount kesy, such as short-lived service account credentials (tokens), or service account impersonation.
