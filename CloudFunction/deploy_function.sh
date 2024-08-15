
# Clone the repository
git clone https://github.com/antonitz/google-cloud-associate-cloud-engineer.git
cd ~
cd google-cloud-associate-cloud-engineer/11-Serverless-Services/02_you-called
ls

# Deploy the function
gcloud functions deploy you_called --runtime python38 --trigger-http --allow-unauthenticated