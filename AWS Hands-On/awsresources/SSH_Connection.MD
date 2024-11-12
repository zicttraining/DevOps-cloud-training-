# Hands-on EC2-00 : How to Connect EC2 instance with SSH.

## Outline

- Part 1 - Launching an Amazon Linux 2 EC2 instance

- Part 2 - Connect with SSH for WINDOWS-"Gitbash"

- Part 3 - Connect with SSH for WINDOWS- "WSL"

- Part 4 - Connect with SSH for MAC and Linux 

### Part 1 - Launching an Amazon Linux 2 EC2 instance

1. Launch an Amazon EC2 instance with name of "First EC2"

```text
AMI             : "Amazon Linux 2"
Instance Type   : "t2micro"
Region:          "N.Virginia"
VPC             : "Default VPC"
Security Group: "0.0.0.0/0-----> Port 22"
Keypair         : Create a new one as "firstkey"
```

### Part 1 - Connect with SSH for WINDOWS-"Gitbash"

#### STEP_1_ Gitbash

- Open gitbash 

- Go the directory of ".pem file" and try to see "firstkey.pem" file.

```text
cd \Downloads\
ls
```
- You need to see "firstkey.pem" as a response 

#### STEP_2_Connecting with Gitbash

- Go to EC2 instance pane 

- Click on "First EC2" instance

