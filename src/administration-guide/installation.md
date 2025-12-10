# Installation

You can install Forge in multiple ways, depending on your operating system, environment, and preferences:

## Installation Methods

### Linux Service Installer (Recommended for Linux)

The Linux Service Installer provides the most complete setup experience for Linux servers. It automatically:
- Installs Forge as a systemd service
- Configures encrypted configuration storage
- Sets up TLS with Let's Encrypt (or self-signed fallback)
- Installs and configures HashiCorp Vault
- Installs required dependencies (Ansible, OpenSCAP, QEMU, etc.)

**Supported Distributions:**
- Ubuntu 20.04, 22.04, 24.04
- Red Hat Enterprise Linux 8, 9
- Rocky Linux 8, 9
- AlmaLinux 8, 9
- SUSE Linux Enterprise Server 15+

[Learn more »](./installation/linux-service.md)

### Docker

Run Forge as a container using Docker or Docker Compose. Ideal for fast setup, sandboxed environments, and CI/CD pipelines. Recommended for users who prefer infrastructure as code.

**Features:**
- Pre-built images with all dependencies
- STIG-hardened container images
- Read-only filesystem support
- Easy backup and restore

[Learn more »](./installation/docker.md)

### Binary File

Download a precompiled binary from the releases page. Great for manual installation or embedding in custom workflows. Works across Linux, macOS, and Windows (via WSL).

**Use Cases:**
- Quick testing and evaluation
- Custom deployment scripts
- Embedded in other systems

[Learn more »](./installation/binary-file.md)

### Kubernetes (Helm Chart)

Deploy Forge into a Kubernetes cluster using Helm. Best suited for production-grade, scalable infrastructure. Supports easy configuration and upgrades via Helm values.

**Features:**
- High availability support
- Horizontal scaling
- Persistent storage
- Service mesh integration

[Learn more »](./installation/k8s.md)

### Cloud Platforms

Guidance for deploying Forge to cloud platforms using VMs, containers, or Kubernetes with managed services.

**Supported Platforms:**
- AWS (EC2, ECS, EKS)
- Azure (VM, Container Instances, AKS)
- Google Cloud Platform (Compute Engine, GKE)
- Other cloud providers

[Learn more »](./installation/cloud.md)

## System Requirements

### Minimum Requirements
- **CPU**: 2 cores
- **RAM**: 2 GB
- **Disk**: 10 GB free space
- **OS**: Linux (x64, ARM64), macOS, Windows (via WSL)

### Recommended for Production
- **CPU**: 4+ cores
- **RAM**: 4+ GB
- **Disk**: 50+ GB free space (for logs, task files, images)
- **Database**: PostgreSQL or MySQL for multi-user environments
- **Network**: HTTPS with valid certificate

### Required Dependencies

Forge will automatically install these during Linux Service Installer setup:
- **Ansible** - For playbook execution
- **OpenSCAP** - For compliance scanning
- **QEMU** - For local Packer builds (optional)
- **Git** - For repository access
- **Terraform/OpenTofu** - Managed via System Binaries (optional)
- **Packer** - Managed via System Binaries (optional)

## Post-Installation

After installation, you'll need to:

1. **Access the Web UI** - Default: `http://localhost:3000`
2. **Complete Initial Setup** - Create admin user and configure database
3. **Configure Authentication** - Set up LDAP or OpenID if needed
4. **Add System Binaries** - Install Terraform, Packer, etc. via Admin Settings
5. **Create Your First Project** - Start using Forge!

## Next Steps

- [Configuration Guide](./configuration.md) - Configure Forge for your environment
- [Security Guide](./security.md) - Secure your installation
- [User Guide](../user-guide/README.md) - Learn how to use Forge
