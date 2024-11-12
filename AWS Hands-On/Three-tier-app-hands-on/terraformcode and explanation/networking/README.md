Explanation for README

ACM Certificate:
bme_uat_app_cert: Provisions an SSL certificate for bmeevent.com with DNS validation. This certificate is used to enable HTTPS on the Application Load Balancer (ALB).

Route 53 Records for Certificate Validation:
cert_validation: Creates DNS records in Route 53 to validate the ACM certificate. The certificate becomes active once DNS validation completes.

ACM Certificate Validation:
bme_uat_app_cert_validation: Confirms the ACM certificate by matching it with the DNS validation records created in Route 53.

Route 53 Hosted Zone:
bmeevent_zone: Defines a hosted zone for bmeevent.com. This is required for DNS management of the domain and for the certificate validation.

Application Load Balancer:
bme_uat_app_lb: Creates a public-facing ALB with HTTP and HTTPS listeners to handle incoming requests and direct traffic to target instances.
Security Group and Subnets: Ensures the ALB is in the public subnet and is protected by security group rules.

Target Group:
bme_uat_app_tg: Defines a target group to route traffic to the backend instances (e.g., EC2 instances). Configured to receive traffic on port 80 (HTTP).

Listeners:
HTTP Listener (bme_uat_app_http_listener): Redirects all HTTP traffic to HTTPS, ensuring secure connections.
HTTPS Listener (bme_uat_app_https_listener): Uses the ACM certificate to serve HTTPS traffic securely, forwarding it to the target group.

Route 53 A Record:
bme_uat_app_record: Creates an A record in Route 53 to route requests for bmeevent.com to the ALB, using an alias for efficient DNS resolution.
Customizations:

Domain Name: Replace bmeevent.com if a different domain is required.
Validation Records: Ensure that the hosted zone ID in zone_id matches your actual Route 53 hosted zone.
Load Balancer and Certificate Settings: Review and adjust the security group, load balancer subnets, and SSL policies as necessary.

This configuration establishes secure HTTPS access for the domain bmeevent.com using an ALB, and manages DNS records through Route 53 for efficient traffic routing and SSL certificate validation.