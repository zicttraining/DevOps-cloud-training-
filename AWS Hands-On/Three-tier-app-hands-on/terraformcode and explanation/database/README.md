Explanation for README

Database Subnet Group:

A subnet group named bme-uat-app-db-subnet-group is created with two private subnets (private_subnet_1 and private_subnet_2) to enable high availability for the database.
Private subnets are used to keep the database isolated from public internet access.

Security Group for Database:

A security group (bme-uat-app-db-sg) is configured to manage inbound and outbound traffic for the RDS database instance.
Ingress Rule: Allows MySQL (port 3306) access from the web server security group, enabling only approved instances to connect to the database.
Egress Rule: Allows unrestricted outbound access, so the database can reach any necessary external resources or other services in the VPC.

RDS Database Instance:

An Amazon RDS MySQL database instance named bme-uat-app-db is provisioned for application data storage.
Instance Class: Configured as db.t3.micro, which is suitable for small-scale applications and testing.
Storage: Allocated with 20 GB of storage, which can be adjusted as needed.
Credentials: Admin credentials (username and password) are defined here for demonstration; replace these with secure values in production.
Subnet and Security Group: The RDS instance is attached to the specified database subnet group and security group, ensuring network security and proper isolation.

Customizations:

Storage Capacity: Increase allocated_storage if higher capacity is needed.
Admin Credentials: Replace the username and password with secure values, particularly for production environments.
Subnet and Security Group Configuration: Ensure that the referenced subnets and security groups (private_subnet_1, private_subnet_2, and web_sg) are defined in the appropriate files.

This configuration isolates the database in private subnets for security and restricts access to only authorized resources, promoting a secure and well-organized database architecture.