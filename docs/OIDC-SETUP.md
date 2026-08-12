# ZiCloudTech GitHub OIDC Setup Guide

This lab uses GitHub OIDC to obtain short-lived AWS credentials. Do not create
or store AWS access keys in GitHub.

## 1. Replace the project placeholders

Search the repository for `REPLACE_WITH_`:

```bash
grep -R "REPLACE_WITH_" -n .
```

Replace each value as follows:

| Placeholder | Replacement |
| --- | --- |
| `REPLACE_WITH_TEAM_NAME` | Unique student or team name, such as `team-03` |
| `REPLACE_WITH_INSTRUCTOR_EMAIL` | Email used for budget and alarm notifications |
| `REPLACE_WITH_*_STATE_BUCKET` | Existing S3 Terraform-state bucket |
| `AWS_ACCOUNT_ID` | The 12-digit AWS account ID |
| `GITHUB_ORG` | GitHub organization or username that owns the repository |
| `REPOSITORY_NAME` | Repository name without `.git` |

Each team must use a unique state key. Never let two teams share one key.

## 2. Create the GitHub OIDC provider in AWS

In AWS IAM, open **Identity providers** and add an OpenID Connect provider:

- Provider URL: `https://token.actions.githubusercontent.com`
- Audience: `sts.amazonaws.com`

Create it only once per AWS account. If it already exists, reuse it.

## 3. Create an IAM deployment role

Create one role for each environment or student AWS account. Use the trust
policy in `oidc-trust-policy.json`, replacing its placeholders.

For Dev, the required subject is:

```text
repo:GITHUB_ORG/REPOSITORY_NAME:environment:dev
```

Use `environment:uat` and `environment:prod` for the other environments.
Attach the example `oidc-permissions-policy.json` to the role. It is broad
across the services required by this lab and must only be used in an isolated
training account. Add account guardrails and budgets. Never attach this
classroom policy to a production AWS account.

## 4. Create GitHub environments

In the repository, open **Settings > Environments** and create:

- `dev`
- `uat`
- `prod`

Add approval protection to UAT and Prod. In every environment, create these
variables:

| GitHub environment variable | Example |
| --- | --- |
| `AWS_DEPLOY_ROLE_ARN` | `arn:aws:iam::123456789012:role/zict-github-dev` |
| `AWS_REGION` | `us-west-2` |
| `TF_STATE_BUCKET` | `zict-team03-dev-tfstate` |
| `TF_STATE_KEY` | `teams/team-03/dev/terraform.tfstate` |

Create only this environment secret:

| GitHub environment secret | Purpose |
| --- | --- |
| `DATABASE_PASSWORD` | Password passed to Terraform as a sensitive variable |

Do not create `AWS_ACCESS_KEY_ID` or `AWS_SECRET_ACCESS_KEY` secrets.

## 5. Push a feature branch

```bash
git checkout -b feature/team-03-modules
git add .
git commit -m "Build reusable Terraform modules"
git push -u origin feature/team-03-modules
```

The push runs formatting and Terraform validation without AWS credentials,
remote state, or GitHub Environment secrets. Students cannot obtain the AWS
OIDC role merely by pushing feature-branch workflow changes.

The workflow formats its temporary runner copy. Students should also run
`terraform fmt -recursive` locally and commit the formatted files.

## 6. Apply an environment

Open **Actions > ZiCloudTech Terraform CI/CD > Run workflow**. Select the
environment, select `apply`, and run it. UAT and Prod should require instructor
approval through GitHub Environment protection rules.

## 7. Clean up

After the lab, open the manual workflow, choose the correct environment, and
select `destroy`. The workflow creates a destroy plan before applying it.
Confirm the run uses only the student . Protect UAT and Prod
with required .

## Troubleshooting

- `Not authorized to perform sts:AssumeRoleWithWebIdentity`: verify the role
  ARN, repository owner/name, environment name, OIDC audience, and trust policy.
- `Backend initialization required`: verify `TF_STATE_BUCKET`, `TF_STATE_KEY`,
  and `AWS_REGION` in the selected GitHub Environment.
- AMI lookup fails: allow `ssm:GetParameter` or explicitly set `ami_id`.
- Private EC2 provisioning fails: confirm the NAT gateway exists and routes are
  associated with the private subnets.
