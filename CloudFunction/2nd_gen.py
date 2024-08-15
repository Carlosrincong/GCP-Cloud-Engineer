##############
#### HTTP ####
##############

import functions_framework

@functions_framework.http
def hello_http(request):
    """HTTP Cloud Function.
    Args:
        request (flask.Request): The request object.
        <https://flask.palletsprojects.com/en/1.1.x/api/#incoming-request-data>
    Returns:
        The response text, or any set of values that can be turned into a
        Response object using `make_response`
        <https://flask.palletsprojects.com/en/1.1.x/api/#flask.make_response>.
    """
    request_json = request.get_json(silent=True)
    request_args = request.args

    if request_json and 'name' in request_json:
        name = request_json['name']
    elif request_args and 'name' in request_args:
        name = request_args['name']
    else:
        name = 'World'
    return 'Hello {}!'.format(name)

#################
#### STORAGE ####
#################

import functions_framework

# Triggered by a change in a storage bucket
@functions_framework.cloud_event
def hello_gcs(cloud_event):
    data = cloud_event.data

    event_id = cloud_event["id"]
    event_type = cloud_event["type"]

    bucket = data["bucket"]
    name = data["name"]
    metageneration = data["metageneration"]
    timeCreated = data["timeCreated"]
    updated = data["updated"]

    print(f"Event ID: {event_id}")
    print(f"Event type: {event_type}")
    print(f"Bucket: {bucket}")
    print(f"File: {name}")
    print(f"Metageneration: {metageneration}")
    print(f"Created: {timeCreated}")
    print(f"Updated: {updated}")

#################
#### PUB/SUB ####
#################

import base64
import functions_framework

# Triggered from a message on a Cloud Pub/Sub topic.
@functions_framework.cloud_event
def hello_pubsub(cloud_event):
    # Print out the data from Pub/Sub, to prove that it worked
    print(base64.b64decode(cloud_event.data["message"]["data"]))

###################
#### FIRESTORE ####
###################

from cloudevents.http import CloudEvent
import functions_framework
from google.events.cloud import firestore


@functions_framework.cloud_event
def hello_firestore(cloud_event: CloudEvent) -> None:
    """Triggers by a change to a Firestore document.
    Args:
        cloud_event: cloud event with information on the firestore event trigger
    """
    firestore_payload = firestore.DocumentEventData()
    firestore_payload._pb.ParseFromString(cloud_event.data)

    print(f"Function triggered by change to: {cloud_event['source']}")

    print("\nOld value:")
    print(firestore_payload.old_value)

    print("\nNew value:")
    print(firestore_payload.value)

###############
#### OTHER ####
###############

import functions_framework

# CloudEvent function to be triggered by an Eventarc Cloud Audit Logging trigger
# Note: this is NOT designed for second-party (Cloud Audit Logs -> Pub/Sub) triggers!
@functions_framework.cloud_event
def hello_auditlog(cloudevent):
    # Print out the CloudEvent's (required) `type` property
    # See https://github.com/cloudevents/spec/blob/v1.0.1/spec.md#type
    print(f"Event type: {cloudevent['type']}")

    # Print out the CloudEvent's (optional) `subject` property
    # See https://github.com/cloudevents/spec/blob/v1.0.1/spec.md#subject
    if 'subject' in cloudevent:
        # CloudEvent objects don't support `get` operations.
        # Use the `in` operator to verify `subject` is present.
        print(f"Subject: {cloudevent['subject']}")

    # Print out details from the `protoPayload`
    # This field encapsulates a Cloud Audit Logging entry
    # See https://cloud.google.com/logging/docs/audit#audit_log_entry_structure

    payload = cloudevent.data.get("protoPayload")
    if payload:
        print(f"API method: {payload.get('methodName')}")
        print(f"Resource name: {payload.get('resourceName')}")
        print(f"Principal: {payload.get('authenticationInfo', dict()).get('principalEmail')}")
