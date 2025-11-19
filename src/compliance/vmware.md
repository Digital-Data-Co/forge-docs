# VMware Cloud Foundation Compliance Guide

## Overview

Forge provides comprehensive compliance automation for VMware Cloud Foundation (VCF)
environments, including vSphere, ESXi, and Photon OS. This guide covers how to import
and apply DISA STIG and CIS Benchmark compliance frameworks to your VMware infrastructure.

## Supported VMware Products

- **vSphere 7.0** - STIG and CIS compliance
- **vSphere 8.0** - STIG and CIS compliance
- **ESXi 7.0** - Host-level security hardening
- **ESXi 8.0** - Host-level security hardening
- **Photon OS 4.0** - Container host operating system compliance

## Supported Compliance Frameworks

### DISA STIG (Security Technical Implementation Guide)
- VMware vSphere 7.0 STIG
- VMware vSphere 8.0 STIG
- VMware ESXi 7.0 STIG
- VMware ESXi 8.0 STIG
- Photon OS 4.0 STIG

### CIS Benchmarks
- VMware vSphere 7.0 CIS Benchmark
- VMware vSphere 8.0 CIS Benchmark
- VMware ESXi 7.0 CIS Benchmark
- VMware ESXi 8.0 CIS Benchmark
- Photon OS 4.0 CIS Benchmark

## Prerequisites

### Ansible Collections
The VMware compliance automation requires the following Ansible collections:

```yaml
collections:
  - community.vmware  # VMware infrastructure management
  - vmware.vmware     # Official VMware modules (optional)
```

Install using:
```bash
ansible-galaxy collection install community.vmware
```

### vCenter/ESXi Credentials
You'll need:
- vCenter Server hostname or IP
- Administrative username and password
- ESXi host access (direct or through vCenter)
- Network connectivity to management interfaces

### Inventory Variables
Required variables for VMware compliance tasks:
```yaml
vcenter_hostname: "vcenter.example.com"
vcenter_username: "administrator@vsphere.local"
vcenter_password: "{{ vault_vcenter_password }}"
esxi_hostname: "esxi-host1.example.com"
ntp_server_1: "time1.example.com"
ntp_server_2: "time2.example.com"
syslog_server: "syslog.example.com"
management_network: "192.168.1.0/24"
```

## Importing VMware Compliance

### Method 1: During Project Creation

1. Navigate to **Projects** > **New Project**
2. Configure basic project settings (name, description)
3. In the **Compliance** section:
   - Select **VMware Compliance** as the source
   - Choose framework: **STIG** or **CIS**
   - Select target OS/product:
     - vSphere 7.0 or 8.0
     - ESXi 7.0 or 8.0
     - Photon OS 4.0
4. Click **Create Project**

Forge will automatically:
- Create a compliance view
- Import VMware-specific tasks
- Set up inventory and repository
- Generate hardening playbooks

### Method 2: Add to Existing Project

1. Navigate to your project
2. Go to **Compliance Framework** tab
3. Click **+ New Compliance**
4. Select **VMware Compliance** as source
5. Choose framework and target product
6. Click **Import**

## VMware Compliance Tasks

### ESXi/vSphere Security Configuration

The following security controls are automatically configured:

#### Firewall Management
- Configure ESXi firewall rules
- Restrict SSH access to management networks
- Disable unnecessary services

#### Authentication & Access Control
- Password complexity requirements
- Account lockout policies (3 failures, 900 second lockout)
- Password history enforcement (5 passwords)
- Disable root SSH login

#### Time Synchronization
- Configure NTP servers
- Enable NTP service
- Verify time synchronization

#### Logging & Auditing
- Configure centralized syslog
- Set appropriate log levels
- Enable audit logging for STIG compliance

#### Network Security
- Disable guest BPDU traffic
- Configure network security policies
- Validate VLAN configurations

#### TLS/SSL Hardening
- Disable insecure protocols (SSLv3, TLSv1.0, TLSv1.1)
- Enforce TLS 1.2+ only
- Configure secure cipher suites

#### Service Management
- Disable ESXi Shell when not in use
- Disable SSH when not needed
- Configure service startup policies

### Photon OS Hardening

#### Package Management
- Update package cache using `tdnf`
- Install security updates automatically
- Remove unnecessary packages

#### System Hardening
- Configure firewall using iptables
- Harden SSH configuration
- Set file permissions
- Configure audit daemon

#### Compliance Controls
- Apply STIG security controls
- Implement CIS benchmark settings
- Enable security features

## Generated Playbook Structure

VMware compliance playbooks use the following structure:

```yaml
---
# VMware vSphere 8.0 STIG Compliance Playbook
- name: VMware Compliance Automation
  hosts: localhost
  gather_facts: no
  collections:
    - community.vmware
  tasks:

    - name: Verify VMware credentials
      community.vmware.vmware_about_info:
        hostname: "{{ vcenter_hostname }}"
        username: "{{ vcenter_username }}"
        password: "{{ vcenter_password }}"
        validate_certs: no

    - name: Configure ESXi firewall rules
      community.vmware.vmware_host_firewall_manager:
        hostname: "{{ vcenter_hostname }}"
        username: "{{ vcenter_username }}"
        password: "{{ vcenter_password }}"
        esxi_hostname: "{{ esxi_hostname }}"
        rules:
          - name: sshServer
            enabled: false
            allowed_hosts:
              all_ip: false
              ip_address:
                - "{{ management_network }}"

    # Additional tasks...
```

## Running VMware Compliance Tasks

### Option 1: Run from Forge UI

1. Navigate to **Project** > **Tasks**
2. Find your VMware compliance template
3. Click **Run**
4. Select target hosts
5. Monitor execution

### Option 2: Schedule Compliance Checks

1. Navigate to **Project** > **Schedules**
2. Click **New Schedule**
3. Select VMware compliance template
4. Set schedule (daily, weekly, monthly)
5. Configure notifications

### Option 3: Manual Execution

Export the generated playbook and run manually:

```bash
# Download playbook from Forge
curl -H "Authorization: Bearer $TOKEN" \
  https://forge.example.com/api/project/1/templates/42/playbook > vmware-stig.yml

# Run with ansible-playbook
ansible-playbook vmware-stig.yml \
  -e vcenter_hostname=vcenter.example.com \
  -e vcenter_username=admin@vsphere.local \
  -e @vault-passwords.yml
```

## Compliance Reporting

### View Compliance Status

1. Navigate to **Dashboard** > **Compliance**
2. Select your VMware project
3. View:
   - Compliance score
   - Failed controls
   - Recent runs
   - Remediation history

### Export Compliance Reports

- Generate PDF reports
- Export to CSV
- Integration with external SIEM/GRC tools

## Troubleshooting

### Common Issues

#### Connection Failures
```
Error: Unable to connect to vCenter
```
**Solution:**
- Verify vCenter hostname/IP is correct
- Check network connectivity
- Validate credentials
- Ensure `validate_certs: no` for self-signed certificates

#### Permission Errors
```
Error: Permission denied for operation
```
**Solution:**
- Verify user has administrative privileges
- Check vSphere role assignments
- Ensure proper API access

#### Module Not Found
```
Error: community.vmware module not found
```
**Solution:**
```bash
ansible-galaxy collection install community.vmware
```

### Debug Mode

Enable debug logging in your template:

```yaml
- name: Debug VMware connection
  community.vmware.vmware_about_info:
    hostname: "{{ vcenter_hostname }}"
    username: "{{ vcenter_username }}"
    password: "{{ vcenter_password }}"
  register: vcenter_info

- debug:
    var: vcenter_info
```

## Best Practices

### Security
1. **Use Ansible Vault** for credentials:
   ```bash
   ansible-vault encrypt_string 'MyPassword123' --name 'vcenter_password'
   ```

2. **Limit SSH access** to management networks only

3. **Regular compliance scans** - Schedule weekly or monthly

4. **Change management** - Test in dev/staging first

### Performance
1. **Batch operations** - Group similar tasks together
2. **Parallel execution** - Use Ansible forks for multiple hosts
3. **Incremental compliance** - Apply changes gradually

### Maintenance
1. **Review logs** regularly for failures
2. **Update playbooks** when VMware releases patches
3. **Track exceptions** for compliance deviations
4. **Document customizations** to default settings

## VMware STIG Mapping

### High Severity Findings

| STIG ID | Control | Automation |
|---------|---------|------------|
| ESXI-70-000001 | ESXi host SSH daemon | Disabled by default |
| ESXI-70-000002 | ESXi host firewall | Configured with rules |
| ESXI-70-000003 | Password complexity | Enforced |
| ESXI-70-000005 | Account lockout | 3 attempts, 900s |
| ESXI-70-000030 | NTP configuration | Automated |
| ESXI-70-000045 | Syslog configuration | Centralized |
| ESXI-70-000056 | TLS configuration | TLS 1.2+ only |

### Medium Severity Findings

| STIG ID | Control | Automation |
|---------|---------|------------|
| ESXI-70-000010 | Welcome banner | Configured |
| ESXI-70-000012 | Log level | Info level |
| ESXI-70-000015 | VIB acceptance | Validated |
| ESXI-70-000032 | Network settings | Hardened |

## Additional Resources

### VMware Security Documentation
- [VMware Security Hardening Guides](https://core.vmware.com/security-hardening-guides)
- [VMware vSphere Security Configuration Guide](https://docs.vmware.com/en/VMware-vSphere/)
- [VMware STIG Viewer](https://cyber.mil/)

### Ansible Collections
- [community.vmware Documentation]
  (https://docs.ansible.com/ansible/latest/collections/community/vmware/)
- [VMware Ansible Examples](https://github.com/vmware/ansible-role-vmware)

### Forge Documentation
- [Getting Started with Compliance](./COMPLIANCE.md)
- [Infrastructure Parser](./INFRA_PARSER.md)
- [Task Templates](./TASK_TEMPLATES.md)

## Support

For issues or questions:
1. Check the [troubleshooting section](#troubleshooting)
2. Review Forge logs: `/var/log/forge/`
3. Open an issue on GitHub
4. Contact support team

## Version History

- **v0.1.298** - Initial VMware VCF compliance support
  - vSphere 7.0/8.0 STIG and CIS
  - ESXi 7.0/8.0 hardening
  - Photon OS 4.0 compliance
  - community.vmware integration

