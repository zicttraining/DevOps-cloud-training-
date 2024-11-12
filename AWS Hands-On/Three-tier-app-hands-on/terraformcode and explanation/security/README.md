Explanation for README

IAM Role for EC2:

bme-uat-app_ec2_role: Creates an IAM role that allows EC2 instances to assume permissions to access AWS services, enabling secure, controlled access.
IAM Policy for Secrets Manager:

bme-uat-app_secrets_manager_policy: Defines an IAM policy that grants permissions to read secrets from AWS Secrets Manager. This policy includes actions such as GetSecretValue and DescribeSecret.

Policy Attachment:

bme-uat-app_attach_secrets_policy: Attaches the Secrets Manager policy to the EC2 IAM role, allowing instances with this role to securely access secrets stored in AWS Secrets Manager.
Secrets Manager:

bme-uat-app_db_credentials: Creates a secret in AWS Secrets Manager to securely store database credentials.
bme-uat-app_db_credentials_version: Stores a versioned secret in Secrets Manager, holding the database username and password values. Replace these values with secure credentials.

Security Group for Web Server:

bme-uat-app_web_sg: Configures a security group to control traffic to the web server. It allows HTTP access on port 80 from any IP and unrestricted outbound access.
Ingress Rule: Allows HTTP traffic on port 80, enabling public access to web content.
Egress Rule: Allows all outbound traffic, so the web server can reach any necessary external resources.

Customizations:

Secrets: Replace username and password values with secure credentials in a production environment.
Additional Policies: If additional permissions are needed for EC2, they can be added to the secrets_manager_policy or created as new policies.
Security Group Rules: Modify the ingress rule if the web server needs to serve on ports other than 80 or restrict outbound access as needed.

This configuration ensures that EC2 instances can securely retrieve database credentials from AWS Secrets Manager, and that the web server is accessible while following best practices for IAM roles, policies, and security groups.






