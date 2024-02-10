API orientada a Recursos prioriza los recursos sobre los metodos (funcionalidades)
Métodos REST a usar en los recursos, son: List , Get , Create , Update y Delet

Errores:

200	OK	No hay errores.
400	INVALID_ARGUMENT	El cliente especificó un argumento no válido. Verifica el mensaje de error y los detalles de errores para obtener más información.
400	FAILED_PRECONDITION	La solicitud no se puede ejecutar en el estado actual del sistema, como borrar un directorio que no esté vacío.
400	OUT_OF_RANGE	El cliente especificó un rango no válido.
401	UNAUTHENTICATED	La solicitud no se autenticó debido a que el token de OAuth no es válido, falta o se venció.
403	PERMISSION_DENIED	El cliente no cuenta con los permisos necesarios. Esto puede suceder porque el token de OAuth no tiene los alcances correctos, el cliente no tiene permiso o la API no se habilitó.
404	NOT_FOUND	No se encontró ningún recurso especificado.
409	ABORTED	Conflicto de simultaneidad, como conflicto del proceso de lectura, modificación y escritura.
409	ALREADY_EXISTS	El recurso que el cliente intentó crear ya existe.
429	RESOURCE_EXHAUSTED	Sin cuota de recursos o a punto de alcanzar el límite de frecuencia. Para obtener más información, el cliente debe buscar el detalle de error google.rpc.QuotaFailure.
499	CANCELLED	El cliente canceló la solicitud.
500	DATA_LOSS	Daño o pérdida de datos no recuperable. El cliente debe informar el error al usuario.
500	UNKNOWN	Error de servidor desconocido. Por lo general, un error de servidor.
500	INTERNAL	Error del servidor interno Por lo general, un error de servidor.
501	NOT_IMPLEMENTED	El servidor no implementó el método de API.
502	No disponible	Se produjo un error de red antes de establecer conexión con el servidor. Por lo general, es una interrupción de la red o una configuración incorrecta.
503	UNAVAILABLE	Servicio no disponible. Por lo general, el servidor no está en funcionamiento.
504	DEADLINE_EXCEEDED	Se excedió el plazo de la solicitud. Esto ocurrirá solo si el emisor establece una fecha límite más corta que la fecha límite predeterminada del método (es decir, la fecha límite solicitada no es suficiente para que el servidor procese la solicitud) y la solicitud no finalizó dentro de la fecha límite.