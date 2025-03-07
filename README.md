Folder Structure

/root/terraform-eks/
├── environments/
│   └── dev/                    # Development environment
│       ├── main.tf            # Main configuration file
│       ├── variables.tf       # Input variables
│       ├── terraform.tfvars   # Variable values
│       ├── providers.tf       # Provider configurations
│       └── backend.tf         # State backend configuration
│
├── modules/
│   ├── vpc/                   # VPC module
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── eks/                   # EKS cluster module
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── kms.tf
│   │
│   ├── iam/                   # IAM roles and policies
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── addons/               # Kubernetes addons
│       ├── main.tf
│       ├── variables.tf
│       ├── versions.tf
│       ├── metrics-server/
│       ├── cluster-autoscaler/
│       ├── aws-lb-controller/
│       ├── cert-manager/
│       ├── argocd/
│       ├── nginx-ingress/
│       ├── rds/
│       └── logging/
│
├── policies/                  # IAM policy documents
│   └── eks-inline-policy.json
│
└── setup/                    # One-time setup resources
    └── backend-prep.tf      # S3 bucket and DynamoDB table creation