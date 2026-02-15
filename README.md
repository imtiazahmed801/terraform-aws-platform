📦 Flagship AWS Platform — Terraform Infrastructure CD
🚀 Overview

Production-style AWS infrastructure built with Terraform and deployed through a secure CI/CD promotion pipeline.

The platform provisions:

- VPC with public and private subnets
- Application Load Balancer (ALB)
- Auto Scaling Group (ASG)
- EC2 instances via Launch Template

Infrastructure changes are promoted from dev → prod using GitHub Actions with:

- Environment isolation
- OIDC-based AWS role assumption
- S3 remote state with DynamoDB locking
- Manual approval gates for production

The system prioritizes safe promotion, blast radius control, and zero-downtime deployment strategies.

🏗 Architecture

Components:

- Custom VPC
- Public subnets (ALB)
- Private subnets (EC2)
- Auto Scaling Group
- Launch Template
- Remote backend (S3 + DynamoDB)
- GitHub Actions CI/CD with environment-scoped IAM roles

🌐 Traffic Flow

Internet
↓
ALB (Public Subnets)
↓
Target Group
↓
ASG → EC2 Instances (Private Subnets)

🔄 CI/CD Flow

Push to main
↓
Dev: Plan → Apply (automatic)
↓
Prod: Plan
↓
Manual Approval
↓
Prod: Apply

Production deployments require explicit approval.

🧠 Key Engineering Decisions
🧩 Modular Terraform Design

Infrastructure is separated into reusable modules:

- vpc
- launch-template
- asg
- ec2

This enforces separation of concerns and improves maintainability.

☁️ Remote State (S3 + DynamoDB)

- Centralized state storage
- State locking to prevent concurrent operations 
- Protection against local state corruption

🔐 OIDC-Based Role Assumption

GitHub Actions authenticates to AWS using OIDC (no static credentials). Each environment has a dedicated IAM role with scoped trust policy:

- Dev cannot assume prod role
- Prod requires environment approval
- IAM enforces separation

🏢 Dev/Prod Isolation

- Separate state
- Separate IAM roles
- Promotion dependency
- Manual production gate

This reduces blast radius and enforces controlled infrastructure changes.

⚖️ Auto Scaling + ALB

- Launch Template defines instance configuration
- ASG manages lifecycle
- ALB routes traffic to healthy targets

Supports rolling updates and health-aware deployments.

🔄 Rolling Updates

Launch template changes do not automatically replace running instances. Safe rollout options:

- ASG Instance Refresh
- Health-check-aware replacement
- Controlled scaling

Enables zero-downtime updates.

📚 Lessons Learned
🌍 VPC CIDR Changes Are Destructive

Changing the VPC CIDR forced full replacement of:

- Subnets
- Route tables
- ALB
- ASG

Foundational network changes cascade across dependent resources.

⚠️ Dependency Violations & Drift

Partial destruction created:

- Internet Gateway dependency violations
- Orphaned ALB and ASG resources
- State drift

Resolution required understanding AWS dependencies and Terraform state reconciliation.

🔎 Reading Plans Critically

- -/+ resources indicate destroy-and-recreate behavior.

Foundational changes require careful review before approval.

🔮 Improvements I could make:

- Implement ASG instance_refresh
- Add scheduled drift detection
- Introduce blue/green deployment
- Add monitoring (CloudWatch alarms)
- Expand to multi-account promotion model

🎯 What This Project Demonstrates

- Infrastructure as Code discipline
- CI/CD-based promotion
- Secure OIDC authentication
- Environment isolation
- Controlled production rollout
- Real-world failure recovery
