
# Clone the repository 
git clone https://github.com/antonitz/google-cloud-associate-cloud-engineer.git

# Go to the directory
cd google-cloud-associate-cloud-engineer/11-Serverless-Services/01_serverless-bowties
ls
cd sitev1
edit app.yaml

# Deploy the app
gcloud app deploy --version 1
15
Y

# Deploy a new version
cd ..
ls
cd sitev1

gcloud app deploy --version 2