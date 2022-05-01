#This script the automation project for check the apache installed, services running and tar the huge log file size of type access.log and error.log with datetime stamp. copy the tar file to a another location and move to the AWS S3 bucket#

#!/bin/bash

s3_bucket=upgrad-siddheswaran
myname=siddheswaran
timestamp=$(date '+%d%m%Y-%H%M%S')

sudo apt update -y

sudo apt install apache2


#service=apache2.service

service=apache2

if (( $(ps -ef | grep -v grep | grep $service | wc -l) > 0 ))
then
echo "$service is running!!!"
else
/etc/init.d/$service start
fi

cd /var/log/apache2/
tar -czvf ${myname}-httpd-logs-${timestamp}.tar access.log error.log

cp ${myname}-httpd-logs-${timestamp}.tar /tmp/

cd /tmp

# pushing files to s3 bucket

echo "Files are trying to copy to my s3 bucket"
aws s3 cp ${myname}-httpd-logs-${timestamp}.tar s3://upgrad-siddheswaran/

echo "Files are pushed to s3 buket successfully"

#This set of code checking for apache html file exists or not"
echo " Checking for apache inventory html file existance"

FILE=/var/www/html/inventory.html
if [ -f "$FILE" ]; then
    echo "$FILE exists."
else
    echo "$FILE does not exist.Please create manually"
fi

#THis set of lines is to test whether the cron batch files exists or not"

echo " checking cron batch file exits or not"
if [ ! -f /etc/cron.d/automation.sh ]
then
    echo "File does not exist in Bash"
else
    echo "File found. and root has permission to exists"
fi


