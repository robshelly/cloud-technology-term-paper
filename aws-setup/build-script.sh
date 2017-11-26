#!/bin/bash

###############################################
#
# This is the shell script that executes on
# Jenkins as part of the build.
#
# It is not run locally!
#
###############################################


SERVICE_NAME="node-app-service"
IMAGE_VERSION="v_"${BUILD_NUMBER}
TASK_FAMILY="node-app"
CLUSTER_NAME="node-app-cluster"

# Create a new task definition for this build
sed -e "s;%BUILD_NUMBER%;${BUILD_NUMBER};g" /home/ubuntu/app/node-app.json > node-app-v_${BUILD_NUMBER}.json
AWS_ACCESS_KEY_ID=$KEY_ID AWS_SECRET_ACCESS_KEY=$SECRET_KEY aws ecs --region eu-west-1 register-task-definition --family $TASK_FAMILY --cli-input-json file://node-app-v_${BUILD_NUMBER}.json

# Update the service with the new task definition and desired count
TASK_REVISION=`AWS_ACCESS_KEY_ID=$KEY_ID AWS_SECRET_ACCESS_KEY=$SECRET_KEY aws ecs --region eu-west-1 describe-task-definition --task-definition $TASK_FAMILY | egrep "revision" | tr "/" " " | awk '{print $2}' | sed 's/"$//'`
DESIRED_COUNT=`AWS_ACCESS_KEY_ID=$KEY_ID AWS_SECRET_ACCESS_KEY=$SECRET_KEY aws ecs --region eu-west-1 describe-services --services ${SERVICE_NAME} --cluster $CLUSTER_NAME | egrep -m 1 "desiredCount" | tr "/" " " | awk '{print $2}' | sed 's/,$//'`
if [ ${DESIRED_COUNT} = "0" ]; then
    DESIRED_COUNT="1"
fi

AWS_ACCESS_KEY_ID=$KEY_ID AWS_SECRET_ACCESS_KEY=$SECRET_KEY aws ecs --region eu-west-1 update-service --cluster $CLUSTER_NAME --service ${SERVICE_NAME} --task-definition ${TASK_FAMILY}:${TASK_REVISION} --desired-count ${DESIRED_COUNT}
