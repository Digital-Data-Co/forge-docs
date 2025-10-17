# Golden Image Builder with Packer + QEMU

**Complete guide to building hardened, STIG-compliant VM images with Forge**

---

## Overview

Forge integrates **HashiCorp Packer** and **QEMU** to build "Golden Images" -
pre-configured, hardened VM/AMI images that can be deployed across any cloud
provider. These images can include DISA STIG hardening, custom software, and
configuration management.

### Key Features

- **Visual Builder**: Step-by-step wizard for image creation
- **HCL Editor**: Advanced Packer template editing
- **Git Integration**: Import templates from repositories
- **Image Catalog**: Centralized registry of built images
- **STIG Hardening**: Automated DISA STIG compliance
- **Multi-Cloud**: AWS, Azure, GCP, VMware, QEMU support
- **Binary Management**: Auto-download Packer and QEMU

---

## Quick Start

### 1. Setup System Binaries

Navigate to **Admin Settings > System Binaries**

**Install Packer:**
- Click "Install" on the Packer card
- Select version (e.g., 1.11.2)
- Choose installation path
- Click "Install"

**QEMU (for local builds):**
- macOS: `brew install qemu`
- Linux: `apt-get install qemu-system-x86` or `yum install qemu-kvm`
- Update path in admin settings

### 2. Add Cloud Provider Credentials

Navigate to **Project > Key Store**

**AWS Example:**
- Click "New Key"
- Name: "AWS Packer Credentials"
- Type: "aws"
- Enter: Access Key ID, Secret Access Key, Region

**Azure Example:**
- Type: "azure"
- Enter: Subscription ID, Client ID, Client Secret, Tenant ID

**GCP Example:**
- Type: "gcp"
- Enter: Project ID, Service Account JSON

### 3. Build Your First Golden Image

Navigate to **Project > Golden Images > Build New Image**

**Using Visual Builder:**

1. **Choose Cloud Provider**: Select AWS
2. **Select Builder**: amazon-ebs
3. **Configure**:
   - Template Name: "ubuntu-22-04-stig"
   - Region: us-east-1
   - Instance Type: t2.micro
   - Source AMI: ami-0c55b159cbfafe1f0
4. **Provisioning**:
   - ☑ Apply DISA STIG Hardening
   - ☑ Run Ansible Playbook (optional)
5. **Generate & Save**

The template is created! (Build execution coming in Phase 4)

---

## Visual Builder Modes

### 1. Visual Builder (Guided)

**Best for**: Beginners, quick standard images

**Steps**:
1. Choose cloud provider (AWS, Azure, GCP, VMware, QEMU)
2. Select builder type
3. Configure build settings (region, instance type, etc.)
4. Add provisioning (STIG, Ansible, scripts)
5. Generate HCL automatically

**Example**: Create AWS Ubuntu image with STIG hardening in 5 clicks

### 2. HCL Editor (Advanced)

**Best for**: Advanced users, complex configurations

**Features**:
- Full Packer HCL syntax support
- Template validation
- Import/export HCL
- Git repository sync

**Example Template**:
```hcl
packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  region        = "us-east-1"
  instance_type = "t2.micro"
  source_ami    = "ami-0c55b159cbfafe1f0"
  ami_name      = "forge-ubuntu-{{timestamp}}"
  ssh_username  = "ubuntu"
}

build {
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "shell" {
    scripts = [
      "scripts/xccdf_org.ssgproject.content_rule_accounts_password_pam_dcredit.sh",
      "scripts/xccdf_org.ssgproject.content_rule_configure_crypto_policy.sh",
    ]
  }

  provisioner "ansible" {
    playbook_file = "ansible/hardening.yml"
  }
}
```

### 3. Git Importer

**Best for**: Teams, version-controlled templates

**Process**:
1. Select repository with `.pkr.hcl` files
2. Choose template file
3. Import into Forge
4. Template stays synced with Git

---

## Image Catalog

### Browse Images

Navigate to **Golden Images > Image Catalog**

**Features**:
- Filter by cloud provider
- Filter by STIG compliance
- Search by name, version, or image ID
- View build manifests
- Copy image IDs to clipboard
- Link to build task logs

**Example View**:
```
Name              | Provider | Region    | Image ID         | STIG | Created
ubuntu-22-stig    | AWS      | us-east-1 | ami-0abc123     | ✓    | 2025-10-15
rhel-9-base       | Azure    | eastus    | /subscriptions/ | ✗    | 2025-10-14
debian-12-minimal | GCP      | us-cent1  | projects/.../   | ✓    | 2025-10-13
```

### Image Details

Click any image to view:
- Full manifest (JSON)
- Build metadata
- Packer template used
- Link to build task logs
- Custom metadata

### Using Images in Terraform

Images from the catalog can be referenced in Terraform templates:

```hcl
variable "ami_id" {
  description = "Golden image from Forge catalog"
  default     = "ami-0abc123"  # Copy from catalog
}

resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = "t3.micro"
}
```

---

## STIG Hardening Integration

### Automated STIG Compliance

Forge reuses DISA STIG remediation scripts from `deployment/docker/scripts/`:

**Available STIG Controls** (~50 scripts):
- Password policies (complexity, history, lockout)
- Account management (expiration, concurrent sessions)
- Crypto policies (TLS 1.2+, strong ciphers)
- System hardening (coredump, umask, permissions)
- And more...

### Enabling STIG in Visual Builder

1. In Step 4 (Provisioning), check: ☑ Apply DISA STIG Hardening
2. Template automatically includes STIG scripts
3. Built image marked as `stig_compliant = true`
4. STIG badge appears in catalog

### Manual STIG in HCL

```hcl
build {
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "shell" {
    scripts = [
      "scripts/stig/accounts_password_pam_dcredit.sh",
      "scripts/stig/accounts_password_pam_lcredit.sh",
      "scripts/stig/configure_crypto_policy.sh",
      # Add more STIG scripts as needed
    ]
  }
}
```

---

## Cloud Provider Guides

### AWS (Amazon EC2)

**Builder Types**:
- `amazon-ebs`: EBS-backed AMI (most common)
- `amazon-instance`: Instance store-backed AMI

**Configuration**:
```hcl
source "amazon-ebs" "example" {
  region        = "us-east-1"
  instance_type = "t2.micro"
  source_ami    = "ami-0c55b159cbfafe1f0"  # Ubuntu 22.04
  ami_name      = "forge-golden-{{timestamp}}"
  ssh_username  = "ubuntu"

  tags = {
    Name        = "Forge Golden Image"
    Environment = "Production"
    STIG        = "Compliant"
  }
}
```

**Credentials**: AWS Access Key ID + Secret Access Key

### Azure (Resource Manager)

**Builder Type**: `azure-arm`

**Configuration**:
```hcl
source "azure-arm" "example" {
  subscription_id = var.subscription_id

  os_type         = "Linux"
  image_publisher = "Canonical"
  image_offer     = "0001-com-ubuntu-server-jammy"
  image_sku       = "22_04-lts"

  location = "East US"
  vm_size  = "Standard_B2s"

  managed_image_name                = "forge-golden-{{timestamp}}"
  managed_image_resource_group_name = "packer-images"
}
```

**Credentials**: Azure Service Principal (Subscription, Client, Secret, Tenant)

### GCP (Google Compute Engine)

**Builder Type**: `googlecompute`

**Configuration**:
```hcl
source "googlecompute" "example" {
  project_id   = var.project_id
  zone         = "us-central1-a"
  machine_type = "n1-standard-1"

  source_image_family = "ubuntu-2204-lts"
  image_name          = "forge-golden-{{timestamp}}"

  ssh_username = "packer"
}
```

**Credentials**: GCP Service Account JSON

### VMware vSphere

**Builder Types**:
- `vsphere-iso`: Build from ISO
- `vsphere-clone`: Clone existing VM

**Configuration**:
```hcl
source "vsphere-clone" "example" {
  vcenter_server = var.vcenter_server
  username       = var.vcenter_username
  password       = var.vcenter_password

  datacenter = "DC1"
  cluster    = "Cluster1"
  datastore  = "datastore1"

  template = "ubuntu-22.04-template"
  vm_name  = "forge-golden-{{timestamp}}"

  CPUs     = 2
  RAM      = 4096

  ssh_username = "packer"
}
```

**Credentials**: vCenter username/password

### QEMU (Local Virtualization)

**Builder Type**: `qemu`

**Use Case**: Local testing before cloud builds

**Configuration**:
```hcl
source "qemu" "example" {
  iso_url      = "https://releases.ubuntu.com/22.04/ubuntu-22.04.3-live-server-amd64.iso"
  iso_checksum = "sha256:a4acfda10b18da50e2ec50ccaf860d7f20b389df8765611142305c0e911d16fd"

  disk_size = "40000M"
  memory    = 4096
  cpus      = 2

  ssh_username = "packer"
  ssh_password = "packer"

  shutdown_command = "echo 'packer' | sudo -S shutdown -P now"
}
```

**Requirements**: QEMU installed locally

---

## Provisioning Options

### 1. Shell Scripts

**Best for**: Simple commands, STIG scripts

```hcl
provisioner "shell" {
  scripts = [
    "scripts/install-docker.sh",
    "scripts/configure-firewall.sh",
  ]
}

provisioner "shell" {
  inline = [
    "sudo apt-get update",
    "sudo apt-get install -y nginx",
  ]
}
```

### 2. Ansible Playbooks

**Best for**: Complex configuration management

```hcl
provisioner "ansible" {
  playbook_file = "ansible/web-server.yml"

  extra_arguments = [
    "--extra-vars",
    "env=production"
  ]
}
```

**Forge Integration**: Select from project repositories

### 3. File Uploads

**Best for**: Configuration files, certificates

```hcl
provisioner "file" {
  source      = "configs/app.conf"
  destination = "/tmp/app.conf"
}

provisioner "shell" {
  inline = ["sudo mv /tmp/app.conf /etc/app/app.conf"]
}
```

### 4. Combined Provisioning

```hcl
build {
  sources = ["source.amazon-ebs.web"]

  # 1. Upload files
  provisioner "file" {
    source      = "configs/"
    destination = "/tmp/configs/"
  }

  # 2. Apply STIG hardening
  provisioner "shell" {
    scripts = [
      "scripts/stig/accounts_password_pam_dcredit.sh",
      "scripts/stig/configure_crypto_policy.sh",
    ]
  }

  # 3. Run Ansible
  provisioner "ansible" {
    playbook_file = "ansible/application-setup.yml"
  }

  # 4. Final cleanup
  provisioner "shell" {
    inline = [
      "sudo apt-get clean",
      "sudo rm -rf /tmp/*",
    ]
  }
}
```

---

## API Reference

### Packer Templates

**Create Template**:
```bash
POST /api/project/1/packer/templates
{
  "name": "Ubuntu 22.04 STIG",
  "cloud_provider": "aws",
  "builder_type": "amazon-ebs",
  "packer_config": "...",  # HCL content
  "source_type": "visual"
}
```

**List Templates**:
```bash
GET /api/project/1/packer/templates
```

**Validate Template**:
```bash
POST /api/project/1/packer/templates/5/validate
```

**Build Image** (Coming in Phase 4):
```bash
POST /api/project/1/packer/templates/5/build
{
  "access_key_id": 10,  # Cloud credentials
  "runner_id": null,    # Optional: specific runner
  "version": "1.0.0"    # Image version
}
```

### Golden Images

**List Images**:
```bash
GET /api/project/1/images?provider=aws
```

**Register Image Manually**:
```bash
POST /api/project/1/images
{
  "name": "My Golden Image",
  "version": "1.0.0",
  "cloud_provider": "aws",
  "region": "us-east-1",
  "image_id": "ami-0abc123",
  "stig_compliant": true
}
```

**Get Image Details**:
```bash
GET /api/project/1/images/15
```

### Binary Management

**List Binaries**:
```bash
GET /api/admin/binaries
```

**Install Binary**:
```bash
POST /api/admin/binaries/packer/install
{
  "version": "1.11.2",
  "path": "/usr/local/bin/packer"
}
```

---

## Use Cases

### Use Case 1: AWS Ubuntu with STIG Hardening

**Goal**: Create STIG-compliant Ubuntu 22.04 AMI for production workloads

**Steps**:
1. Use Visual Builder
2. Select AWS > amazon-ebs
3. Base: Ubuntu 22.04 LTS
4. Enable STIG hardening
5. Build

**Result**: STIG-compliant AMI ready for deployment

### Use Case 2: Multi-Region Image Deployment

**Goal**: Deploy same image to multiple AWS regions

**Approach**:
```hcl
source "amazon-ebs" "multi-region" {
  region = "us-east-1"
  # ... config ...

  ami_regions = [
    "us-east-1",
    "us-west-2",
    "eu-west-1"
  ]
}
```

**Result**: Image copied to 3 regions automatically

### Use Case 3: Development with QEMU

**Goal**: Test image builds locally before cloud deployment

**Steps**:
1. Install QEMU locally
2. Create template with QEMU builder
3. Build locally
4. Test image
5. Switch to AWS/Azure builder for production

**Benefits**:
- Faster iteration
- No cloud costs during development
- Same provisioning scripts

### Use Case 4: Ansible-Managed Web Server Image

**Goal**: Pre-configured web server with application installed

**Template**:
```hcl
build {
  sources = ["source.amazon-ebs.web"]

  provisioner "ansible" {
    playbook_file = "ansible/web-server-setup.yml"
    extra_arguments = [
      "--extra-vars",
      "app_version=2.1.0 env=production"
    ]
  }
}
```

**Ansible Playbook** (in repository):
```yaml
---
- name: Configure web server
  hosts: all
  tasks:
    - name: Install nginx
      apt:
        name: nginx
        state: present

    - name: Deploy application
      copy:
        src: app/
        dest: /var/www/html/

    - name: Configure firewall
      ufw:
        rule: allow
        port: '80,443'
```

---

## Best Practices

### 1. Version Your Images

**Use semantic versioning**:
- `1.0.0` - Initial production image
- `1.1.0` - Added new software
- `1.0.1` - Security patches

**In Packer**:
```hcl
locals {
  version = "1.0.0"
}

source "amazon-ebs" "app" {
  ami_name = "app-${local.version}-{{timestamp}}"

  tags = {
    Version = local.version
  }
}
```

### 2. Use Packer Variables

**Variables file** (`variables.pkr.hcl`):
```hcl
variable "region" {
  type    = string
  default = "us-east-1"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "environment" {
  type    = string
  default = "production"
}
```

**Reference in template**:
```hcl
source "amazon-ebs" "app" {
  region        = var.region
  instance_type = var.instance_type

  tags = {
    Environment = var.environment
  }
}
```

### 3. Tag Images Appropriately

**AWS Tags Example**:
```hcl
tags = {
  Name           = "Forge Golden Image"
  Environment    = "Production"
  STIG          = "Compliant"
  ManagedBy     = "Forge"
  CreatedBy     = "Packer"
  CreatedAt     = "{{timestamp}}"
  Repository    = "github.com/org/infra"
  Version       = "1.0.0"
}
```

**Benefits**:
- Easy filtering in cloud console
- Cost allocation
- Compliance tracking
- Automated cleanup policies

### 4. Test Images After Build

**Validation Script**:
```bash
#!/bin/bash
# Test newly built AMI

AMI_ID=$1

# Launch test instance
INSTANCE_ID=$(aws ec2 run-instances \
  --image-id $AMI_ID \
  --instance-type t2.micro \
  --query 'Instances[0].InstanceId' \
  --output text)

# Wait for running
aws ec2 wait instance-running --instance-ids $INSTANCE_ID

# Run tests
ssh -i key.pem ubuntu@$(aws ec2 describe-instances \
  --instance-ids $INSTANCE_ID \
  --query 'Reservations[0].Instances[0].PublicIpAddress' \
  --output text) \
  'bash -s' < tests/validate-stig.sh

# Terminate
aws ec2 terminate-instances --instance-ids $INSTANCE_ID
```

### 5. Maintain Image Catalog

**Regular Tasks**:
- ✅ Build monthly security updates
- ✅ Retire old images (6+ months)
- ✅ Document image contents
- ✅ Test images before production use

---

## Troubleshooting

### Packer Not Found

**Symptom**: "packer binary not found"

**Solution**:
1. Go to Admin Settings > System Binaries
2. Check Packer status
3. Click "Install" if missing
4. Verify path is correct

### Build Fails: Authentication Error

**Symptom**: "Error: could not authenticate"

**Solution**:
1. Verify cloud credentials in Key Store
2. Check credential type matches provider (AWS key for AWS builds)
3. Test credentials: `aws sts get-caller-identity` (AWS example)
4. Ensure credentials have required permissions (EC2, IAM for AWS)

### Build Slow or Timeout

**Symptom**: Build takes > 30 minutes

**Solutions**:
- Use larger instance types (t2.small vs t2.micro)
- Reduce provisioning scripts
- Use pre-existing images as base (don't start from ISO)
- Enable Packer caching

### QEMU Build Fails

**Symptom**: "qemu-system-x86_64: command not found"

**Solution**:
- macOS: `brew install qemu`
- Linux: `sudo apt-get install qemu-system-x86`
- Update path in Admin Settings
- Verify: `qemu-system-x86_64 --version`

### SSH Timeout During Build

**Symptom**: "Timeout waiting for SSH"

**Solutions**:
1. Check firewall rules allow SSH (port 22)
2. Verify SSH username matches AMI (ubuntu, ec2-user, admin)
3. Increase timeout in template:
   ```hcl
   ssh_timeout = "20m"
   ```
4. Check cloud-init logs on instance

---

## Examples

See `/examples/packer/` directory:

- `aws-ubuntu-stig.pkr.hcl` - AWS Ubuntu with STIG
- `azure-rhel-stig.pkr.hcl` - Azure RHEL with STIG
- `qemu-local.pkr.hcl` - Local QEMU build
- `multi-cloud.pkr.hcl` - Same image for AWS + Azure
- `with-ansible.pkr.hcl` - Ansible provisioning example

---

## Security Considerations

### 1. Credential Management

**DO**:
- ✅ Store credentials in Forge Key Store (encrypted)
- ✅ Use IAM roles when possible (AWS)
- ✅ Rotate credentials regularly
- ✅ Use least-privilege permissions

**DON'T**:
- ❌ Hardcode credentials in templates
- ❌ Commit credentials to Git
- ❌ Share credentials across environments

### 2. Image Hardening

**Required for Production**:
- ✅ Apply latest security patches
- ✅ Enable STIG hardening
- ✅ Remove unnecessary packages
- ✅ Configure firewalls
- ✅ Disable root SSH
- ✅ Enable audit logging

### 3. Image Distribution

**Best Practices**:
- Share images only within organization
- Use private AMIs/images (not public)
- Document image contents and versions
- Scan images for vulnerabilities before use

---

## Advanced Topics

### Multi-Stage Builds

**Build VM, export to multiple formats**:

```hcl
build {
  sources = ["source.qemu.base"]

  # Convert QEMU image to AWS
  post-processor "amazon-import" {
    ami_name = "imported-{{timestamp}}"
    region   = "us-east-1"
  }

  # Convert to Azure
  post-processor "azure-arm" {
    # ... config ...
  }
}
```

### Custom Post-Processors

**Tag and register image**:
```hcl
post-processor "manifest" {
  output = "manifest.json"
}

post-processor "shell-local" {
  inline = [
    "echo Built image: $(jq -r '.builds[0].artifact_id' manifest.json)",
    "AMI_ID=$(jq -r '.builds[0].artifact_id' manifest.json | cut -d':' -f2)",
    "aws ec2 create-tags --resources $AMI_ID --tags Key=Validated,Value=true"
  ]
}
```

### Packer Plugins

**Extend Packer functionality**:

```hcl
packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.0"
      source  = "github.com/hashicorp/amazon"
    }
    ansible = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/ansible"
    }
  }
}
```

---

## Roadmap

### Phase 4: Task Execution (In Progress)

- ⏳ Full task runner integration
- ⏳ Build log streaming
- ⏳ Remote execution on runners
- ⏳ Manifest parsing and auto-registration

### Phase 5: Polish (Coming Soon)

- ⏳ Terraform template integration
- ⏳ Auto-populate AMI IDs from catalog
- ⏳ Image versioning and comparison
- ⏳ Advanced filtering and search

### Future Enhancements

- Scheduled image rebuilds (monthly security updates)
- Image compliance scanning integration
- Cost estimation before build
- Build notifications (email, Slack)
- Image promotion workflows (dev → staging → prod)

---

## Support

**Documentation**:
- This guide: `docs/GOLDEN_IMAGES.md`
- Packer docs: https://developer.hashicorp.com/packer
- Examples: `/examples/packer/`

**Getting Help**:
- Check logs in Admin Settings > System Binaries
- Review build task logs
- Validate templates before building
- Test with QEMU locally first

---

**Last Updated**: October 15, 2025
**Forge Version**: v0.1.353+
**Packer Version**: 1.11.2+
**Status**: 70% Complete (Phases 1-3 done, 4-5 in progress)

