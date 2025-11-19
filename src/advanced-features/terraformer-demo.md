# Terraformer Infrastructure Import - Demo Walkthrough

**Complete demonstration of importing existing cloud infrastructure into Terraform**

---

## 🎯 Demo Scenario

**Goal**: Import an existing AWS production environment containing:
- 3 EC2 instances
- 1 VPC with 6 subnets
- 2 RDS databases
- 5 S3 buckets
- 10 security groups
- Application Load Balancer
- Route53 DNS zones

**Total**: ~50 resources across multiple AWS services

**Time**: 10-15 minutes

---

## 📋 Prerequisites

Before starting the demo:

✅ Forge v0.1.362+ installed and running
✅ AWS account with existing infrastructure
✅ AWS credentials with read-only access
✅ Admin access to Forge (for initial setup)

---

## Part 1: Admin Configuration (3 minutes)

### Step 1: Enable Terraformer

1. Navigate to **Admin Settings** (gear icon in menu)
2. Click **Terraformer** tab
3. Toggle **Enable Terraformer** to ON
4. Click **Install/Update Binary** button

### Step 2: Install Binary

1. Version dropdown appears
2. Select **0.8.30** (latest)
3. Installation path: `/usr/local/bin/terraformer` (default)
4. Click **Install**
5. Wait 10-15 seconds for download
6. Success message: "Terraformer installed successfully"

### Step 3: Test Configuration

1. Click **Test Configuration** button
2. Verify results:
   - ✓ Valid: true
   - ✓ Version: v0.8.30
   - ✓ Binary path: /usr/local/bin/terraformer
   - ✓ Docker available: true (if Docker installed)

### Step 4: Save Configuration

1. Enable **Docker Fallback** (optional)
2. Docker Image: `cytopia/terraformer:latest`
3. Runner: Leave empty (use server)
4. Click **Save Configuration**
5. Success: "Configuration saved successfully"

**✅ Admin setup complete! Terraformer is now available to all users.**

---

## Part 2: Add AWS Credentials (2 minutes)

### Step 5: Navigate to Key Store

1. Select project: **"Production Infrastructure"**
2. Click **Key Store** in project menu
3. Click **New Key** button

### Step 6: Add AWS Credentials

1. **Name**: "AWS Production Read-Only"
2. **Type**: Select "aws" from dropdown
3. **Access Key ID**: `AKIA...` (your AWS access key)
4. **Secret Access Key**: `...` (your AWS secret)
5. **Region**: `us-east-1`
6. Click **Save**

**Credential stored encrypted in Forge database**

---

## Part 3: Import Infrastructure (8 minutes)

### Step 7: Start Import Wizard

1. Click **Import Infrastructure** in main navigation menu
2. Import wizard appears with 5 steps

### Step 8: Select Cloud Provider

**Current Step: 1/5 - Provider**

1. See 4 provider cards:
   - Amazon Web Services (70+ resources)
   - Microsoft Azure (24 resources)
   - Google Cloud Platform (45 resources)
   - Kubernetes (23 resources)

2. Click **Amazon Web Services** card
3. Card highlights in blue
4. Click **Next** button

### Step 9: Choose Credentials

**Current Step: 2/5 - Credentials**

1. Credentials dropdown appears
2. Select: "AWS Production Read-Only"
3. Info box shows: "Credentials are used read-only to discover existing resources"
4. Click **Next** button

### Step 10: Select Resources

**Current Step: 3/5 - Resources**

1. **Region selector** appears (multi-select)
   - Select: `us-east-1`

2. **Resource categories** (expandable panels):

   **Compute** (8 types)
   - ☑ EC2 Instances
   - ☑ ECS
   - ☑ Auto Scaling

   **Storage** (5 types)
   - ☑ S3
   - ☑ EBS

   **Database** (4 types)
   - ☑ RDS
   - ☑ DynamoDB

   **Network** (14 types)
   - ☑ VPC
   - ☑ Subnet
   - ☑ Route Table
   - ☑ Internet Gateway
   - ☑ NAT Gateway
   - ☑ ELB
   - ☑ ALB
   - ☑ Security Groups
   - ☑ Route 53

   **Security** (7 types)
   - ☑ IAM
   - ☑ KMS

3. **Quick Actions**:
   - Option A: Click "Common Resources" (selects EC2, VPC, S3, RDS, IAM, SG)
   - Option B: Manually check boxes above
   - Option C: Click "Select All" (all 70 resources)

4. **Selection Counter**: Shows "15 selected"

5. Click **Next** button

### Step 11: Add Filters (Optional)

**Current Step: 4/5 - Filters**

1. **Filter by Environment** tag:
   - Filter Key: `tag:Environment`
   - Filter Value: `production`
   - Click **Add** button
   - Chip appears: `tag:Environment: production`

2. **Filter by Managed tag** (optional):
   - Filter Key: `tag:ManagedBy`
   - Filter Value: `manual`
   - Click **Add**
   - Second chip appears

3. Info box: "No filters applied. All resources will be imported."

4. Click **Next** button

### Step 12: Configure Destination & Execute

**Current Step: 5/5 - Execute**

1. **Destination Project**: "Production Infrastructure" (pre-selected)

2. **Save As**:
   - ○ Terraform Template (selected)
     - "Create executable template in project"
   - ○ Git Repository
     - "Save as repository for version control"

3. **Template Name**: `AWS Production Import`

4. **Compact Output**: ☐ (unchecked)
   - Unchecked = separate files per resource type
   - Checked = single file with all resources

5. **Import Summary** card shows:
   ```
   Provider:    Amazon Web Services
   Regions:     us-east-1
   Resources:   15 types selected
   Filters:     2 filter(s)
   Destination: Production Infrastructure
   Output:      template
   ```

6. Warning: "Large imports may take several minutes. You can monitor progress in Tasks view."

7. Click **Import Infrastructure** button

### Step 13: Import Execution

1. Button shows loading spinner
2. Success dialog appears after 2-3 seconds:
   - ✓ "Import Started"
   - "Infrastructure import task has been created successfully!"
   - Task ID: 4567
3. Click **View Task** button

### Step 14: Monitor Progress

**Tasks View**:

```
Task #4567
Status: Running
Message: Terraformer import: aws
Started: 2025-10-15 10:35:42
```

**Live Log Output**:
```
[10:35:42] Starting Terraformer import for aws provider
[10:35:42] Executing command: terraformer import aws --resources=ec2_instance,vpc,s3,...
[10:35:45] Downloading AWS provider plugins...
[10:35:50] Importing EC2 instances...
[10:35:52] Found 3 EC2 instances
[10:35:55] Importing VPC...
[10:35:56] Found 1 VPC
[10:35:58] Importing Subnets...
[10:36:00] Found 6 subnets
[10:36:05] Importing S3 buckets...
[10:36:08] Found 5 S3 buckets
[10:36:12] Importing RDS instances...
[10:36:15] Found 2 RDS instances
[10:36:20] Importing Security Groups...
[10:36:23] Found 10 security groups
[10:36:28] Importing ALB...
[10:36:30] Found 1 application load balancer
[10:36:35] Importing Route53 zones...
[10:36:38] Found 2 hosted zones
[10:36:42] Running terraform init to download provider plugins...
[10:36:50] Terraform initialized successfully
[10:36:55] Terraformer import completed successfully
[10:36:55] Total resources imported: 47
```

**Final Status**:
```
Task #4567
Status: ✓ Success
Duration: 5 minutes 13 seconds
```

---

## Part 4: Review Imported Template (2 minutes)

### Step 15: Open Template

1. Navigate to **Project > Templates**
2. Find: "AWS Production Import"
3. Click template name

### Step 16: Review Generated Code

**Template Details View**:

**Generated Terraform Code** (example):

```hcl
# File: aws/ec2.tf
resource "aws_instance" "tfer--i-0abc123def456789" {
  ami                    = "ami-0c55b159cbfafe1f0"
  instance_type          = "t3.medium"
  availability_zone      = "us-east-1a"
  subnet_id              = aws_subnet.tfer--subnet-0def456.id
  vpc_security_group_ids = [
    aws_security_group.tfer--sg-0ghi789.id,
  ]

  tags = {
    Name        = "web-server-1"
    Environment = "production"
    ManagedBy   = "manual"
  }

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }
}

# File: aws/vpc.tf
resource "aws_vpc" "tfer--vpc-0abc123" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "production-vpc"
    Environment = "production"
  }
}

resource "aws_subnet" "tfer--subnet-0def456" {
  vpc_id            = aws_vpc.tfer--vpc-0abc123.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "public-subnet-1a"
  }
}

# File: aws/s3.tf
resource "aws_s3_bucket" "tfer--prod-application-logs" {
  bucket = "prod-application-logs"

  tags = {
    Environment = "production"
    Purpose     = "Logging"
  }
}

# File: aws/rds.tf
resource "aws_db_instance" "tfer--production-db" {
  identifier              = "production-db"
  allocated_storage       = 100
  engine                  = "postgres"
  engine_version          = "14.7"
  instance_class          = "db.t3.medium"
  db_name                 = "proddb"
  username                = "admin"
  vpc_security_group_ids  = [
    aws_security_group.tfer--sg-0xyz789.id,
  ]
  db_subnet_group_name    = "production-db-subnet-group"

  tags = {
    Name        = "production-database"
    Environment = "production"
  }
}

# ... and 43 more resources
```

**Inventory**: TerraformWorkspace "AWS Production Import Workspace" (auto-created)

---

## Part 5: Manage Infrastructure with Terraform (5 minutes)

### Step 17: Run Terraform Plan

1. Click **Run** button on template
2. Select: **Terraform Plan** (not Apply)
3. Inventory: "AWS Production Import Workspace"
4. Click **Run Task**

**Task Output**:
```
Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:

Terraform will perform the following actions:

No changes. Infrastructure is up-to-date.

This means that Terraform did not detect any differences between your
configuration and the remote system(s). As a result, there are no actions to
perform.
```

**✅ Perfect Match!** Imported state matches actual AWS infrastructure.

### Step 18: Make a Change

1. Click **Edit** on template
2. Modify S3 bucket configuration:

```hcl
resource "aws_s3_bucket" "tfer--prod-application-logs" {
  bucket = "prod-application-logs"

  tags = {
    Environment = "production"
    Purpose     = "Logging"
    ManagedBy   = "terraform"  # <-- ADD THIS
  }
}
```

3. Click **Save**

### Step 19: Apply Change

1. Click **Run** button
2. Select: **Terraform Apply**
3. Inventory: Same workspace
4. Click **Run Task**

**Task Output**:
```
Terraform will perform the following actions:

  # aws_s3_bucket.tfer--prod-application-logs will be updated in-place
  ~ resource "aws_s3_bucket" "tfer--prod-application-logs" {
        bucket = "prod-application-logs"
        id     = "prod-application-logs"

      ~ tags   = {
          + "ManagedBy"   = "terraform"
            "Environment" = "production"
            "Purpose"     = "Logging"
        }
    }

Plan: 0 to add, 1 to change, 0 to destroy.

Apply complete! Resources: 0 added, 1 changed, 0 destroyed.
```

**✅ Success!** Infrastructure is now managed by Terraform through Forge.

---

## 🎬 Demo Script (10-Minute Presentation)

### Minute 1-2: Introduction

> "Today I'll show you how Forge makes it easy to import existing cloud
> infrastructure into Terraform. Instead of manually writing hundreds of lines
> of Terraform code, we'll use Terraformer to reverse-engineer what's already
> running in AWS."

### Minute 3-4: Admin Setup

> "First, I'll enable Terraformer in Admin Settings. Watch how simple it is -
> click Install, select version 0.8.30, and Forge automatically downloads the
> binary. Let's test it... and perfect, it's working!"

### Minute 5-7: Import Wizard

> "Now I'll import our production AWS environment. The wizard guides us through
> 5 steps. First, select AWS as the cloud provider. Next, choose credentials
> from the Key Store - these are read-only and encrypted. For Step 3, I'll
> select the resources we want: EC2, VPC, S3, RDS, and Security Groups.
> In Step 4, I'll filter by the 'Environment=production' tag to avoid importing
> dev resources. Finally, I'll save this as a Terraform template called
> 'AWS Production Import'."

### Minute 8: Execution

> "Clicking Import Infrastructure creates a background task. Let's watch the
> progress... Terraformer is discovering resources, found 3 EC2 instances,
> 1 VPC with 6 subnets, 5 S3 buckets, 2 RDS databases, 10 security groups...
> In total, 47 resources imported in about 5 minutes."

### Minute 9-10: Review & Manage

> "Now the template is created with all the Terraform code. Let's look at it -
> here's the VPC definition, EC2 instances, RDS databases, all with their
> current configuration. I can run terraform plan to verify it matches reality.
> Look - no changes detected, perfect state match. Now I can make changes like
> adding tags, then apply them. Infrastructure that was built manually is now
> fully managed as code!"

---

## 🎥 Visual Demo Flow

**Step 1**: Admin Settings > Terraformer
- Enable Terraformer
- Install binary version 0.8.30
- Test configuration
- ✓ Ready

**Step 2**: Add AWS Credentials
- Key Store > New Key
- Type: AWS
- ✓ Saved encrypted

**Step 3**: Import Infrastructure Wizard
- Provider: AWS
- Credentials: AWS Production
- Resources: 15 types selected
- Filters: Environment=production
- Output: Template
- → Click Import

**Step 4**: Task Execution
- Status: Running
- Progress: Importing resources
- Found: 47 resources
- Duration: 5 minutes
- ✓ Complete

**Step 5**: Template Created
- Name: AWS Production Import
- Contains: 47 Terraform configs
- Inventory: Auto-created
- ✓ Ready to use

**Step 6**: Manage Infrastructure
- Run terraform plan → No changes
- Edit template → Add tags
- Run terraform apply → 1 changed
- ✓ Infrastructure now managed as code

---

## 📊 Demo Metrics

**Setup Time**: 3 minutes (one-time)
**Import Time**: 5-10 minutes (depending on resource count)
**Total Demo Time**: 10-15 minutes

**Resources Imported**: 47 (in this example)
**Lines of Code Generated**: ~800 lines of Terraform
**Manual Effort Saved**: 4-6 hours of writing Terraform code

---

## 🎓 Key Talking Points

### 1. Time Savings

> "Writing Terraform for 47 resources manually would take 4-6 hours. Terraformer
> does it in 5 minutes with perfect accuracy."

### 2. Accuracy

> "The generated code includes ALL resource attributes - no guessing about
> configurations. The tfstate file matches reality exactly."

### 3. Multi-Cloud

> "Same workflow works for Azure, GCP, and Kubernetes. Switch cloud providers
> with a single click."

### 4. Filtering Power

> "Tag filtering lets you import only production resources, or only resources
> managed by a specific team. Very powerful for large environments."

### 5. Integration

> "Everything stays in Forge - credentials, templates, task execution, all
> integrated. No context switching between tools."

---

## 🔍 Demo Tips

### Preparation

- **Pre-create AWS resources** (or use existing environment)
- **Test import beforehand** to verify credentials work
- **Have sample Terraform change ready** (like adding a tag)
- **Practice wizard flow** to keep demo moving

### Common Issues

**Issue**: Credential authentication fails
**Fix**: Verify AWS credentials with `aws sts get-caller-identity` beforehand

**Issue**: No resources found
**Fix**: Remove filters, verify region has resources

**Issue**: Import too slow
**Fix**: Reduce resource types, use single region

### Audience Questions

**Q**: "Does this modify my infrastructure?"
**A**: "No, Terraformer is read-only. It only discovers and documents resources."

**Q**: "Can I import from multiple regions?"
**A**: "Yes, select multiple regions in Step 3. Import handles them all."

**Q**: "What about secrets in RDS passwords?"
**A**: "Secrets stay in Terraform state, not in code. State is encrypted."

**Q**: "How often should I import?"
**A**: "Once to establish Terraform management. After that, use terraform apply."

---

## 🚀 Advanced Demo (Optional)

### Multi-Region Import

Show importing from 3 AWS regions simultaneously:
- us-east-1, us-west-2, eu-west-1
- Same VPC structure across regions
- Demonstrate multi-region resource management

### Repository Mode

Show saving as Repository instead of Template:
- Better for team collaboration
- Git version control ready
- Can push to remote Git repository

### Kubernetes Import

Quick demonstration of Kubernetes cluster import:
- Different provider, same wizard
- Namespace filtering
- Importing production apps

---

## 📝 Demo Checklist

Before demo:
- [x] Forge running and accessible
- [x] Terraformer installed and tested
- [x] AWS credentials added to Key Store
- [x] Test import completed successfully
- [x] Sample resources exist in AWS
- [x] Browser logged into Forge

During demo:
- [x] Clear, visible screen resolution
- [x] Slow down for key actions
- [x] Explain each wizard step
- [x] Highlight import summary
- [x] Show task progress
- [x] Review generated code

After demo:
- [x] Show terraform plan results
- [x] Demonstrate making a change
- [x] Apply change to infrastructure
- [x] Answer questions

---

## 🎁 Demo Conclusion

> "In just 10 minutes, we've taken an existing AWS environment with 47 resources,
> imported it into Terraform, and are now managing it as code - all through
> Forge's intuitive interface. No manual Terraform coding required. This same
> process works for Azure, GCP, and Kubernetes clusters."

**Key Takeaways**:
- ✅ Import existing infrastructure in minutes
- ✅ Support for 4 cloud providers, 160+ resource types
- ✅ Powerful filtering by tags, regions, resource types
- ✅ Integrated with Forge's task system and credentials
- ✅ Ready for production use

---

**Demo Version**: 1.0
**Target Audience**: DevOps teams, Platform engineers, Cloud architects
**Prerequisites**: Basic Terraform knowledge
**Duration**: 10-15 minutes

