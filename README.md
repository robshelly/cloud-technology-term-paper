# Cloud Technolog Term Paper

This repo contains the script and associated files for setting up the initial infrastructure for the practical element of the term paper.
Also contained is a very basic sample node app which is used as the app to be deployed in the practical element.

## Description of Term Paper

Practical element of term paper involves setting of a Jenkins CI/CD job to build a sample [wep app](https://github.com/awslabs/py-flask-signup-docker) when commits are made to Github and deploy it to ECS.

## Infrastructure

This script will create the following AWS resources:

- An ECS optimized EC2 instance on which the app container will run;
- An ECS cluster within which the instance will be registered;
- A dummy task defintion based on the contained task definition file;
- A service that will eventuall run the task defition.

## Other Repos
- [A fork of the sample web app](https://github.com/robshelly/py-flask-signup-docker)
- [Scripts to create the Jenkins instance on AWS](https://github.com/robshelly/jenkins-on-aws)

## Other Resources

The following tutorial was used as a guide for the practical work:

[Set up a build pipeline with Jenkins and Amazon ECS
](https://aws.amazon.com/blogs/devops/set-up-a-build-pipeline-with-jenkins-and-amazon-ecs/)
