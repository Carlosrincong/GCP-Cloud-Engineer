# Set enviroment variable:
export $bucket_name=bucket-name
echo $bucket_name

# Create bucket
gcloud storage buckets create gs://$bucket_name --location=us-east1
gsutil mb gs://$bucket_name

# Upload files to bucket
gsutil cp ada.jpg gs://$bucket_name
gcloud storage cp setup.html gs://$bucket_name/

# Download file from bucket to cloud shell
gsutil cp -r gs://$bucket_name/file_to_download.jpg .
gcloud storage cp gs://$bucket_name/setup.html setup.html
gsutil cp gs://$bucket_name/setup* ./

# Copy file into a folder of bucket
gsutil cp gs://$bucket_name/file_to_copy.jpg gs://$bucket_name/destination-folder/

# List of files in bucket
gsutil ls gs://$bucket_name

# Get metadata of a file
gsutil ls -l gs://$bucket_name/file_name.jpg

# Grant public access
gsutil acl ch -u AllUsers:R gs://$bucket_name/file_name.jpg
gsutil iam ch allUsers:objectViewer gs://$bucket_name

# Remove public access
gsutil acl ch -d AllUsers gs://YOUR-$bucket_name/ada.jpg

# Delete files of bucket
gsutil rm gs://$bucket_name/file_name.jpg

# Delete bucket
gcloud storage rm --recursive gs://$bucket_name

############################
## ACL (Access control list)
############################

gsutil acl get gs://$bucket_name/setup.html  > acl.txt # create file with ACL for setup.html
cat acl.txt # view file with ACL

gsutil acl set private gs://$bucket_name/setup.html # Define private access in ACL for setup.html
gsutil acl get gs://$bucket_name/setup.html  > acl2.txt # Create file to verify the access
cat acl2.txt # view file

gsutil acl ch -u AllUsers:R gs://$bucket_name/setup.html # Update to public access in ACL for setup.html
gsutil acl get gs://$bucket_name/setup.html  > acl3.txt # Create file to verify the access
cat acl3.txt # View file

##########################################
# CSEK (Customer-supplied encryption keys)
##########################################

# Create a key using python
python3 -c 'import base64; import os; print(base64.encodebytes(os.urandom(32)))'

# Edit .boto file
nano .boto
# look up and uncomment "encryption_key=" and set key created
#---------------------
encryption_key=key
#------------------
# To rotate a keys is necessary to decrypt using the same key in the line: decryption_key=key
# Then generate a new key and assing it as encryption_key=key
# Its import to do it step by step by comment and uncomment as needed

###################
# Lifecycle policy
##################

gsutil lifecycle get gs://$bucket_name # get current lifecycle policy

# Create a file with lifecycle confuguration:
nano life.json
# with this inside:
## -----------------------
{
  "rule":
  [
    {
      "action": {"type": "Delete"},
      "condition": {"age": 31}
    }
  ]
}
## ----------------------
# use the file to set lifecycle policy
gsutil lifecycle set life.json gs://$bucket_name

# finally, verify the policy:
gsutil lifecycle get gs://$bucket_name

############
# Versioning
############

#  get status of versioning for the bucket
gsutil versioning get gs://$bucket_name

# enable versioning for the bucket
gsutil versioning set on gs://$bucket_name

# Copy file as a new version:
gcloud storage cp -v setup.html gs://$bucket_name

# list of the all versions of the file:
gcloud storage ls -a gs://$bucket_name/setup.html

# Download a version:
export $version_name=entire_link/file_name#55546456484
echo $version_name

gcloud storage cp $VERSION_NAME version_recovered.txt

