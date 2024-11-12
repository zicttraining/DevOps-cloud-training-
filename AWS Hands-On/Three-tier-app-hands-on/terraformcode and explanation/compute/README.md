Explanation for README

Security Group:

A shared security group is created for both the EC2 web server and Lambda function.
Ingress Rule: Allows HTTP traffic on port 80 from any IP, enabling the web server to handle public HTTP requests.
Egress Rule: Allows all outbound traffic, so both the web server and Lambda can access external resources, such as databases or APIs.

EC2 Instance as Web Server:

An EC2 instance is configured as a web server with Apache installed, serving static HTTP content.
AMI ID: The ami value should be updated to a valid AMI ID for the region (e.g., an Amazon Linux 2 AMI).
Instance Type: t3.micro is used for cost-effective testing and lightweight applications.
User Data Script: This script installs Apache, enables the service to start on boot, and creates a basic HTML file at /var/www/html/index.html for demonstration.

Lambda Function as Application Server:

The Lambda function is set up to handle application logic, decoupled from the web server.
Runtime and Handler: Configured to use Node.js 14.x as the runtime and index.handler as the entry point for the function.
VPC Configuration: The Lambda function is placed in private subnets to enable secure access to other backend resources (e.g., a database in a private subnet).
Source Code: The function expects a lambda.zip file with the application code in the same directory. Replace this with the actual source file as needed.

Customizations:

AMI ID: Ensure the ami parameter is updated for your region.
Lambda Source Code: Replace lambda.zip with your actual source code file for the Lambda function.
Subnets: Verify that the specified subnets (public_subnet, private_subnet_1, and private_subnet_2) are defined in vpc.tf and properly configured.