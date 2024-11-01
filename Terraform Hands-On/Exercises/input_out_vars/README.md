**Step 1: Set Up the Directory called input_output_vars  and Variable File**
Create the following files:

``main.tf:`` The main configuration file containing all resources.
``variables.tf:`` Holds the variable definitions.
``terraform.tfvars``: (Optional) Customize your variable values here.
``File: variables.tf``
Define all necessary variables to cover the different data types.


create a file called varaibles.tf

``code varaibles.tf``

copy below code and paste in varaibles.tf  file

``
variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  type        = string
  description = "CIDR block for the subnet"
  default     = "10.0.1.0/24"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "enable_instance" {
  type        = bool
  description = "Flag to create an EC2 instance"
  default     = true
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones"
  default     = ["us-west-2a", "us-west-2b"]
}

variable "custom_tags" {
  type = map(string)
  description = "Custom tags for resources"
  default = {
    Environment = "Dev"
    Owner       = "Vincent"
  }
}

``
create a file called main.tf your main terraform code 
File: main.tf

`` code main.tf``

This main file creates a VPC, a subnet, and an EC2 instance, using the variables defined in variables.tf.

copy below code nd paste in there 

``
# Provider Configuration
provider "aws" {
  region = "us-west-2"
}

# VPC Resource
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  enable_dns_hostnames = true

  tags = merge(
    var.custom_tags,
    {
      Name = "Main-VPC"
    }
  )
}

# Subnet Resource
resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr
  availability_zone       = var.availability_zones[0]
  map_public_ip_on_launch = true

  tags = merge(
    var.custom_tags,
    {
      Name = "Main-Subnet"
    }
  )
}

# Security Group for EC2 Instance
resource "aws_security_group" "instance_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.custom_tags,
    {
      Name = "Instance-SG"
    }
  )
}

# EC2 Instance Resource with Conditional Creation
resource "aws_instance" "example" {
  count         = var.enable_instance ? 1 : 0
  ami           = "ami-0c55b159cbfafe1f0" # Update with a valid AMI ID
  instance_type = var.instance_type
  subnet_id     = aws_subnet.main.id
  security_groups = [aws_security_group.instance_sg.name]

  tags = merge(
    var.custom_tags,
    {
      Name = "Main-Instance"
    }
  )
}



# Output Values
output "vpc_id" {
  description = "The VPC ID"
  value       = aws_vpc.main.id
}

output "subnet_id" {
  description = "The Subnet ID"
  value       = aws_subnet.main.id
}

output "instance_public_ip" {
  description = "The public IP of the instance"
  value       = aws_instance.example[0].public_ip
  depends_on  = [aws_instance.example]
}

``

**Step 2: Initialize and Deploy the Infrastructure**

Run the following commands to deploy this setup:


``terraform init``         # Initializes Terraform and downloads provider plugins

``terraform plan``         # Prepares an execution plan, displaying what will happen

``terraform apply  ``      # Applies the changes to create the resources

Explanation of the Code

**Variables:**
We defined variables with different data types such as string, bool, list, and map for custom tags.
Conditional Resource Creation:
The aws_instance resource is created only if enable_instance is true.
**Tagging:**
We use the merge function for consistent custom tagging across resources.
**Output Values:**
Outputs are provided to display key information, such as the VPC ID, subnet ID, and instance public IP.