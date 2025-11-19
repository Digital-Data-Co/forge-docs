# Terraformer Infrastructure Import Guide

**Import existing cloud infrastructure as Terraform code with Forge + Terraformer**

---

## Overview

Terraformer reverse-engineers your existing cloud infrastructure into Terraform
configuration files. Instead of manually writing Terraform code for resources
that already exist, Terraformer discovers and imports them automatically.

### What is Terraformer?

[Terraformer](https://github.com/GoogleCloudPlatform/terraformer) is an
open-source CLI tool by Google Cloud Platform that generates `.tf` and
`.tfstate` files from existing cloud resources. Forge integrates Terraformer
to provide a seamless import experience.

### Key Benefits

- **Save Time**: Import hundreds of resources in minutes vs hours of manual coding
- **Accurate State**: Generates `.tfstate` files matching your actual infrastructure
- **Multi-Cloud**: Works with AWS, Azure, GCP, Kubernetes
- **Selective Import**: Choose specific resource types and regions
- **Tag Filtering**: Import only resources matching specific tags
- **Forge Integration**: Save directly as Templates or Repositories

---

## Quick Start

### 1. Configure Terraformer (Admin Only)

Navigate to **Admin Settings > Terraformer**

1. Toggle **Enable Terraformer** to ON
2. Click **Install/Update Binary**
3. Select version (e.g., 0.8.30)
4. Click **Install**
5. Click **Test Configuration** to verify
6. Click **Save Configuration**

**Alternative**: Enable **Docker Fallback** to use Terraformer via container

### 2. Add Cloud Credentials

Navigate to **Project > Key Store**

Add credentials for the cloud provider you want to import from:

**AWS Example**:
- Name: "AWS Production Account"
- Type: AWS
- Access Key ID: `AKIA...`
- Secret Access Key: `...`
- Region: `us-east-1`

### 3. Import Infrastructure

Navigate to **Import Infrastructure** (main menu)

**5-Step Wizard**:

**Step 1: Provider**
- Select cloud provider (AWS, Azure, GCP, or Kubernetes)

**Step 2: Credentials**
- Choose credentials from your Key Store

**Step 3: Resources**
- Select resource types to import (EC2, VPC, S3, etc.)
- Quick actions: Select All, Common Resources

**Step 4: Filters (Optional)**
- Add tag filters: `tag:Environment = Production`

**Step 5: Execute**
- Choose destination project
- Select output: Template or Repository
- Click **Import Infrastructure**

---

## Supported Cloud Providers

### AWS (70+ Resources)

**Compute**: EC2, ECS, EKS, Lambda, Auto Scaling, Batch
**Storage**: S3, EBS, EFS, Glacier, ECR
**Database**: RDS, DynamoDB, ElastiCache, Redshift
**Network**: VPC, Subnet, ELB, ALB, Route 53, CloudFront
**Security**: IAM, Security Groups, KMS, Secrets Manager, ACM
**Other**: CloudWatch, CloudTrail, SNS, SQS, API Gateway

### Azure (24 Resources)

**Compute**: Virtual Machines, Scale Sets, Container Instances, App Service
**Storage**: Storage Accounts, Disks, Managed Disks
**Network**: Virtual Networks, Subnets, Load Balancers, Public IPs, NSGs
**Database**: SQL Database, Cosmos DB, Redis Cache
**Security**: Key Vault, Security Center

### GCP (45 Resources)

**Compute**: Compute Instances, GKE, Cloud Functions, Instance Groups
**Storage**: Cloud Storage, Persistent Disks
**Database**: Cloud SQL, BigQuery, Memorystore
**Network**: VPC Networks, Firewalls, Load Balancers, Cloud Router
**Security**: IAM, KMS

### Kubernetes (23 Resources)

**Workloads**: Deployments, StatefulSets, DaemonSets, Jobs, Pods
**Network**: Services, Ingresses, Network Policies
**Config**: ConfigMaps, Secrets
**Storage**: PVs, PVCs, Storage Classes
**Security**: Service Accounts, Roles, Role Bindings

---

## Use Cases

### Use Case 1: Import Production AWS Infrastructure

**Scenario**: You have an existing AWS production environment with 200+
resources built manually over time. You want to manage it with Terraform.

**Steps**:
1. Import Infrastructure wizard
2. Select AWS provider
3. Choose AWS Production credentials
4. Select resources: EC2, VPC, RDS, S3, IAM
5. Filter: `tag:Environment = production`
6. Region: us-east-1
7. Save as Template: "AWS Production Infrastructure"
8. Import completes in 5-10 minutes
9. Review generated template with all resources
10. Run `terraform plan` to verify state matches reality

**Result**: Full Terraform state for production infrastructure

### Use Case 2: Multi-Region VPC Import

**Scenario**: You have VPCs in multiple AWS regions and want unified management.

**Steps**:
1. Select AWS provider
2. Select resources: VPC, Subnet, Route Table, IGW, NAT
3. Regions: us-east-1, us-west-2, eu-west-1
4. Save as Repository: "global-vpc-terraform"

**Result**: Repository with all VPC configs across 3 regions

### Use Case 3: Kubernetes Cluster Import

**Scenario**: Migrate existing Kubernetes cluster to Infrastructure as Code.

**Steps**:
1. Select Kubernetes provider
2. Choose kubeconfig credentials
3. Select: Deployments, Services, Ingresses, ConfigMaps
4. Filter by namespace: `namespace = production`
5. Save as Template: "K8s Production Apps"

**Result**: Terraform configurations for all production workloads

---

## Output Modes

### Template Output

**Best for**: Quick access and execution

**What happens**:
- Terraform files combined into single template
- Saved in project's Templates section
- Immediately executable with `terraform plan/apply`
- Inventory automatically created

**Example**:
```hcl
# File: aws/ec2.tf
resource "aws_instance" "web-1" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  # ... imported attributes
}

# File: aws/vpc.tf
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  # ... imported attributes
}
```

### Repository Output

**Best for**: Version control and collaboration

**What happens**:
- Terraform files saved to repository
- Separate files per resource type
- Git-ready structure
- Can be pushed to remote Git

**Directory structure**:
```
my-import/
├── main.tf
├── variables.tf
├── terraform.tfstate
├── aws/
│   ├── ec2.tf
│   ├── vpc.tf
│   └── s3.tf
└── generated/
    └── ...
```

---

## Resource Filtering

### Tag-Based Filtering

Import only resources with specific tags:

**AWS**:
```
tag:Environment = production
tag:Team = devops
tag:CostCenter = engineering
```

**Azure**:
```
tag:environment = prod
tag:owner = team-platform
```

**GCP**:
```
label:env = production
label:team = sre
```

### Region Filtering

Limit import to specific regions:
- AWS: `us-east-1, us-west-2`
- Azure: `eastus, westus2`
- GCP: `us-central1, europe-west1`

### Resource Type Filtering

Select only the resources you need:
- **Compute only**: EC2, ECS, Lambda
- **Network only**: VPC, Subnets, Security Groups
- **Storage only**: S3, EBS, EFS

---

## Best Practices

### 1. Start Small

Don't import everything at once:
- ✅ Start with one region
- ✅ Select specific resource types
- ✅ Use tag filters
- ❌ Don't import all regions and all resources initially

### 2. Use Filters

Filter by environment or team:
```
tag:Environment = production
tag:Managed = terraform
```

This prevents importing development/test resources.

### 3. Review Before Plan

After import:
1. Review generated Terraform code
2. Check for sensitive data (passwords, keys)
3. Organize resources logically
4. Add variables for common values
5. Run `terraform plan` to verify accuracy

### 4. Incremental Adoption

Import infrastructure incrementally:
- Week 1: Import VPC and networking
- Week 2: Import compute resources
- Week 3: Import databases
- Week 4: Import security resources

### 5. Version Control

Always save as Repository for:
- Team collaboration
- Change tracking
- Rollback capability
- Code review process

---

## Troubleshooting

### Terraformer Not Found

**Symptom**: "Terraformer binary not found"

**Solution**:
1. Admin Settings > Terraformer
2. Click "Install/Update Binary"
3. Select latest version
4. Click Install
5. Verify with "Test Configuration"

**Alternative**: Enable "Docker Fallback" to use containerized Terraformer

### Authentication Errors

**Symptom**: "Error: could not authenticate to AWS/Azure/GCP"

**Solution**:
1. Verify credentials in Key Store
2. Test credentials:
   - AWS: `aws sts get-caller-identity`
   - Azure: `az account show`
   - GCP: `gcloud auth list`
3. Check credential permissions (read-only access required)
4. Ensure region matches credential region

### No Resources Found

**Symptom**: "0 resources imported"

**Possible causes**:
- Filters too restrictive
- Wrong region selected
- Credentials don't have access to resources
- Resource types not present in environment

**Solution**:
- Remove filters and try again
- Verify region
- Check IAM/RBAC permissions
- List resources manually: `aws ec2 describe-instances`

### Import Timeout

**Symptom**: Task runs longer than 30 minutes

**Causes**:
- Too many resources selected
- Multiple regions
- Large S3 buckets or databases

**Solution**:
- Import one region at a time
- Select fewer resource types
- Use filters to limit scope
- Run on dedicated runner

### Terraform Provider Plugin Errors

**Symptom**: "Error: could not download provider plugin"

**Solution**:
- Terraform automatically runs `terraform init` after import
- If it fails, manually run: `terraform init` in output directory
- Check internet connectivity
- Verify Terraform version compatibility

---

## API Reference

### Get Providers

```bash
GET /api/terraformer/providers

Response:
{
  "aws": {
    "name": "Amazon Web Services",
    "requiresRegion": true,
    "resourceCount": 70
  },
  ...
}
```

### Get Provider Resources

```bash
GET /api/terraformer/providers/aws/resources

Response:
{
  "provider": "aws",
  "resources": ["ec2", "vpc", "s3", ...],
  "categories": {
    "Compute": [...],
    "Storage": [...]
  }
}
```

### Execute Import

```bash
POST /api/project/1/terraformer/import

Body:
{
  "provider": "aws",
  "resources": ["ec2", "vpc"],
  "regions": ["us-east-1"],
  "access_key_id": 10,
  "filter": {"tag:Env": "prod"},
  "output_mode": "template",
  "output_name": "AWS Production",
  "compact": false,
  "project_id": 1
}

Response:
{
  "task_id": 123,
  "template_id": 456,
  "message": "Import task created successfully"
}
```

### Check Import Status

```bash
GET /api/project/1/terraformer/tasks/123/status

Response:
{
  "task_id": 123,
  "status": "running",
  "start": "2025-10-15T10:30:00Z",
  "message": "Terraformer import: aws"
}
```

---

## Examples

### Example 1: Import AWS VPC

```bash
# Via UI:
1. Provider: AWS
2. Credentials: AWS Production
3. Resources: vpc, subnet, route_table, igw, nat
4. Region: us-east-1
5. Output: Template named "Production VPC"

# Generated Terraform:
resource "aws_vpc" "tfer--vpc-0abc123" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "production-vpc"
    Environment = "production"
  }
}

resource "aws_subnet" "tfer--subnet-0def456" {
  vpc_id = aws_vpc.tfer--vpc-0abc123.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}
```

### Example 2: Import GCP Project

```bash
# Via UI:
1. Provider: GCP
2. Credentials: GCP Service Account
3. Resources: compute_instance, gcs, cloud_sql, network
4. Output: Repository named "gcp-infrastructure"

# Result: Repository with organized Terraform files
```

### Example 3: Import Kubernetes Namespace

```bash
# Via UI:
1. Provider: Kubernetes
2. Credentials: Kubeconfig
3. Resources: deployment, service, ingress, configmap
4. Filter: namespace = production
5. Output: Template named "K8s Production Apps"
```

---

## Advanced Topics

### Custom Path Patterns

Control output directory structure:

```bash
# Default: {output}/{provider}
# Custom: --path-pattern={output}/{provider}/{service}
```

Result:
```
output/
├── aws/
│   ├── compute/
│   │   └── ec2.tf
│   ├── network/
│   │   └── vpc.tf
│   └── storage/
│       └── s3.tf
```

### Compact Mode

Generate single file with all resources:

```bash
--compact
```

Result: All resources in `resources.tf` instead of separate files

### Incremental Imports

Import infrastructure incrementally:

**Phase 1**: Network foundation
```
Resources: vpc, subnet, route_table, security_group
```

**Phase 2**: Compute resources
```
Resources: ec2_instance, auto_scaling, launch_configuration
```

**Phase 3**: Databases
```
Resources: rds, dynamodb, elasticache
```

### State Management

After import, Terraform state is managed automatically:

- Initial state file generated by Terraformer
- Subsequent `terraform plan` compares against live infrastructure
- Use remote state for team collaboration

---

## Security Considerations

### Read-Only Access

Terraformer only requires **read** permissions:

**AWS IAM Policy Example**:
```json
{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Allow",
    "Action": [
      "ec2:Describe*",
      "s3:List*",
      "s3:Get*",
      "rds:Describe*",
      "iam:List*",
      "iam:Get*"
    ],
    "Resource": "*"
  }]
}
```

**Azure RBAC**: Reader role
**GCP IAM**: Viewer role
**Kubernetes**: get, list verbs only

### Sensitive Data

Generated Terraform files may contain:
- Resource IDs
- Configuration details
- NOT passwords or secrets (stored in state only)

**Best Practice**: Review before committing to version control

---

## Troubleshooting

### Common Issues

**Issue**: Import fails with "no resources found"
**Fix**: Remove filters, check region, verify credentials

**Issue**: "Terraform provider not initialized"
**Fix**: Run `terraform init` in output directory

**Issue**: Import takes too long
**Fix**: Reduce scope, import one region at a time

**Issue**: Docker fallback not working
**Fix**: Verify Docker is running: `docker ps`

---

## FAQ

**Q: Can I import infrastructure from multiple providers?**
A: Yes, run separate imports for each provider.

**Q: Will this modify my existing infrastructure?**
A: No, Terraformer is read-only. It only discovers resources.

**Q: How do I handle changes after import?**
A: Use `terraform plan` and `terraform apply` to manage infrastructure going forward.

**Q: Can I import specific resources by ID?**
A: Terraformer imports by type/region/tags. For specific resources, use filters.

**Q: What if import fails partway through?**
A: Check task logs. Partial imports are saved. Re-run import to complete.

---

## Examples

See `/examples/terraformer/` directory:
- `import-aws-vpc.md` - Import AWS networking
- `import-gcp-project.md` - Import GCP project
- `import-k8s-cluster.md` - Import Kubernetes workloads

---

**Documentation Version**: 1.0
**Last Updated**: October 15, 2025
**Terraformer Version**: 0.8.30
**Forge Version**: v0.1.357+

