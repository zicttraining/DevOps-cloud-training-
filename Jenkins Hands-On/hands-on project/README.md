# Project Name

## Overview
This project demonstrates how to set up a Jenkins pipeline to test, build, and deploy a Node.js application to an EC2 instance.

## Prerequisites
- Jenkins installed and configured
- GitHub repository for the project
- EC2 instance for deployment
- Node.js installed on the Jenkins server and the EC2 instance

## Setup & Configuration
1. **Jenkins Installation**: Install and configure Jenkins on your server. Refer to the [Jenkins documentation](https://www.jenkins.io/doc/book/installing/) for instructions.

2. **GitHub Repository**: Create a GitHub repository for your project and push your Node.js application code to it.

3. **EC2 Instance**: Set up an EC2 instance on AWS for deployment. Ensure that you have SSH access to the instance.

4. **Node.js Installation**: Install Node.js on both the Jenkins server and the EC2 instance. You can download and install Node.js from the [official website](https://nodejs.org/).

5. **Jenkins Pipeline Configuration**: 
   - Configure Jenkins to access your GitHub repository.
   - Create a new Jenkins pipeline job and configure it to use the Jenkinsfile provided in this project.
   - Set up string parameters in the pipeline job for the branch and environment.

6. **GitHub Webhook**: 
   - Configure a webhook on your GitHub repository to trigger the Jenkins pipeline whenever there's a push event on the specified branch.

## Jenkins Pipeline Stages
The Jenkins pipeline consists of the following stages:
1. **Checkout**: Checks out the code from the specified branch in the GitHub repository.
2. **Test**: Runs tests for the Node.js application.
3. **Build**: Builds the application, installing dependencies and generating artifacts.
4. **Deploy to EC2**: Deploys the built application to the EC2 instance, restarting the application if necessary.

## Usage
- Push changes to your GitHub repository to trigger the Jenkins pipeline.
- Monitor the Jenkins job for the status of each stage.
- Access your deployed application on the EC2 instance to verify the deployment.

## Troubleshooting
- If any stage of the pipeline fails, check the Jenkins console output for error messages.
- Ensure that all prerequisites are properly configured and accessible.