
# Basics
- A topic is a shared string that allows applications to connect with one another through a common thread.
- Publishers push (or publish) a message to a Cloud Pub/Sub topic.
- Subscribers make a "subscription" to a topic where they will either pull messages from the subscription or configure webhooks for push subscriptions. Every subscriber must acknowledge each message within a configurable window of time.

Pub/Sub is commonly used by developers in implementing asynchronous workflows, distributing event notifications, and streaming data from various processes or devices.