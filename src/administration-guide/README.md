# Administration Guide

Welcome to the Forge UI Administration Guide. This guide provides comprehensive information for installing, configuring, and maintaining your Forge instance.

## What is Forge UI?

Forge UI is a modern, open-source web interface for running automation tasks. It is designed to be a lightweight, fast, and easy-to-use alternative to more complex automation platforms.

It allows you to securely manage and execute tasks for:
*   **Ansible** playbooks
*   **Terraform/OpenTofu** infrastructure-as-code
*   **PowerShell** and **Shell** scripts
*   **Python** scripts

## Core Features & Philosophy

Understanding Forge's design principles can help you get the most out of it:

*   **Lightweight and Performant**: Forge is written in **Go** and distributed as a **single binary file**. It has minimal resource requirements (CPU/RAM) and does not require external dependencies like Kubernetes, Docker, or a JVM. This makes it fast, efficient, and easy to deploy.
*   **Simple to Install and Maintain**: You can get Forge running in minutes. Installation can be as simple as downloading the binary and running it. The simple architecture makes upgrades and maintenance straightforward.
*   **Flexible Deployment**: Run it as a binary, as a systemd service, or in a Docker container. It's suitable for everything from a personal homelab to enterprise environments.
*   **Self-Hosted and Secure**: Forge is a self-hosted solution. All your data, credentials, and logs remain on your own infrastructure, giving you full control. Credentials are always encrypted in the database.
*   **Powerful Integrations**: While simple, Forge supports powerful features like LDAP/OpenID authentication, detailed role-based access control (RBAC) per project, remote runners for scaling out task execution, and a full REST API for programmatic access.

This guide will walk you through setting up and managing these features for your specific needs.

<!-- ## Start here

- Installation options: package manager, Docker/Compose, binary, Kubernetes (Helm), Snap (deprecated)
- Post-install configuration: config file, environment variables, interactive CLI setup
- Security essentials: reverse proxy, TLS, database and network hardening
- Authentication: LDAP and OpenID Connect providers
- Operations: CLI, runners, logs, notifications
- Maintenance: upgrading and troubleshooting -->

## Quick links

- Installation: [Overview](./installation.md)
  - [Package manager](./installation/package-manager.md)
  - [Docker](./installation/docker.md)
  - [Binary file](./installation/binary-file.md)
  - [Kubernetes (Helm chart)](./installation/k8s.md)
  - [Cloud](./installation/cloud.md)
  - [Snap (deprecated)](./installation/snap.md)
  - [Manual installation](./installation_manually.md)
- Configuration: [Overview](./configuration.md)
  - [Configuration file](./configuration/config-file.md)
  - [Environment variables](./configuration/env-vars.md)
  - [Interactive setup](./configuration/cli.md)
  - [Snap configuration](./configuration/snap.md)
- Security: [Overview](./security.md)
  - [Database security](./security/database.md)
  - [Network security](./security/network.md)
  - [NGINX config](./security/nginx.md)
  - [Apache config](./security/apache.md)
  - [Kerberos](./security/kerberos.md)
- Authentication:
  - [LDAP](./ldap.md)
  - [OpenID](./openid.md)
    - [GitHub](./openid/github.md)
    - [Google](./openid/google.md)
    - [GitLab](./openid/gitlab.md)
    - [Gitea](./openid/gitea.md)
    - [Authelia](./openid/authelia.md)
    - [Authentik](./openid/authentik.md)
    - [Keycloak](./openid/keycloak.md)
    - [Okta](./openid/okta.md)
    - [Azure](./openid/azure.md)
    - [Zitadel](./openid/zitadel.md)
- Operations:
  - [CLI](./cli.md)
  - [Runners](./runners.md)
  - [Logs](./logs.md)
  - [Notifications](./notifications.md)
    - [Email](./notifications/email.md)
    - [Telegram](./notifications/telegram.md)
    - [Slack](./notifications/slack.md)
    - [Teams](./notifications/teams.md)
    - [Rocket.Chat](./notifications/rocket.md)
    - [DingTalk](./notifications/ding.md)
    - [Gotify](./notifications/gotify.md)
- Maintenance:
  - [Upgrading](./upgrading.md)
  - [Troubleshooting](./troubleshooting.md)
