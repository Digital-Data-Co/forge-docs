# Golden Images Overview

Forge integrates HashiCorp Packer and QEMU to build "Golden Images" - pre-configured, hardened VM/AMI images that can be deployed across any cloud provider.

## What are Golden Images?

Golden Images are pre-built virtual machine images that include:
- Operating system installation
- Security hardening (STIG compliance)
- Application software
- Configuration management
- Testing and validation

These images can be deployed instantly across AWS, Azure, GCP, VMware, or used locally with QEMU.

## Key Benefits

- **Consistency** - Same image across all environments
- **Speed** - Deploy in minutes instead of hours
- **Security** - Pre-hardened with STIG compliance
- **Compliance** - Built-in compliance tracking
- **Versioning** - Track image versions and changes
- **Multi-Cloud** - Same image works across providers

## Features

### Visual Builder
Step-by-step wizard for creating Packer templates without writing HCL code.

### HCL Editor
Advanced editor with full Packer HCL syntax support, validation, and Git integration.

### Image Catalog
Centralized registry of all built images with filtering, search, and metadata.

### STIG Hardening
Automated DISA STIG compliance built into templates with 16 pre-built templates available.

### Multi-Cloud Support
Build images for:
- AWS (AMIs)
- Azure (Managed Images)
- GCP (Compute Images)
- VMware vSphere (Templates)
- QEMU (Local testing)

## Workflow

1. **Create Template** - Use Visual Builder or HCL Editor
2. **Configure Build** - Set cloud provider, region, instance type
3. **Add Provisioning** - STIG hardening, Ansible playbooks, scripts
4. **Build Image** - Execute Packer build
5. **View in Catalog** - Browse and manage built images
6. **Deploy** - Use image IDs in Terraform or cloud console

## Pre-Built Templates

Forge includes 16 production-ready, STIG-hardened Packer templates:

### AWS Templates
- RHEL 9 STIG-hardened AMI
- RHEL 8 STIG-hardened AMI
- Ubuntu 22.04 STIG-hardened AMI
- Windows Server 2022 STIG-hardened AMI

### Azure Templates
- RHEL 9 STIG-hardened managed image
- RHEL 8 STIG-hardened managed image
- Ubuntu 22.04 STIG-hardened managed image
- Windows Server 2022 STIG-hardened managed image

### GCP Templates
- RHEL 9 STIG-hardened GCP image
- RHEL 8 STIG-hardened GCP image
- Ubuntu 22.04 STIG-hardened GCP image
- Windows Server 2022 STIG-hardened GCP image

### VMware Templates
- RHEL 9 STIG-hardened vSphere template
- RHEL 8 STIG-hardened vSphere template
- Ubuntu 22.04 STIG-hardened vSphere template
- Windows Server 2022 STIG-hardened vSphere template

All templates are 100% self-contained with inline STIG hardening provisioners.

## Next Steps

- [Packer Templates](./templates.md) - Manage templates
- [Visual Builder](./visual-builder.md) - Create templates visually
- [HCL Editor](./hcl-editor.md) - Advanced editing
- [Image Catalog](./catalog.md) - Browse images
- [STIG Hardening](./stig-hardening.md) - Compliance features

