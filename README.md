# Modular Dev/UAT/Prod Terraform Training Project

ZiCloudTech teaching edition. Start with `docs/OIDC-SETUP.md` for the complete
AWS OIDC, GitHub Environment, backend, feature-branch, and deployment steps.

The infrastructure is organized into reusable modules and three independent
root configurations. Each environment has its own backend and values.

## Layout

```text
modules/
  environment-stack/  # composes the component modules
  vpc/
  networking/
  security/
  compute/
  database/
  storage/
  monitoring/
  budget/
environments/
  dev/
  uat/
  prod/
```

## Deploy one environment

```bash
cd environments/dev
export TF_VAR_database_password='replace-with-a-secure-password'
terraform fmt -recursive ../..
terraform init -backend-config=backend.hcl
terraform validate
terraform plan
terraform apply
```

Change `dev` to `uat` or `prod` as needed. The S3 backend bucket must exist
before initialization. State locking uses Terraform's native S3 lock file.

## Team workflow

- Teams change only their environment's `terraform.tfvars` and `backend.hcl`.
- Shared infrastructure behavior is changed in `modules/` through code review.
- Never commit database passwords or AWS credentials.
- This classroom edition disables RDS deletion protection and skips final
  snapshots in every environment so instructor-approved cleanup is predictable.
  Real production systems should reverse those settings.

## Feature branch workflow

Push development work to a branch beginning with `feature/`, for example:

```bash
git checkout -b feature/terraform-modules
git add .
git commit -m "Refactor Terraform into reusable modules"
git push -u origin feature/terraform-modules
```

Every push to `feature/**` runs formatting and validation without AWS access or
environment secrets. To create an AWS plan or deploy, open GitHub Actions,
select **ZiCloudTech Terraform CI/CD**, choose an environment and select the
required action. Only the protected manual job can request an OIDC token.

Create GitHub environments named `dev`, `uat`, and `prod`. Add these settings to
each environment:

- Variable `AWS_DEPLOY_ROLE_ARN`: that environment's AWS IAM role for OIDC.
- Variables `AWS_REGION`, `TF_STATE_BUCKET`, and `TF_STATE_KEY`.
- Secret `DATABASE_PASSWORD`: that environment's database password.

Add approval protection to the `uat` and `prod` GitHub environments.

## Important migration note

This refactor changes Terraform resource addresses. Do not run `apply` against
an existing environment until its state has been migrated with `moved` blocks
or `terraform state mv`. Review the plan carefully to prevent replacement of
existing resources.
