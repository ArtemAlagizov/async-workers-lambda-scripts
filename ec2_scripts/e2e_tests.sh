#!/bin/sh

ping -q -c5 3.13.80.190 > /dev/null

if [ $? -eq 0 ]
then
	echo "ok"
fi

aws ec2 terminate-instance --instance-ids `curl http://169.254.169.254/latest/meta-data/instance-id`