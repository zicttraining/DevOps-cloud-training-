Explanation for README

S3 Bucket:

bme-uat-app: Creates an S3 bucket with the name bme-uat-app, configured with a private access control list (ACL) to restrict access.
Use Case: This bucket can store static files, logs, or other assets that the application may need, while ensuring they are not publicly accessible by default.

EBS Volume:

bme-uat-app_web_ebs: Provisions a 10 GB Elastic Block Store (EBS) volume in the us-west-2a availability zone.
Use Case: This volume provides additional block storage for the EC2 web server. It can be used to store application data or extend the server's storage capacity.

Customizations:

Bucket ACL: If public access is needed, modify acl to "public-read" or other suitable ACLs. However, this should be done with caution.
EBS Volume Size: Increase size if additional storage is required for the application.

Availability Zone: Ensure the availability_zone for the EBS volume matches the EC2 instance's zone to allow attachment.
This configuration sets up an S3 bucket for secure, private storage and an EBS volume to provide additional storage to the web server, supporting the application's storage needs.






