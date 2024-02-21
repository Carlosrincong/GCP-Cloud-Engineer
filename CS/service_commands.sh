
# Create bucket
gcloud storage buckets create gs://bucket-name --location=us-east1
gsutil mb gs://bucket-name

# Upload files to bucket
gsutil cp ada.jpg gs://bucket-name

# Download file from bucket to cloud shell
gsutil cp -r gs:///bucket-name/file_to_download.jpg .

# Copy file into a folder
gsutil cp gs://bucket-name/file_to_copy.jpg gs://bucket-name/destination-folder/

# List of files in bucket
gsutil ls gs://bucket-name

# Get metadata of a file
gsutil ls -l gs://bucket-name/file_name.jpg

# Grant public access
gsutil acl ch -u AllUsers:R gs://bucket-name/file_name.jpg
# Remove public access
gsutil acl ch -d AllUsers gs://YOUR-BUCKET-NAME/ada.jpg

# Delete files of bucket
gsutil rm gs://bucket-name/file_name.jpg

# Delete bucket
gcloud storage rm --recursive gs://bucket-name

