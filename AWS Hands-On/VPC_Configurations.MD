# VPC Configurations

## Outline

- Part 1 - Creating VPC, Subnet and Subnet associations

## Part 1 - Creating VPC, Subnet and Subnet associations

STEP 1: Create VPC

- First, go to the VPC and select Your VPC section from the left-hand menu, click create VPC.

- create a vpc named 'name-vpc-a' with 10.7.0.0/16 CIDR
    - no ipv6 CIDR block
    - tenancy: default

- click create

- enable DNS hostnames for the vpc 'name-vpc-a'

  - select 'name-vpc-a' on VPC console ----> Actions ----> Edit DNS hostnames
  - Click enable flag
  - Click save 

STEP 2: Create an internet gateway named 'name-igw'

- Go to the Internet Gateways from left hand menu

- Create Internet Gateway
   - Name Tag "name-igw" 
   - Click create button

-  attach the internet gateway 'name-igw' to the vpc 'name-vpc-a'
  - Actions ---> attach to VPC
  - Select VPC named "name-vpc-a"
  - Push "Attach Internet gateway"

STEP 3 : Configuring Route Table

- Go to the Route Tables from left hand menu

- rename the route table of the vpc 'name-vpc-a' as 'name-default-rt'

- select Routes on the sub-section

- click edit routes

- click add route

- add a route
    - destination ------> 0.0.0.0/0 (any network, any host)
    - As target;
      - Select Internet Gateway
      - Select 'name-igw'
      - save routes

- explain routes in the name-default-rt

STEP 4: Create Subnets
- Go to the Subnets from left hand menu
- Push create subnet button

1. 
Name tag          :name-az1a-public-subnet
VPC               :name-vpc-a
Availability Zone :us-east-1a
IPv4 CIDR block   :10.7.1.0/24

2. 
Name tag          :name-az1a-private-subnet
VPC               :name-vpc-a
Availability Zone :us-east-1a
IPv4 CIDR block   :10.7.2.0/24

3. 
Name tag          :name-az1b-public-subnet
VPC               :name-vpc-a
Availability Zone :us-east-1b
IPv4 CIDR block   :10.7.4.0/24

4. 
Name tag          :name-az1b-private-subnet
VPC               :name-vpc-a
Availability Zone :us-east-1b
IPv4 CIDR block   :10.7.5.0/24

5. 
Name tag          :name-az1c-public-subnet
VPC               :name-vpc-a
Availability Zone :us-east-1c
IPv4 CIDR block   :10.7.7.0/24

6. 
Name tag          :name-az1c-private-subnet
VPC               :name-vpc-a
Availability Zone :us-east-1c
IPv4 CIDR block   :10.7.8.0/24

- explain the subnet descriptions and reserved ips (why 251 instead of 256)

STEP 5: Route Tables

- Go to the Route Tables from left hand menu

- Select 'name-default-rt' and click the Subnet Association from sub-section

- show the default subnet associations on the route table 
   
   name-default-rt (internet access is available even on private subnets)

- push the create route table button

- create a private route table (not allowing access to the internet) 
  
  - name: 'name-private-rt'
  - VPC : 'name-vpc-a'
  - click create button

- show the routes in the route table name-private-rt,

- click Subnet association button and show the route table name-private-rt with private subnets

- Click Edit subnet association
- select private subnets;
  - name-az1a-private-subnet
  - name-az1b-private-subnet
  - name-az1c-private-subnet
  - and click save

- create a public route table (allowing access to the internet) 

- push the create route table button
  - name: 'name-public-rt'
  - VPC : 'name-vpc-a'
  - click create button

- show the routes in the route table name-public-rt,

- click Subnet association button and show the route table 

-Show the default route table subnet association . There are only 3 subnet implicitly.

- name-public-rt with public subnets

- Click Edit subnet association

- select public subnets;
  - name-az1a-public-subnet
  - name-az1b-public-subnet
  - name-az1c-public-subnet
  - and click save

- select Routes on the sub-section of name-public-rt

- click edit routes

- click add route

- add a route
    - destination ------> 0.0.0.0/0 (any network, any host)
    - As target;
      - Select Internet Gateway
      - Select 'name-igw'
      - save routes    
      
STEP 6: enable Auto-Assign Public IPv4 Address for public subnets

- Go to the Subnets from left hand menu

  - Select 'name-az1a-public-subnet' subnet ---> Action ---> Modify auto-assign IP settings  ---> select 'Enable auto-assign public IPv4 address' ---> Save

  - Select 'name-az1b-public-subnet' subnet ---> Action ---> Modify auto-assign
  IP settings  ---> select 'Enable auto-assign public IPv4 address' ---> Save

  - Select 'name-az1c-public-subnet' subnet ---> Action ---> Modify auto-assign
  IP settings  ---> select 'Enable auto-assign public IPv4 address' ---> Save

- Create two instances . One is in the Private and the other one is in Public subnet. Show the public and private IPs of instances. 

- Compare the IP of instance and Subnet CIDR block.


