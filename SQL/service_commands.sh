# Set project id
export PROJECT_ID=$(gcloud config get-value project)
gcloud config set project $PROJECT_ID

# to setup auth without opening up a browser.
gcloud auth login --no-launch-browser

# connect to SQL instance
export DB=db-name
gcloud sql connect $DB --user=root --quiet

# the you can use SQl
# -- sql
CREATE DATABASE bike; # To create a Database
# -- sql
USE bike;
CREATE TABLE london1 (start_station_name VARCHAR(255), num INT); # To create a table
# -- sql
USE bike;
CREATE TABLE london2 (end_station_name VARCHAR(255), num INT);
# -- sql
SELECT * FROM london1;
SELECT * FROM london2;