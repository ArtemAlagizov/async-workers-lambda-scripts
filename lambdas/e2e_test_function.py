from git import Repo
import boto3

REGION = 'us-east-2'  # region to launch instance in
AMI = 'ami-0b00e7f461c40ed19 amzn-ami-hvm-2018.03.0.20190514-x86_64-gp2'  # list of amis https://aws.amazon.com/amazon-linux-ami/
INSTANCE_TYPE = 't2.micro'  # instance type to launch
KEY_NAME = 'aws_keypair_raiden'
IAM_INSTANCE_PROFILE = {'Arn': 'arn:aws:iam::650732200008:role/service-role/e2e_tests-role-23indkh6'},
SECURITY_GROUP_IDS = ['sg-0ab4a96e82d467408']

ec2 = boto3.client('ec2', region_name=REGION)


def lambda_handler(event, context):
    project_name = event['github_project']
    org = event['github_org']
    git_url = "https://github.com/%s/%s" % (org, project_name)
    print("Downloading repo from %s............" % git_url)
    repo = Repo.clone_from(git_url, '/tmp/%s' % project_name)
    print("Repo %s" % repo)

    ec2.request_spot_instances(
        SpotPrice='0.1',
        InstanceCount=1,
        Type='one-time',
        LaunchSpecification={
            'ImageId': AMI,
            'KeyName': KEY_NAME,
            'InstanceType': INSTANCE_TYPE,
            'UserData': '<base64 encoded script goes here>',
            'IamInstanceProfile': IAM_INSTANCE_PROFILE,
            'SecurityGroupIds': SECURITY_GROUP_IDS
        }
    )
