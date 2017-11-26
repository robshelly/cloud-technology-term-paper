```bash
############################
# Commands for Initial Setup
############################


# Create a cluster, no instance created, just an mpty named cluster
aws ecs create-cluster --cluster-name $CLUSTER_NAME

# Launch ECS Optimized instance
aws ec2 run-instances --image-id $AMI_ID --count 1 --instance-type t2.micro --key-name $KEY_NAME --security-groups $HTTPSSH_SEC_GROUP $HTTP_GITHUB --iam-instance-profile Name=$ECS_INSTANCE_ROLE --user-data file://user-data --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value='$INSTANCE_NAME'}]'

# Create dummy task definition
sed -e "s;%BUILD_NUMBER%;0;g" ./node-app.json > ./node-app-v_0.json
aws ecs register-task-definition --cli-input-json file://node-app-v_0.json

# Launch the service
aws ecs create-service --cluster $CLUSTER_NAME --service-name node-app-service --task-definition node-app --desired-count 0


```