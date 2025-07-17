🚀 CI/CD Pipeline: AWS Terraform with GitHub Actions
This project uses GitHub Actions to automate deployment of infrastructure using Terraform across Dev, UAT, and Production environments on AWS.

🧩 Environments Overview
Environment	Trigger	Branch	Manual	Notes
Dev	Auto	Any branch	❌ No	Deploys automatically on any push
UAT	Manual	Any	✅ Yes	Deploy latest Dev code to UAT
Prod	Manual only	main	✅ Yes	Must be on main branch only

📊 Deployment Flow
mermaid
Copy
Edit
graph TD
  A[Code Push to Any Branch] --> B[Auto Deploy to Dev]
  B --> C[Manual Trigger: Deploy to UAT]
  C --> D[Manual Trigger: Deploy to Production (from main)]
⚙️ Workflow Features
✅ Auto deploy to Dev on every push
✅ Manually promote to UAT (based on Dev)
✅ Manually promote to Prod (only from main)
✅ Support for terraform destroy via dropdown
✅ Modular and extensible
✅ Uses IAM keys stored in GitHub secrets

🧪 Manual Deployment (UAT/Prod)
To manually deploy or destroy:

Go to your repo’s Actions tab

Select "AWS Terraform CI/CD"

Click "Run workflow"

Set:

environment: dev, uat, or production

destroy: false (to deploy) or true (to destroy)

Click ✅ Run workflow

🔐 Secrets Required
Secret Name	Environment
AWS_ACCESS_KEY_ID_DEV	Dev
AWS_SECRET_ACCESS_KEY_DEV	Dev
AWS_ACCESS_KEY_ID_UAT	UAT
AWS_SECRET_ACCESS_KEY_UAT	UAT
AWS_ACCESS_KEY_ID_PROD	Prod
AWS_SECRET_ACCESS_KEY_PROD	Prod

Store these under your repo’s Settings → Secrets and variables → Actions → New repository secret.

📁 Folder Structure
bash
Copy
Edit
.
├── Dev/
│   └── main.tf, backend.tf, ...
├── UAT/
│   └── main.tf, backend.tf, ...
├── Prod/
│   └── main.tf, backend.tf, ...
└── .github/workflows/
    └── deploy.yml
Each environment has its own backend.tf and state isolation.

📌 Important Rules
Dev deploys from any branch automatically

UAT must be triggered manually (once Dev is stable)

Prod can only be triggered from main branch

You can destroy infrastructure manually using the destroy: true input

