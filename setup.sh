#!/bin/bash
# Create a cluster, no instance created, just an mpty named cluster
aws ecs create-cluster --cluster-name $CLUSTER_NAME

# Launch ECS Optimized instance
aws ec2 run-instances --image-id $AMI_ID --count 1 --instance-type t2.micro --key-name $KEY_NAME --security-groups $HTTPSSH_SEC_GROUP --iam-instance-profile Name=$ECS_INSTANCE_ROLE --user-data file://files/user-data.txt --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value='$INSTANCE_NAME'}]'

# Create dummy task definition
sed -e "s;%BUILD_NUMBER%;0;g" ./flask-signup.json > ./flask-signup-v_0.json
aws ecs register-task-definition --cli-input-json file://flask-signup-v_0.json

# Launch the service
aws ecs create-service --cluster default --service-name flask-signup-service --task-definition flask-signup --role $ECS_SERVICE_ROLE --desired-count 0