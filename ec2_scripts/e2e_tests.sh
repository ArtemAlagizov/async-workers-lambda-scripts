#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

{
sudo yum install -y git
# git clone e2e tests

git clone https://github.com/ArtemAlagizov/async-workers-lambda-scripts.git
# execute e2e tests
# send logs and report through sns service (/var/log/user-data.log)
cd async-workers-lambda-scripts
cd messages

#aws sns publish --message "e2e tests were successful" --phone-number +316XXXXXXXX --region 'us-east-1'
aws ses send-email --from alagizov@gmail.com --destination file://destination.json --message file://success_message.json --region 'us-east-1'
# if tests are succesful => trigger lambda to tag docker images and upload dem images to docker hub
## aws lambda invoke --function-name ReleaseVersionUpdateFunction --invocation-type Event --payload "[JSON string here]"

} || {
# log failure
echo "inside catch"
}

aws ec2 terminate-instances --instance-ids `curl http://169.254.169.254/latest/meta-data/instance-id` --region 'us-east-2'