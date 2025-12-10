# Golden Images

Forge integrates HashiCorp Packer to build "Golden Images" - pre-configured, hardened VM/AMI images that can be deployed across any cloud provider.

## Overview

Golden Images are pre-built virtual machine images that include:
- Operating system installation
- Security hardening (STIG compliance)
- Application software
- Configuration management
- Testing and validation

## Key Features

- **Visual Builder** - Step-by-step wizard for image creation
- **HCL Editor** - Advanced Packer template editing
- **Git Integration** - Import templates from repositories
- **Image Catalog** - Centralized registry of built images
- **STIG Hardening** - Automated DISA STIG compliance
- **Multi-Cloud** - AWS, Azure, GCP, VMware, QEMU support
- **Binary Management** - Auto-download Packer and QEMU

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

The template is created! Click **Build** to create the image.

## Documentation

- [Overview](./overview.md) - Detailed introduction
- [Packer Templates](./templates.md) - Template management
- [Visual Builder](./visual-builder.md) - Guided image creation
- [HCL Editor](./hcl-editor.md) - Advanced editing
- [Image Catalog](./catalog.md) - Browse built images
- [STIG Hardening](./stig-hardening.md) - Automated compliance
- [Cloud Providers](./cloud-providers.md) - Multi-cloud support
  - [AWS](./aws.md)
  - [Azure](./azure.md)
  - [GCP](./gcp.md)
  - [VMware](./vmware.md)
  - [QEMU](./qemu.md)

## Related Documentation

- [Packer Task Templates](../task-templates/packer.md) - Packer execution
- [STIG Compliance](../compliance/stig.md) - Compliance management
- [Bare Metal Deployment](../bare-metal/golden-images.md) - Deploy to bare metal

