# Terramate Integration Guide
**Forge Version:** v0.1.347+
**Last Updated:** October 14, 2025

---

## Overview

Forge integrates Terramate CLI to provide powerful stack-based orchestration for
Terraform, OpenTofu, and Terragrunt. This integration brings enterprise-grade
infrastructure management capabilities while maintaining Forge's familiar web interface.

**Key Benefits:**
- **Stack-Based Architecture**: Break large monolithic states into manageable pieces
- **Code Generation**: Keep configurations DRY with Terramate's HCL generation
- **Change Detection**: Only execute stacks with actual Git changes
- **Dependency Management**: Automatic execution ordering based on dependencies
- **Forge Integration**: Use Forge's UI, auth, scheduling, and audit trails

---

## Prerequisites

### 1. Terramate CLI Installation

Terramate must be installed on the Forge server.

**Docker (Recommended):**
Terramate v0.14.7 is pre-installed in Forge Docker images v0.1.346+

**Manual Installation:**
```bash
# Linux/macOS
wget https://github.com/terramate-io/terramate/releases/latest/download/terramate_linux_amd64.tar.gz
tar -xzf terramate_linux_amd64.tar.gz
sudo mv terramate /usr/local/bin/
sudo chmod +x /usr/local/bin/terramate

# Verify
terramate version
```

### 2. Repository Setup

Your Git repository should contain Terramate stacks:

```bash
# Initialize a new stack
cd your-repo
terramate create stacks/prod/vpc

# Or organize existing Terraform code as stacks
terramate create stacks/dev/network
terramate create stacks/dev/compute
```

---

## Getting Started

### Step 1: Configure Terramate (Admin)

1. Navigate to **Admin Settings** → **Terramate** tab
2. Ensure "Enable Terramate" is checked
3. Set binary path (default: `/usr/local/bin/terramate`)
4. Click **"Validate Installation"** to confirm Terramate is accessible
5. Click **"Save Configuration"**

### Step 2: Import Terramate Stacks

1. Go to your **Project**
2. Navigate to **Repositories** or create a new repository with Terramate stacks
3. Go to **Terramate Import** (from project menu or direct URL)
4. Select your repository from the dropdown
5. Click **"Discover Stacks"**
6. Select stacks to import (checkboxes)
7. Click **"Import X Selected Stacks"**

**Result:** Each stack becomes a Forge Template with proper configuration

### Step 3: View Stack Information

1. Go to **Templates** in your project
2. Click on any imported Terramate stack
3. Navigate to **Details** tab
4. See Terramate Stack Information card with:
   - Stack path and IaC tool
   - Code generation status
   - Change detection setting
   - Tags and dependencies

### Step 4: Preview Generated Code

1. In the stack details, click **"View Generated Code"**
2. See all files Terramate will generate
3. Use **Side-by-Side** view to compare existing vs generated
4. Click **Copy** to copy generated code to clipboard

### Step 5: Execute Stacks

1. Click **"Run"** on any Terramate stack template
2. Terramate will:
   - Generate code (if enabled)
   - Check for changes (if change detection enabled)
   - Execute terraform/tofu/terragrunt in the stack
   - Stream output to Forge task logs

---

## Configuration Options

### Stack Parameters

When you import a stack, these parameters are configured:

**Stack Path** (Required)
- Relative path from repository root
- Example: `stacks/prod/vpc`

**Enable Code Generation** (Default: true)
- Runs `terramate generate` before execution
- Generates HCL, JSON, or YAML based on your `.tm` files

**Change Detection** (Default: false)
- Uses Git to detect if stack has changes
- Skips execution if no changes detected
- Great for CI/CD optimization

**Terraform Binary** (Default: terraform)
- Options: `terraform`, `tofu`, `terragrunt`
- Matches your Template App type

**Tags** (Optional)
- Terramate tags for filtering and organization

**Dependencies** (Optional)
- Other stack paths this stack depends on
- Ensures correct execution order

---

## Features

### 1. Code Generation

**What It Does:**
Terramate can generate Terraform code to reduce duplication:

**Example: Backend Configuration**
```hcl
# stacks/prod/vpc/terramate.tm
generate_hcl "backend.tf" {
  content {
    terraform {
      backend "s3" {
        bucket = "my-terraform-state"
        key    = "prod/vpc/terraform.tfstate"
        region = "us-east-1"
      }
    }
  }
}
```

**In Forge:**
1. Navigate to stack template → Details
2. Click "View Generated Code"
3. See `backend.tf` with generated content
4. Compare with existing file (if any)

### 2. Change Detection

**What It Does:**
Only runs stacks that have changed according to Git

**Example Workflow:**
1. Enable "Change Detection" in stack configuration
2. Run stack  → Executes because it has changes
3. Run again without changes → Skips execution (logs "No changes detected")
4. Modify stack files → Next run executes again

**Benefits:**
- Faster CI/CD pipelines
- Reduced unnecessary executions
- Cost savings on cloud operations

### 3. Dependency Management

**What It Does:**
Automatically orders stack execution based on dependencies

**Example: VPC → Subnet → EC2**
```hcl
# stacks/prod/network/terramate.tm
stack {
  name        = "Production VPC"
  description = "VPC for production environment"
}

# stacks/prod/subnets/terramate.tm
stack {
  name  = "Production Subnets"
  after = ["stacks/prod/network"]  # Depends on VPC
}

# stacks/prod/ec2/terramate.tm
stack {
  name  = "Production EC2 Instances"
  after = ["stacks/prod/subnets"]  # Depends on subnets
}
```

**In Forge:**
- Dependencies displayed in stack details
- Execution follows dependency order automatically
- View dependency graph: **Project** → **Terramate** → **Dependency Graph**

### 4. Dependency Graph Visualization

1. Navigate to your project
2. Use Terramate Dependency Graph view
3. See stacks organized by execution level:
   - **Level 0**: No dependencies (runs first)
   - **Level 1**: Depends on Level 0
   - **Level 2**: Depends on Level 1, etc.
4. Each stack card shows dependencies and tags

---

## Common Workflows

### Workflow 1: Migrate Existing Terraform

**Before:** Single large Terraform directory

**After:** Organized stacks

```bash
# 1. Create stacks from existing code
cd your-terraform-repo
terramate create stacks/networking
terramate create stacks/database
terramate create stacks/application

# 2. Move Terraform files into stacks
mv network.tf stacks/networking/
mv database.tf stacks/database/
mv application.tf stacks/application/

# 3. Add terramate.tm files
cat > stacks/database/terramate.tm <<EOF
stack {
  name = "Database Layer"
  after = ["stacks/networking"]
}
EOF

# 4. Import in Forge
# Go to Project → Terramate Import → Discover → Import
```

### Workflow 2: Share Configuration Across Stacks

**Use Globals and Code Generation:**

```hcl
# root/terramate.tm (repository root)
globals {
  region      = "us-east-1"
  environment = "production"
  tags = {
    ManagedBy   = "Terramate"
    Environment = "Production"
  }
}

# stacks/prod/vpc/generate.tm
generate_hcl "tags.tf" {
  content {
    locals {
      common_tags = tm_merge(
        global.tags,
        {
          Stack = "vpc"
        }
      )
    }
  }
}
```

**Result:** All stacks get consistent tags without duplication

### Workflow 3: CI/CD with Change Detection

**Enable change detection for all stacks:**

1. Import stacks with "Change Detection" enabled
2. Configure CI/CD to run Forge templates
3. Only modified stacks execute on each commit
4. Faster pipelines, lower costs

---

## Advanced Features

### Multi-Environment Support

**Pattern: Separate stacks per environment**

```
stacks/
  dev/
    network/
    database/
    application/
  staging/
    network/
    database/
    application/
  prod/
    network/
    database/
    application/
```

**In Forge:**
- Import all stacks
- Use tags to organize (dev, staging, prod)
- Filter templates by tags
- Schedule different environments separately

### Dynamic Code Generation

**Generate provider configurations:**

```hcl
# _common/provider.tm
generate_hcl "provider.tf" {
  condition = tm_can(global.aws_region)

  content {
    provider "aws" {
      region = global.aws_region

      default_tags {
        tags = global.common_tags
      }
    }
  }
}
```

**Result:** Consistent provider configs across all stacks

---

## Troubleshooting

### Stack Discovery Fails

**Error:** "Failed to discover stacks: terramate CLI not installed"

**Solution:**
1. Verify Terramate is installed: `terramate version`
2. Check binary path in Admin Settings → Terramate
3. Ensure path is correct (default: `/usr/local/bin/terramate`)
4. Validate installation in admin settings

### No Stacks Found

**Error:** "No Terramate stacks found in repository"

**Causes:**
- Repository doesn't contain Terramate stacks
- Missing `stack` blocks in `.tm` files
- Not committed to Git

**Solution:**
1. Initialize stacks: `terramate create stacks/my-stack`
2. Add `terramate.tm` with stack block:
   ```hcl
   stack {
     name = "My Stack"
     description = "Description here"
   }
   ```
3. Commit to repository
4. Re-discover in Forge

### Code Generation Not Working

**Issue:** Generated code doesn't appear

**Checklist:**
- ✓ "Enable Code Generation" is checked in stack configuration
- ✓ `.tm` files contain `generate_hcl` or `generate_file` blocks
- ✓ Generation blocks have `path` and `content` defined
- ✓ Repository is up to date (pull latest changes)

### Circular Dependencies

**Error:** "Circular dependency detected at stack: X"

**Solution:**
Review stack dependencies:
1. Check `after` relationships in `terramate.tm` files
2. Remove circular references (A → B → A)
3. Reorganize dependency chain

---

## Best Practices

### 1. Stack Organization

**Good:**
```
stacks/
  shared/common-tags/
  networking/vpc/
  networking/subnets/
  compute/ec2/
  storage/s3/
```

**Why:** Clear hierarchy, easy to understand dependencies

### 2. Use Globals for Common Values

```hcl
# root/globals.tm
globals {
  region = "us-east-1"
  account_id = "123456789012"
  environment = "production"
}
```

**Why:** Single source of truth, easy updates

### 3. Enable Change Detection for CI/CD

**Why:**
- Skip unchanged stacks
- Faster pipelines
- Lower costs

**When to Disable:**
- Manual deployments
- Force-apply scenarios
- Testing all stacks

### 4. Tag Your Stacks

```hcl
stack {
  name = "Production VPC"
  tags = ["prod", "networking", "critical"]
}
```

**Why:** Easy filtering, better organization in Forge UI

### 5. Document Dependencies

```hcl
stack {
  name = "Application Servers"
  description = "EC2 instances for app tier"
  after = [
    "stacks/prod/networking",  # VPC must exist
    "stacks/prod/database",    # DB must exist
  ]
}
```

**Why:** Clear execution order, prevents failures

---

## Comparison: Traditional vs Terramate

| Feature | Traditional Terraform | With Terramate |
|---------|----------------------|----------------|
| State Management | Single large state | Multiple small states |
| Code Reuse | Copy-paste or modules | Code generation |
| Blast Radius | Entire infrastructure | Individual stacks |
| Execution | Run everything | Run only changed |
| Dependencies | Manual ordering | Automatic orchestration |
| CI/CD Time | Long (runs all) | Fast (runs changes) |

---

## Migration Guide

### From Monolithic Terraform to Stacks

**Step 1: Identify Logical Boundaries**
```
Current: main.tf (500 lines)
  - VPC resources
  - Database resources
  - Application resources

Plan: Split into 3 stacks
  - stacks/networking (VPC)
  - stacks/database (RDS, etc.)
  - stacks/application (EC2, ALB)
```

**Step 2: Create Stack Structure**
```bash
terramate create stacks/networking
terramate create stacks/database
terramate create stacks/application
```

**Step 3: Move Resources**
```bash
# Move VPC resources to networking stack
mv vpc.tf stacks/networking/
mv subnets.tf stacks/networking/

# Move database resources
mv database.tf stacks/database/
mv rds.tf stacks/database/

# Move application resources
mv ec2.tf stacks/application/
mv alb.tf stacks/application/
```

**Step 4: Add Dependencies**
```hcl
# stacks/database/terramate.tm
stack {
  name = "Database Layer"
  after = ["stacks/networking"]  # Needs VPC
}

# stacks/application/terramate.tm
stack {
  name = "Application Layer"
  after = [
    "stacks/networking",  # Needs VPC
    "stacks/database",    # Needs DB
  ]
}
```

**Step 5: Extract Common Code**
```hcl
# root/globals.tm
globals {
  region = "us-east-1"
  environment = "production"
}

# stacks/networking/generate.tm
generate_hcl "backend.tf" {
  content {
    terraform {
      backend "s3" {
        bucket = "my-state-bucket"
        key    = "networking/terraform.tfstate"
        region = global.region
      }
    }
  }
}
```

**Step 6: Import to Forge**
1. Commit all changes to Git
2. Forge → Project → Terramate Import
3. Discover and import stacks
4. Execute in dependency order

---

## Examples

### Example 1: Simple Stack with Code Generation

**Directory Structure:**
```
stacks/
  prod/
    database/
      main.tf
      variables.tf
      terramate.tm
      generate.tm
```

**terramate.tm:**
```hcl
stack {
  name        = "Production Database"
  description = "RDS database for production"
  tags        = ["prod", "database"]
}
```

**generate.tm:**
```hcl
generate_hcl "backend.tf" {
  content {
    terraform {
      backend "s3" {
        bucket = "terraform-state-prod"
        key    = "database/terraform.tfstate"
        region = "us-east-1"
      }
    }
  }
}

generate_hcl "tags.tf" {
  content {
    locals {
      common_tags = {
        Environment = "production"
        ManagedBy   = "Terramate"
        Stack       = "database"
      }
    }
  }
}
```

**In Forge:**
- Stack auto-generates backend.tf and tags.tf
- Preview in "View Generated Code"
- Execute via Forge UI

### Example 2: Multi-Stack with Dependencies

**Stack Structure:**
```
stacks/
  shared/
    vpc/           # Level 0 (no dependencies)
  prod/
    database/      # Level 1 (depends on vpc)
    application/   # Level 2 (depends on database and vpc)
```

**shared/vpc/terramate.tm:**
```hcl
stack {
  name = "Shared VPC"
  description = "VPC shared across environments"
  tags = ["networking", "shared"]
}
```

**prod/database/terramate.tm:**
```hcl
stack {
  name = "Production Database"
  after = ["stacks/shared/vpc"]
  tags = ["prod", "database"]
}
```

**prod/application/terramate.tm:**
```hcl
stack {
  name = "Production Application"
  after = [
    "stacks/shared/vpc",
    "stacks/prod/database",
  ]
  tags = ["prod", "application"]
}
```

**Execution in Forge:**
1. VPC runs first (Level 0)
2. Database runs after VPC completes (Level 1)
3. Application runs after both complete (Level 2)

**View:** Dependency Graph shows this hierarchy visually

---

## Integration with Forge Features

### Scheduling

- Schedule Terramate stacks like any other template
- Useful with change detection: "Apply changed stacks daily"
- Dependencies execute in order automatically

### Access Control

- Standard Forge RBAC applies
- Project members can execute assigned stacks
- Admin can manage all stacks

### Audit Trail

- All stack executions logged
- Code generation steps captured
- Change detection results recorded

### Notifications

- Slack/email alerts on stack completion
- Failure notifications
- Same as other Forge templates

---

## FAQ

**Q: Can I use Terramate stacks and regular Terraform templates together?**
A: Yes! They coexist perfectly. Terramate stacks are just another template type.

**Q: Do I need Terramate Cloud?**
A: No. Forge integrates with the free, open-source Terramate CLI.
Terramate Cloud is optional.

**Q: Can I convert a regular Terraform template to a Terramate stack?**
A: Yes. Create a Terramate stack in your repository, then re-import. Or manually
change the inventory type to `terramate-stack` and configure parameters.

**Q: What happens if Terramate CLI is not installed?**
A: Stack execution will fail with a clear error message. Install Terramate and
validate in Admin Settings.

**Q: Can I disable Terramate?**
A: Yes, in Admin Settings → Terramate → Disable. Existing stacks will fail to
execute until re-enabled.

**Q: How do I update Terramate?**
A: Download the new version, replace the binary, and validate in Admin Settings.
For Docker, update to the latest Forge image.

**Q: Does change detection work in Forge runners?**
A: Yes, as long as the runner has access to the Git repository with full history.

---

## Limitations

- **Local Execution Only**: Terramate runs on the Forge server or runners
(not in Terramate Cloud)
- **Git Required**: Change detection requires Git repository
- **No Terramate Cloud**: Doesn't integrate with Terramate Cloud features
(drift detection, asset management, etc.)
- **CLI Version**: Uses installed Terramate CLI version (not auto-updated)

---

## Support

**Terramate Documentation:**
- Official Docs: https://terramate.io/docs
- GitHub: https://github.com/terramate-io/terramate
- Discord: Terramate Community

**Forge Support:**
- Issues: GitHub Forge repository
- Documentation: Forge docs
- Admin Settings: Validate Installation for diagnostics

---

## Changelog

**v0.1.346 (Phase 1):**
- Terramate CLI integration
- Stack discovery and import
- Basic execution support
- Admin configuration

**v0.1.347 (Phase 2):**
- Code generation preview
- Change detection UI
- Stack information display
- HCL configuration parser

**v0.1.348 (Phase 3):**
- Dependency graph visualization
- Topological sort for execution ordering
- Bulk execution support

---

**Version:** v0.1.348
**Last Updated:** October 14, 2025

