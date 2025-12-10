# User Guide

Learn how to use Forge day-to-day: create projects, run tasks, manage compliance, build golden images, and more.

## Getting Started

If you're new to Forge, start here:

1. **[Getting Started](./getting-started.md)** - Overview of key concepts and first steps
2. **[Projects](./projects.md)** - Understanding projects and how to create them
3. **[Task Templates](./task-templates/README.md)** - Create reusable task definitions
4. **[Running Your First Task](./tasks.md)** - Execute tasks and view results

## Core Features

### Projects & Organization
- **[Projects](./projects.md)** - Organize your work with projects
- **[Teams](./teams.md)** - Manage team members and permissions
- **[Repositories](./repositories.md)** - Connect Git repositories
- **[Key Store](./key-store.md)** - Manage credentials securely
- **[Inventories](./inventories.md)** - Define target hosts
- **[Variable Groups](./variable-groups.md)** - Store environment variables and secrets

### Task Execution
- **[Task Templates](./task-templates/README.md)** - Create reusable task definitions
  - [Ansible](./task-templates/ansible.md) - Run Ansible playbooks
  - [Terraform/OpenTofu](./task-templates/terraform.md) - Infrastructure provisioning
  - [Terragrunt](./task-templates/terragrunt.md) - DRY Terraform configurations
  - [Terramate](./task-templates/terramate.md) - Terraform stack orchestration
  - [Packer](./task-templates/packer.md) - Build golden images
  - [Pulumi](./task-templates/pulumi.md) - Modern IaC
  - [Shell/Bash](./task-templates/shell.md) - Execute shell scripts
  - [PowerShell](./task-templates/powershell.md) - Run PowerShell scripts
  - [Python](./task-templates/python.md) - Execute Python scripts
- **[Tasks](./tasks.md)** - Run and monitor task execution
- **[Schedules](./schedules.md)** - Automate task execution

## Enterprise Features

### Compliance & Security
- **[Compliance Overview](./compliance/README.md)** - Introduction to compliance features
- **[STIG Compliance](./compliance/stig.md)** - DISA STIG compliance management
  - [STIG Viewer](./compliance/stig-viewer.md) - Interactive finding management
  - [STIG Import](./compliance/stig-import.md) - Import STIG checklists
  - [Policy Packs](./compliance/policy-packs.md) - Automated remediation
  - [Remediation Coverage](./compliance/remediation.md) - Track automation coverage
  - [Manual Task Assignment](./compliance/manual-assignment.md) - Bulk assignment
- **[OpenSCAP Compliance](./compliance/openscap.md)** - SCAP-based compliance scanning
  - [SCAP Content](./compliance/openscap/content.md) - Upload and manage SCAP files
  - [Compliance Policies](./compliance/openscap/policies.md) - Create scan policies
  - [Compliance Scans](./compliance/openscap/scans.md) - Run compliance scans
  - [Compliance Reports](./compliance/openscap/reports.md) - View scan results
- **[Compliance Frameworks](./compliance/frameworks.md)** - Multiple framework support
  - [DISA STIG](./compliance/frameworks/stig.md)
  - [CIS Benchmarks](./compliance/frameworks/cis.md)
  - [NIST 800-53](./compliance/frameworks/nist.md)
  - [PCI-DSS](./compliance/frameworks/pci.md)

### Golden Image Management
- **[Golden Images Overview](./golden-images/README.md)** - Introduction to golden images
- **[Packer Templates](./golden-images/templates.md)** - Manage Packer templates
- **[Visual Builder](./golden-images/visual-builder.md)** - Create templates visually
- **[HCL Editor](./golden-images/hcl-editor.md)** - Advanced template editing
- **[Image Catalog](./golden-images/catalog.md)** - Browse built images
- **[STIG Hardening](./golden-images/stig-hardening.md)** - Automated compliance
- **[Cloud Providers](./golden-images/cloud-providers.md)** - Multi-cloud support
  - [AWS](./golden-images/aws.md)
  - [Azure](./golden-images/azure.md)
  - [GCP](./golden-images/gcp.md)
  - [VMware](./golden-images/vmware.md)
  - [QEMU](./golden-images/qemu.md)

### Bare Metal Automation
- **[Bare Metal Overview](./bare-metal/README.md)** - Introduction to bare metal automation
- **[PXE Boot Deployment](./bare-metal/pxe.md)** - Network-based installation
- **[ISO Installation](./bare-metal/iso.md)** - Custom ISO deployment
- **[Golden Image Deployment](./bare-metal/golden-images.md)** - Image-based deployment
- **[BMC Management](./bare-metal/bmc.md)** - Out-of-band management
  - [Dell iDRAC](./bare-metal/bmc/idrac.md)
  - [HP iLO](./bare-metal/bmc/ilo.md)
  - [Redfish](./bare-metal/bmc/redfish.md)
- **[GigaIO Integration](./bare-metal/gigaio.md)** - Composable infrastructure

### Infrastructure Import
- **[Terraformer Overview](./import/README.md)** - Import existing infrastructure
- **[Terraformer](./import/terraformer.md)** - Infrastructure import tool
  - [AWS Import](./import/terraformer/aws.md)
  - [Azure Import](./import/terraformer/azure.md)
  - [GCP Import](./import/terraformer/gcp.md)
  - [Kubernetes Import](./import/terraformer/kubernetes.md)
- **[Import Workflows](./import/workflows.md)** - Best practices

### Integrations
- **[Integrations Overview](./integrations.md)** - Connect external systems
- **[Webhooks](./integrations/webhooks.md)** - HTTP webhook triggers
- **[GitHub](./integrations/github.md)** - GitHub integration
- **[Bitbucket](./integrations/bitbucket.md)** - Bitbucket integration
- **[Terramate](./integrations/terramate.md)** - Terramate orchestration
- **[Terraformer](./integrations/terraformer.md)** - Infrastructure import
- **[GigaIO FabreX](./integrations/gigaio.md)** - Composable infrastructure

## Quick Reference

### Common Workflows

**Running an Ansible Playbook:**
1. Create a project
2. Add a repository with your playbook
3. Create an Ansible task template
4. Add inventory and credentials
5. Run the task

**Building a Golden Image:**
1. Create a project
2. Add cloud provider credentials
3. Use Visual Builder or import a Packer template
4. Configure STIG hardening (optional)
5. Build the image
6. View in Image Catalog

**Managing STIG Compliance:**
1. Import a STIG checklist (CKL file)
2. Install a Policy Pack for automated remediation
3. Assign remediation templates to manual findings
4. Run remediation tasks
5. Export updated CKL for certification

**Importing Infrastructure:**
1. Configure Terraformer in Admin Settings
2. Add cloud provider credentials
3. Use Import Infrastructure wizard
4. Select resources and filters
5. Save as Template or Repository

## Next Steps

- **[Administration Guide](../administration-guide/README.md)** - System administration
- **[FAQ](../faq/README.md)** - Common questions and troubleshooting
