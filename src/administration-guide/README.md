# Administration Guide

Welcome to the Forge Administration Guide. This guide provides comprehensive information for installing, configuring, and maintaining your Forge instance.

## What is Forge?

Forge is a modern, open-source web interface for running automation tasks with enterprise-grade compliance features. It is designed to be a lightweight, fast, and easy-to-use alternative to more complex automation platforms.

It allows you to securely manage and execute tasks for:
*   **Ansible** playbooks
*   **Terraform/OpenTofu** infrastructure-as-code
*   **Terragrunt** and **Terramate** for Terraform orchestration
*   **Packer** for golden image building
*   **Pulumi** for modern IaC
*   **PowerShell** and **Shell** scripts
*   **Python** scripts

## Core Features & Philosophy

Understanding Forge's design principles can help you get the most out of it:

*   **Lightweight and Performant**: Forge is written in **Go** and distributed as a **single binary file**. It has minimal resource requirements (CPU/RAM) and does not require external dependencies like Kubernetes, Docker, or a JVM. This makes it fast, efficient, and easy to deploy.

*   **Simple to Install and Maintain**: You can get Forge running in minutes. The Linux Service Installer provides automated setup with systemd service installation, TLS configuration, and Vault integration. Installation can be as simple as downloading the binary and running it. The simple architecture makes upgrades and maintenance straightforward.

*   **Flexible Deployment**: Run it as a binary, as a systemd service, or in a Docker container. It's suitable for everything from a personal homelab to enterprise environments.

*   **Self-Hosted and Secure**: Forge is a self-hosted solution. All your data, credentials, and logs remain on your own infrastructure, giving you full control. Credentials are always encrypted in the database. HashiCorp Vault integration is available for advanced secret management.

*   **Enterprise Compliance**: Built-in support for DISA STIG compliance, OpenSCAP scanning, policy packs, and multiple compliance frameworks (CIS, NIST, PCI-DSS).

*   **Powerful Integrations**: While simple, Forge supports powerful features like LDAP/OpenID authentication, detailed role-based access control (RBAC) per project, remote runners for scaling out task execution, golden image management with Packer, infrastructure import with Terraformer, and a full REST API for programmatic access.

## Quick Links

### Installation
- [Overview](./installation.md)
  - [Linux Service Installer](./installation/linux-service.md) - Recommended for Linux servers
  - [Docker](./installation/docker.md)
  - [Binary File](./installation/binary-file.md)
  - [Kubernetes (Helm chart)](./installation/k8s.md)
  - [Cloud Platforms](./installation/cloud.md)

### Configuration
- [Overview](./configuration.md)
  - [Configuration File](./configuration/config-file.md)
  - [Environment Variables](./configuration/env-vars.md)
  - [Interactive Setup](./configuration/cli.md)

### Database
- [Overview](./database.md)
  - [SQLite (Default)](./database/sqlite.md)
  - [PostgreSQL](./database/postgresql.md)
  - [MySQL](./database/mysql.md)
  - [BoltDB](./database/boltdb.md)

### Security
- [Overview](./security.md)
  - [TLS Configuration](./security/tls.md)
  - [Session Management](./security/sessions.md)
  - [Database Security](./security/database.md)
  - [Network Security](./security/network.md)
  - [Reverse Proxy](./security/reverse-proxy.md)
    - [NGINX](./security/nginx.md)
    - [Apache](./security/apache.md)

### Authentication
- [Overview](./authentication.md)
  - [LDAP](./authentication/ldap.md)
  - [OpenID Connect](./authentication/openid.md)
    - [GitHub](./authentication/openid/github.md)
    - [Google](./authentication/openid/google.md)
    - [GitLab](./authentication/openid/gitlab.md)
    - [Azure AD](./authentication/openid/azure.md)
    - [Keycloak](./authentication/openid/keycloak.md)
    - [Okta](./authentication/openid/okta.md)
    - [Authentik](./authentication/openid/authentik.md)
    - [Authelia](./authentication/openid/authelia.md)
    - [Gitea](./authentication/openid/gitea.md)
    - [Zitadel](./authentication/openid/zitadel.md)

### Secret Management
- [Overview](./secrets.md)
  - [HashiCorp Vault](./secrets/vault.md)
  - [OpenBao](./secrets/openbao.md)
  - [Local Encryption](./secrets/local.md)

### Operations
- [System Binaries](./binaries.md) - Manage Packer, Terraform, Ansible, etc.
- [Runners](./runners.md) - Remote execution agents
- [CLI Tools](./cli.md) - Command-line administration
- [Logging](./logging.md) - Log management and analysis
- [Notifications](./notifications.md) - Email, Slack, Teams, etc.
- [API](./api.md) - REST API reference

### Maintenance
- [Upgrading](./upgrading.md)
- [Troubleshooting](./troubleshooting.md)
