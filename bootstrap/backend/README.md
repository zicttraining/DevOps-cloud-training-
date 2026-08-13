# Backend Bootstrap

Run this once with instructor-authorized AWS credentials before using the main
environments. The backend cannot create itself because Terraform needs the
backend before it can manage remote state.

```bash
cp terraform.tfvars.example terraform.tfvars
# Replace every REPLACE_WITH value.
terraform init
terraform plan
terraform apply
```

Copy the resulting bucket name into the GitHub Environment variable
`TF_STATE_BUCKET`. The main deployment uses S3 native state locking. The state
bucket has `prevent_destroy`, so the normal lab cleanup cannot erase Terraform
state accidentally.
