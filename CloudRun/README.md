
# CLOUD RUN

which is a managed compute platform that runs stateless containers via web requests or Pub sub events
serveless service
It's built on Knative, an open API and runtime environment built on Kubernetes.
It can be fully managed on Google Cloud, on Google Kubernetes engine, or anywhere Knative runs.
You can use Cloud Run to run web applications

Two types:
1. container-based workflow
2. source-based workflow: will deploy source code instead of a container image. Then using Buildpacks an open source project, builds the source and packages the application into a container image

The Cloud Run developer workflow is a straightforward three step process:
1. write your application. This application should start a server that listens for web requests.
2. you build and package your application into a container image.
3. the container image is pushed to artifact registry, where Cloud Run will deploy it.

### Pricing
you only pay for the system resources you use while a container is handling web requests.
The price of container time increases with CPU and memory.