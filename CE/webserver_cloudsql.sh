
# image: Debian GNU/Linux 11 (bullseye)
# Firewall rule: Allow HTTP traffic
## Startup script of VM
apt-get update
apt-get install apache2 php php-mysql -y
service apache2 restart

## SSH VM and then:

cd /var/www/html

# define a php text file in the directory:
sudo nano index.php

# with the text editor type:

<html>
<head><title>Welcome to my excellent blog</title></head>
<body>
<h1>Welcome to my excellent blog</h1>
<?php
 $dbserver = "CLOUDSQLIP";
$dbuser = "blogdbuser";
$dbpassword = "DBPASSWORD";
// In a production blog, we would not store the MySQL
// password in the document root. Instead, we would store it in a
// configuration file elsewhere on the web server VM instance.

$conn = new mysqli($dbserver, $dbuser, $dbpassword);

if (mysqli_connect_error()) {
        echo ("Database connection failed: " . mysqli_connect_error());
} else {
        echo ("Database connection succeeded.");
}
?>
</body></html>

# Restart the web server:
sudo service apache2 restart

# On browser tab paste the public external IP address of VM, followe by /index.php:
35.192.208.2/index.php

# Or instead use the storage (index.php):
 <img src='https://storage.googleapis.com/qwiklabs-gcp-0005e186fa559a09/my-excellent-blog.png'>

