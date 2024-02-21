
# Create a topic
gcloud pubsub topics create myTopic

# To view the list of topics
gcloud pubsub topics list

# Create a subscription
gcloud  pubsub subscriptions create --topic myTopic mySub

# To view Topic´s subscription list
gcloud pubsub topics list-subscriptions myTopic

# List of messages of a Subcription
gcloud pubsub subscriptions pull mySub --auto-ack 
# all 3 last messages
gcloud pubsub subscriptions pull mySub --auto-ack --limit=3

# Publish a message to a topic
gcloud pubsub topics publish myTopic --message "Hello"

# Delete a subscription
gcloud pubsub subscriptions delete mySub

# Delete a topic
gcloud pubsub topics delete MyTopic