# Linux Service Installer

The Linux Service Installer is the recommended installation method for Linux servers. It provides automated setup with systemd service installation, TLS configuration, Vault integration, and dependency management.

## Supported Distributions

- **Ubuntu**: 20.04, 22.04, 24.04
- **Red Hat Enterprise Linux**: 8, 9
- **Rocky Linux**: 8, 9
- **AlmaLinux**: 8, 9
- **SUSE Linux Enterprise Server**: 15+

## Features

The Linux Service Installer automatically:

- ✅ Installs Forge as a systemd service
- ✅ Configures encrypted configuration storage (`/etc/forge/config.enc`)
- ✅ Sets up TLS with Let's Encrypt (or self-signed fallback)
- ✅ Installs and configures HashiCorp Vault
- ✅ Installs required dependencies (Ansible, OpenSCAP, QEMU, etc.)
- ✅ Configures automatic key management
- ✅ Sets up proper file permissions and security

## Installation Steps

### 1. Download the Installer

Download the latest Forge binary for your platform:

```bash
# For x64 systems
wget https://github.com/Digital-Data-Co/forge/releases/download/v0.2.5/forge_Linux_x86_64.tar.gz
tar -xzf forge_Linux_x86_64.tar.gz

# For ARM64 systems
wget https://github.com/Digital-Data-Co/forge/releases/download/v0.2.5/forge_Linux_arm64.tar.gz
tar -xzf forge_Linux_arm64.tar.gz
```

### 2. Run the Installer

Execute the installer with appropriate permissions:

```bash
sudo ./forge install
```

The installer will:
1. Detect your Linux distribution
2. Install required system packages
3. Create the `forge` system user
4. Set up systemd service files
5. Configure encrypted configuration storage
6. Install and initialize HashiCorp Vault
7. Set up TLS certificates (Let's Encrypt or self-signed)
8. Install dependencies (Ansible, OpenSCAP, QEMU, etc.)

### 3. Complete Initial Setup

After installation, access the web UI:

```bash
# The service starts automatically
sudo systemctl status forge

# Access the web UI
# Default: http://localhost:3000
# Or use your server's IP/hostname
```

Navigate to the web UI and complete the initial setup wizard:
1. Create an admin user
2. Configure database connection
3. Set up basic configuration

## Configuration

### Encrypted Configuration

The installer stores sensitive configuration in `/etc/forge/config.enc` with automatic key management. The encryption key is managed securely by the system.

### TLS Configuration

The installer automatically configures TLS:

**Let's Encrypt (Recommended):**
- Automatically provisions certificates via certbot
- Auto-renewal configured
- Requires valid domain name and port 80/443 access

**Self-Signed (Fallback):**
- Generated automatically if Let's Encrypt fails
- Suitable for development/testing
- Browser warnings expected

### HashiCorp Vault

Vault is automatically:
- Installed and initialized
- Unsealed and ready to use
- Integrated with Forge for secret storage
- Configured with proper permissions

### System Dependencies

The installer automatically installs:

- **Ansible** - Latest version from distribution repositories
- **OpenSCAP** - For compliance scanning
- **QEMU** - For local Packer builds (if supported)
- **Git** - For repository access
- **Other tools** - As required by your distribution

## Service Management

### Start/Stop Service

```bash
sudo systemctl start forge
sudo systemctl stop forge
sudo systemctl restart forge
```

### Enable/Disable Auto-Start

```bash
sudo systemctl enable forge
sudo systemctl disable forge
```

### View Logs

```bash
# View service logs
sudo journalctl -u forge -f

# View recent logs
sudo journalctl -u forge -n 100

# View logs since boot
sudo journalctl -u forge -b
```

### Service Status

```bash
sudo systemctl status forge
```

## File Locations

After installation, files are organized as follows:

```
/etc/forge/
├── config.enc          # Encrypted configuration
├── config.json         # Non-sensitive configuration (if any)
└── vault/              # Vault data directory

/var/lib/forge/
├── database/           # Database files (SQLite default)
├── uploads/            # Uploaded files
├── logs/               # Application logs
└── tmp/                # Temporary files

/usr/local/bin/forge     # Forge binary (if installed system-wide)
```

## Upgrading

To upgrade Forge installed via the service installer:

```bash
# 1. Download new version
wget https://github.com/Digital-Data-Co/forge/releases/download/v0.2.6/forge_Linux_x86_64.tar.gz
tar -xzf forge_Linux_x86_64.tar.gz

# 2. Stop service
sudo systemctl stop forge

# 3. Backup configuration
sudo cp /etc/forge/config.enc /etc/forge/config.enc.backup

# 4. Replace binary
sudo cp forge /usr/local/bin/forge  # Or wherever your binary is

# 5. Start service
sudo systemctl start forge

# 6. Verify
sudo systemctl status forge
```

## Troubleshooting

### Service Won't Start

```bash
# Check service status
sudo systemctl status forge

# Check logs for errors
sudo journalctl -u forge -n 50

# Verify configuration
sudo forge config validate
```

### TLS Certificate Issues

```bash
# Check certbot status
sudo certbot certificates

# Renew certificate manually
sudo certbot renew

# Check nginx/apache configuration if using reverse proxy
```

### Vault Issues

```bash
# Check Vault status
sudo systemctl status vault

# View Vault logs
sudo journalctl -u vault -f

# Re-initialize Vault (WARNING: loses data)
sudo forge vault init
```

### Permission Issues

```bash
# Verify forge user exists
id forge

# Check file permissions
ls -la /etc/forge/
ls -la /var/lib/forge/

# Fix permissions if needed
sudo chown -R forge:forge /var/lib/forge
```

## Uninstallation

To remove Forge installed via the service installer:

```bash
# 1. Stop and disable service
sudo systemctl stop forge
sudo systemctl disable forge

# 2. Remove service file
sudo rm /etc/systemd/system/forge.service
sudo systemctl daemon-reload

# 3. Remove files (optional - backup first!)
sudo rm -rf /etc/forge
sudo rm -rf /var/lib/forge
sudo rm /usr/local/bin/forge

# 4. Remove user (optional)
sudo userdel forge
```

## Next Steps

- [Configuration Guide](../configuration.md) - Configure Forge settings
- [Security Guide](../security.md) - Secure your installation
- [User Guide](../../user-guide/README.md) - Start using Forge

