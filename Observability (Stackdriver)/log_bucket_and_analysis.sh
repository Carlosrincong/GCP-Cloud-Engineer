
# Check if the cluster has already been created
gcloud container clusters list

# Get the credentials to use kubectl commands
gcloud container clusters get-credentials day2-ops --region placeholder

# Verify that the nodes have been created
kubectl get nodes

# Clone the repository
git clone https://github.com/GoogleCloudPlatform/microservices-demo.git

# Go to the directory
cd microservices-demo

# Intall the app using the YAML file
kubectl apply -f release/kubernetes-manifests.yaml

# Confirm that the pods have already been created
kubectl get pods

# Get the external ip address of the frontend service
export EXTERNAL_IP=$(kubectl get service frontend-external -o jsonpath="{.status.loadBalancer.ingress[0].ip}")
echo $EXTERNAL_IP

# Test the app
curl -o /dev/null -s -w "%{http_code}\n"  http://${EXTERNAL_IP}

# In logging storage console, upgrade the default bucket
# Create a new log bucket to use log analytics and bigquery embedded
# In logs explorer, paste the following query to create a new route that writes data into the previously created bucket
resource.type="k8s_container"


# In the logs explorer, refine the scope selecting scope by storage and search for the new bucket. 
#This is usefull if you want to use only the filtered logs

# In the logs analytics console you can run queries to explore data stored in the bucket
# Example queries:
# The last logs
SELECT
 TIMESTAMP,
 JSON_VALUE(resource.labels.container_name) AS container,
 json_payload
FROM
 `"PROJECT_ID".global.day2ops-log._AllLogs`
WHERE
 severity="ERROR"
 AND json_payload IS NOT NULL
ORDER BY
 1 DESC
LIMIT
 50 

# Get the mina, max, average latency
SELECT
hour,
MIN(took_ms) AS min,
MAX(took_ms) AS max,
AVG(took_ms) AS avg
FROM (
SELECT
  FORMAT_TIMESTAMP("%H", timestamp) AS hour,
  CAST( JSON_VALUE(json_payload,
      '$."http.resp.took_ms"') AS INT64 ) AS took_ms
FROM
  `"PROJECT_ID".global.day2ops-log._AllLogs`
WHERE
  timestamp > TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 24 HOUR)
  AND json_payload IS NOT NULL
  AND SEARCH(labels,
    "frontend")
  AND JSON_VALUE(json_payload.message) = "request complete"
ORDER BY
  took_ms DESC,
  timestamp ASC )
GROUP BY
1
ORDER BY
1

# Get visitors of product page
SELECT
count(*)
FROM
`"PROJECT_ID".global.day2ops-log._AllLogs`
WHERE
text_payload like "GET %/product/L9ECAV7KIM %"
AND
timestamp > TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 1 HOUR)

# 
SELECT
 JSON_VALUE(json_payload.session),
 COUNT(*)
FROM
 `"PROJECT_ID".global.day2ops-log._AllLogs`
WHERE
 JSON_VALUE(json_payload['http.req.method']) = "POST"
 AND JSON_VALUE(json_payload['http.req.path']) = "/cart/checkout"
 AND timestamp > TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 1 HOUR)
GROUP BY
 JSON_VALUE(json_payload.session)

# how many sessions end up with checkout
SELECT
 JSON_VALUE(json_payload.session),
 COUNT(*)
FROM
 `"PROJECT_ID".global.day2ops-log._AllLogs`
WHERE
 JSON_VALUE(json_payload['http.req.method']) = "POST"
 AND JSON_VALUE(json_payload['http.req.path']) = "/cart/checkout"
 AND timestamp > TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 1 HOUR)
GROUP BY
 JSON_VALUE(json_payload.session)
