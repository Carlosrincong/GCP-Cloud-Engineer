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