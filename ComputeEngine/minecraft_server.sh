
export PERSISTENT_DiSK=google-minecraft-disk
echo PERSISTENT_DISK

# Create a virtual machine with network tag

# SSH on VM
# create the mount point for the data disk
sudo mkdir -p /home/minecraft

# To format the persistent disk
sudo mkfs.ext4 -F -E lazy_itable_init=0,\
    lazy_journal_init=0,discard \
    /dev/disk/by-id/$PERSISTENT_DiSK

# adding persistent disk to the mount point
sudo mount -o discard,defaults /dev/disk/by-id/$PERSISTENT_DiSK /home/minecraft

# Update the Debian repositories, to get up-to-date with the security and software updates
sudo apt-get update

# Install JRE or Java Runtime Enviroment, Which is usefull to run Java applications.
sudo apt-get install -y default-jre-headless

# Install wget on persistent disk
# Change directory
cd /home/minecraft 
# Install wget
sudo apt-get install wget

# To download the current Minecraft server JAR
sudo wget https://launcher.mojang.com/v1/objects/d0d0fe2b1dc6ab4c65554cb734270872b72dadd6/server.jar

# Initialize the minecraft server
sudo java -Xmx1024M -Xms1024M -jar server.jar nogui # this give us an error, because we still don´t agree the EULA

# To agree the EULA to run the server
sudo ls -l # Get the list of files
sudo nano eula.txt # Edit de file to agree the EAULA
# Change the last line of the file from eula=false to eula=true
# CTRL + O, ENTER (save), CTRL + X (exit)


# Now if we initialize the minecraft server it´s going to be attached to the life of SSH session
# To solve this, you can install screen
# Screen allows you to create session in the background, even though you close your user session. 
# Useful to keep live persistent sessions

# To install screen
sudo apt-get install -y screen

# To start the minecraft server using screen
sudo screen -S mcs java -Xmx1024M -Xms1024M -jar server.jar nogui # this step give us a port to access the server
# With this port we can create firewall rules to enable traffic to that port

# To Detach from screen session: # CTRL + A, CTRL + D
# To reattach the terminal
sudo screen -r mcs

# Define firewall rules using VM tags, to allow the traffic by specifying the tag in firewall rule configuration

# Get the status in the following link https://mcsrvstat.us/ using the external IP address

# Schedule regular backups:
# Create a cloud storage bucket on Cloud Shell
export BUCKET_NAME=bucket-name
echo $BUCKET_NAME

gcloud storage buckets create gs://$BUCKET_NAME-minecraft-backup

# In SSH Terminal of VM, create backup script
cd /home/minecraft
sudo nano /home/minecraft/backup.sh
# ------------------------
#!/bin/bash
screen -r mcs -X stuff '/save-all\n/save-off\n'
/usr/bin/gcloud storage cp -R ${BASH_SOURCE%/*}/world gs://${BUCKET_NAME}-minecraft-backup/$(date "+%Y%m%d-%H%M%S")-world
screen -r mcs -X stuff '/save-on\n'
# -------------------------- CTRL + O, ENTER, CTRL + X

# To verify whether the file is an executable
sudo chmod 755 /home/minecraft/backup.sh

# Run the backup script
. /home/minecraft/backup.sh

# Schedule the backup 
# to open nano:
cd /home/minecraft
sudo crontab -e # Then select the file: /bin/nano 
# At the bottom of the file paste:
#----------------------------------
0 */4 * * * /home/minecraft/backup.sh # to run backups every 4 hours
#----------------------------------
# CTRL + O, ENTER, CTRL + X

# In cloud shell, SSH ans type this to stop screen
sudo screen -r -X stuff '/stop\n'

# Set startup and shutdown scripts
# Define key-value in virtual machine metadata 
# key / value:
# startup-script-url: https://storage.googleapis.com/cloud-training/archinfra/mcserver/startup.sh
# shutdown-script-url: https://storage.googleapis.com/cloud-training/archinfra/mcserver/shutdown.sh
# When the vm startup or shutdown will use these scripts

