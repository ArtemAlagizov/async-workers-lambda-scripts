#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

#ping -q -c5 3.13.90.180 > /dev/null
#
#if [ $? -eq 0 ]
#then
#	echo "ok"
#fi

aws ec2 terminate-instances --instance-ids `curl http://169.254.169.254/latest/meta-data/instance-id` --region 'us-east-2'