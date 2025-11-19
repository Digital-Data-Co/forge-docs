# Welcome to Forge

**Forge** is a modern, self-hosted web interface for managing popular DevOps tools with enterprise-grade compliance features.

## What is Forge?

Forge is a comprehensive automation platform that provides a unified interface for running Ansible playbooks, Terraform/OpenTofu infrastructure code, Packer builds, PowerShell scripts, and more. Built with enterprise compliance in mind, Forge combines powerful automation capabilities with built-in support for DISA STIG compliance, golden image management, and comprehensive security features.

### Key Differentiators

- **Enterprise Compliance First** - Built-in STIG compliance, OpenSCAP scanning, and multiple compliance framework support
- **Golden Image Management** - 16 pre-built STIG-hardened Packer templates for multi-cloud deployments
- **Self-Hosted & Secure** - All data, credentials, and logs remain on your infrastructure with HashiCorp Vault integration
- **Easy Installation** - Linux Service Installer with automated setup, TLS configuration, and dependency management
- **Developer-Friendly** - Modern web UI, REST API, and support for all popular DevOps tools

## Key Features

### Infrastructure as Code

Forge supports the full spectrum of infrastructure automation:

- **Ansible** - Playbook execution with STIG hardening roles and inventory management
- **Terraform/OpenTofu** - Infrastructure provisioning with remote state management and workspaces
- **Terragrunt** - DRY Terraform configurations and multi-environment management
- **Terramate** - Terraform stack orchestration and drift detection
- **Terraformer** - Import existing infrastructure from AWS, Azure, GCP, VMware, and Kubernetes
- **Pulumi** - Modern infrastructure as code with multiple programming languages
- **Packer** - Build golden images for multiple cloud providers with STIG hardening
- **PowerShell & Shell** - Execute scripts on Windows and Linux systems
- **Python** - Run Python scripts and automation workflows

### Golden Image Management

Build and manage pre-configured, hardened VM images:

- **16 Pre-Built Templates** - Production-ready STIG-hardened templates for RHEL 8/9, Ubuntu 22.04, and Windows Server 2022
- **Multi-Cloud Support** - AWS (AMIs), Azure (Managed Images), GCP (Compute Images), VMware vSphere
- **Visual Builder** - Create Packer templates without writing HCL code
- **HCL Editor** - Advanced template editing with validation and Git integration
- **Image Catalog** - Centralized registry of built images with search and filtering
- **STIG Hardening** - Automated DISA STIG compliance built into templates
- **Template Library** - Import and share templates across projects

### Compliance & Security

Enterprise-grade compliance management built into the platform:

- **STIG Viewer** - Interactive compliance finding management with status tracking
- **Policy Packs** - Curated Ansible playbooks for automated remediation
- **Remediation Coverage** - Track automated vs manual findings with coverage metrics
- **Manual Task Assignment** - Bulk assign templates to manual findings for automation
- **Multiple Frameworks** - Import multiple compliance standards per project (STIG, CIS, NIST, PCI-DSS)
- **CKL Export** - Generate STIG checklists for certification and reporting
- **OpenSCAP Integration** - SCAP content management and automated compliance scanning
- **Finding Management** - Track status (NotAFinding, Open, NotApplicable), attach screenshots, add comments
- **Screenshot Attachments** - Document compliance evidence inline

### Enterprise Features

Built for teams and organizations:

- **RBAC** - Fine-grained role-based access control (Owner, Manager, Task Runner, Reporter, Guest)
- **Audit Logging** - Complete audit trail of all actions and changes
- **Multi-Project** - Isolated project workspaces for teams and environments
- **Secret Management** - Encrypted credential storage with HashiCorp Vault integration
- **LDAP/OpenID Connect** - Enterprise authentication with support for 10+ providers
- **API-First** - Full REST API for automation and integration
- **Session Management** - Configurable session timeouts with inactivity-based logout
- **TLS 1.3** - Modern encryption with automatic certificate management

### Bare Metal Automation

Deploy and manage physical servers:

- **PXE Boot Deployment** - Network-based installation with kickstart/preseed
- **ISO Installation** - Custom bootable ISOs with embedded configuration
- **Golden Image Deployment** - Deploy pre-built STIG-hardened images to bare metal
- **BMC Management** - Out-of-band management for Dell iDRAC, HP iLO, and Redfish-compatible systems
- **GigaIO FabreX Integration** - Composable infrastructure management for dynamic resource allocation

### Infrastructure Import

Bring existing infrastructure into code:

- **Terraformer Integration** - Import existing infrastructure from AWS, Azure, GCP, VMware, Kubernetes
- **Resource Selection** - Choose specific resource types and regions
- **Tag Filtering** - Import only resources matching specific tags
- **Template/Repository Output** - Save as executable templates or Git repositories
- **State Generation** - Automatic Terraform state file generation

### Linux Service Installer

Streamlined installation for Linux servers:

- **Systemd Service** - Automatic service installation on Ubuntu, RHEL, Rocky, Alma, SLES
- **Encrypted Configuration** - Secrets stored in `/etc/forge/config.enc` with automatic key management
- **Automated TLS** - Built-in Let's Encrypt provisioning with certbot (self-signed fallback)
- **Vault Integration** - HashiCorp Vault installed, initialized, and configured automatically
- **Dependency Bootstrap** - Required CLI tools (Ansible, OpenSCAP, QEMU) auto-installed per distribution

## Architecture

Forge is built with a modern, cloud-native architecture:

- **Backend**: Go-based API server with RESTful endpoints
- **Frontend**: Vue.js web application with responsive design
- **Database**: SQLite (default), PostgreSQL, MySQL, or BoltDB support
- **Storage**: Local file system or cloud storage for uploads and logs
- **Secrets**: HashiCorp Vault or local encryption for credential storage
- **Deployment**: Single binary, Docker container, or Kubernetes deployment

### System Requirements

**Minimum:**
- CPU: 2 cores
- RAM: 2 GB
- Disk: 10 GB free space
- OS: Linux (x64, ARM64), macOS, Windows (via WSL)

**Recommended (Production):**
- CPU: 4+ cores
- RAM: 4+ GB
- Disk: 50+ GB free space (for logs, task files, images)
- Database: PostgreSQL or MySQL for multi-user environments
- Network: HTTPS with valid certificate

## Use Cases

### DevOps Teams
Run Ansible playbooks, deploy Terraform infrastructure, and manage infrastructure as code from a single unified interface. Schedule tasks, manage credentials securely, and collaborate across teams.

### Security & Compliance Teams
Import STIG checklists, track compliance findings, automate remediation with Policy Packs, and export CKL files for certification. Manage multiple compliance frameworks in one place.

### Infrastructure Teams
Build golden images with Packer, deploy to multiple cloud providers, import existing infrastructure with Terraformer, and manage bare metal servers with BMC integration.

### Platform Engineering
Provide self-service infrastructure automation to development teams, manage secrets with Vault, and maintain compliance across all infrastructure deployments.

## Quick Start

### 1. Installation

Choose your preferred installation method:

- **[Linux Service Installer](./administration-guide/installation/linux-service.md)** - Recommended for Linux servers (Ubuntu, RHEL, Rocky, Alma, SLES)
- **[Docker](./administration-guide/installation/docker.md)** - Fast setup with containers
- **[Binary File](./administration-guide/installation/binary-file.md)** - Manual installation
- **[Kubernetes](./administration-guide/installation/k8s.md)** - Helm chart deployment
- **[Cloud Platforms](./administration-guide/installation/cloud.md)** - AWS, Azure, GCP guidance

### 2. Initial Setup

1. Access the web UI at `http://localhost:3000` (or your configured address)
2. Create an admin user during initial setup
3. Configure database connection (SQLite is default)
4. Complete basic configuration

### 3. Create Your First Project

1. Create a new project
2. Add credentials to Key Store (SSH keys, cloud credentials)
3. Add an inventory with target hosts
4. Create a task template (Ansible, Terraform, Shell, etc.)
5. Run your first task!

For detailed steps, see the [Getting Started Guide](./user-guide/getting-started.md).

## Key Concepts

1. **Projects** - Collections of related resources, configurations, and tasks
2. **Task Templates** - Reusable definitions of tasks that can be executed on demand or scheduled
3. **Tasks** - Specific instances of jobs or operations executed by Forge
4. **Schedules** - Automate task execution at specified times or intervals
5. **Inventory** - Collections of target hosts (servers, VMs, containers) on which tasks will be executed
6. **Variable Groups** - Configuration contexts that hold sensitive information such as environment variables and secrets
7. **Compliance Frameworks** - Imported compliance standards (STIG, CIS, NIST, PCI-DSS) with findings and remediation tracking
8. **Golden Images** - Pre-configured, hardened VM/AMI images built with Packer

## Database Support

Forge supports multiple database backends:

- **SQLite** (Default) - Single-file database, zero configuration, perfect for development and small-medium deployments
- **PostgreSQL** - Recommended for enterprise deployments and high availability
- **MySQL** - Supported for existing MySQL infrastructure
- **BoltDB** - Embedded key/value database for simple deployments

### Why SQLite is the Default

- ✅ Zero configuration - just one file
- ✅ Full feature parity with PostgreSQL/MySQL
- ✅ Enterprise features (Vault integration, Secret Storage, etc.)
- ✅ Perfect for teams up to 50 users
- ✅ Easy backups (copy the file)
- ✅ No separate database server needed

## Documentation

### Getting Started
- **[Getting Started Guide](./user-guide/getting-started.md)** - Step-by-step introduction
- **[Installation Guide](./administration-guide/installation.md)** - Installation options
- **[Configuration Guide](./administration-guide/configuration.md)** - Configure Forge

### User Guides
- **[User Guide](./user-guide/README.md)** - Day-to-day usage and features
- **[Compliance Management](./user-guide/compliance/README.md)** - STIG and compliance workflows
- **[Golden Images](./user-guide/golden-images/README.md)** - Build and manage images
- **[Bare Metal Automation](./user-guide/bare-metal/README.md)** - Physical server deployment

### Administration
- **[Administration Guide](./administration-guide/README.md)** - Installation, configuration, security
- **[Security Guide](./administration-guide/security.md)** - Secure your installation
- **[Authentication](./administration-guide/authentication.md)** - LDAP and OpenID setup
- **[API Reference](./administration-guide/api.md)** - REST API documentation

### Support
- **[FAQ](./faq/README.md)** - Common questions and troubleshooting
- **[Troubleshooting](./administration-guide/troubleshooting.md)** - Resolve common issues

## Links

- **Source Code**: [https://github.com/Digital-Data-Co/forge](https://github.com/Digital-Data-Co/forge)
- **Issue Tracking**: [https://github.com/Digital-Data-Co/forge/issues](https://github.com/Digital-Data-Co/forge/issues)
- **Docker Images**: [https://ghcr.io/digital-data-co/forge](https://ghcr.io/digital-data-co/forge)
- **Contact**: [contact@digitaldata.co](mailto:contact@digitaldata.co)

## License

Forge is open-source software. See the [LICENSE](https://github.com/Digital-Data-Co/forge/blob/main/LICENSE) file for details.

---

**Ready to get started?** Check out the [Installation Guide](./administration-guide/installation.md) or [Getting Started Guide](./user-guide/getting-started.md).
