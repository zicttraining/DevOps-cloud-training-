Explanation for README

Public Subnets:

bme-uat-app_public_subnet_1 and bme-uat-app_public_subnet_2: These subnets are configured for public access and are located in different availability zones (us-west-2a and us-west-2b) for redundancy. Each public subnet has auto-assigned public IPs for instances launched within them.

Private Subnets:

bme-uat-app_private_subnet_1 and bme-uat-app_private_subnet_2: These subnets are isolated from the internet and are located in us-west-2a and us-west-2b. They are used for instances that do not require public IPs, such as databases or backend services.

Internet Gateway:

bme-uat-app_main_igw: An Internet Gateway enables internet access for resources within the public subnets, allowing communication with external networks.

Public Route Table:

bme-uat-app_public_rt: A route table that directs traffic from public subnets to the internet through the Internet Gateway. It contains a route to allow all outbound traffic (0.0.0.0/0) to reach the internet.

Associations for Public Subnets:

bme-uat-app_public_subnet_assoc_1 and bme-uat-app_public_subnet_assoc_2: Associates each public subnet with the public route table, ensuring that instances within these subnets can access the internet.

Private Route Table:

bme-uat-app_private_rt: A route table for the private subnets, typically configured to route traffic through a NAT Gateway (if added), enabling instances in private subnets to access the internet indirectly.

Associations for Private Subnets:

bme-uat-app_private_subnet_assoc_1 and bme-uat-app_private_subnet_assoc_2: Associates each private subnet with the private route table, isolating these subnets from direct internet access.

Customizations:

CIDR Blocks: Adjust the cidr_block values for each subnet as needed to accommodate different IP ranges.
Availability Zones: Ensure that subnets are distributed across multiple availability zones for high availability and fault tolerance.

This configuration sets up a VPC with separate public and private subnets, an internet gateway for public access, and route tables to control traffic, supporting a secure and scalable network infrastructure.






