# Patch Management

Forge provides comprehensive patch management capabilities to help you identify, assess, and apply security patches across your infrastructure.

## Overview

The Patch Management system allows you to:

- Check for available security patches
- View detailed patch information including CVEs and dependencies
- Apply patches to target systems
- Track patch application history
- Generate Ansible playbooks for patch deployment

## Patch Checking

### Initiating a Patch Check

1. Navigate to a project
2. Go to **Patches** in the sidebar
3. Click **Check for Patches**
4. Select target nodes or inventory
5. Configure check options
6. Start the patch check

### Patch Check Options

- **Target Nodes**: Select specific nodes or use an inventory
- **OS Type**: Specify operating system (RHEL, Ubuntu, Windows, etc.)
- **OS Version**: Specify OS version for accurate patch detection
- **Check Dependencies**: Include dependency information in results

### Viewing Patch Check Results

After a patch check completes:

1. View the list of available patches
2. See CVE IDs and severity levels
3. Review affected packages
4. Check dependency information
5. View patch descriptions

## Patch Details

### Viewing Patch Information

Click on a patch to view detailed information:

- **CVE IDs**: Associated Common Vulnerabilities and Exposures
- **Severity**: Patch severity (Critical, High, Medium, Low)
- **Description**: Detailed patch description
- **Affected Packages**: Packages that will be updated
- **Dependencies**: Required dependencies for the patch
- **Release Date**: When the patch was released
- **References**: Links to security advisories

### Patch Severity Levels

- **Critical**: Immediate action required, severe security risk
- **High**: Should be applied soon, significant security risk
- **Medium**: Should be applied when convenient, moderate risk
- **Low**: Optional, minor security or stability improvement

## Applying Patches

### Applying Patches to Nodes

1. Select patches to apply
2. Choose target nodes or inventory
3. Review patch details
4. Configure application options
5. Start patch application

### Patch Application Options

- **Dry Run**: Test patch application without making changes
- **Reboot Required**: Handle systems that require reboot
- **Schedule**: Schedule patch application for maintenance window
- **Rollback Plan**: Configure automatic rollback on failure

### Patch Application Status

Track patch application progress:

- **Pending**: Patch application queued
- **In Progress**: Currently applying patch
- **Success**: Patch applied successfully
- **Failed**: Patch application failed
- **Rolled Back**: Patch was rolled back due to issues

## Patch History

### Viewing Patch History

Access patch history to:

1. View all patch checks performed
2. See patch application history
3. Track success/failure rates
4. Review patch application details
5. Export patch reports

### Patch History Filters

Filter patch history by:

- **Date Range**: Select time period
- **Status**: Filter by success/failure
- **Severity**: Filter by patch severity
- **Node**: Filter by specific node
- **Project**: Filter by project

## Ansible Playbook Generation

### Generating Patch Playbooks

For supported operating systems, Forge can generate Ansible playbooks:

1. Select patches to apply
2. Click **Generate Playbook**
3. Review generated playbook
4. Download or execute the playbook

### Playbook Structure

Generated playbooks follow this structure:

```yaml
---
- name: Apply Security Patches
  hosts: all
  become: yes
  tasks:
    - name: Update package cache
      ansible.builtin.apt:
        update_cache: yes
      when: ansible_os_family == "Debian"

    - name: Apply security patches
      ansible.builtin.apt:
        name:
          - package1
          - package2
        state: latest
        upgrade: dist
      when: ansible_os_family == "Debian"
```

## API Access

### Patch Check API

```bash
# Check for patches
POST /api/project/{project_id}/patches/check
{
  "node_ids": ["node1", "node2"],
  "os_type": "rhel",
  "os_version": "9"
}

# Get patch check results
GET /api/project/{project_id}/patches/check/{check_id}
```

### Patch Application API

```bash
# Apply patches
POST /api/project/{project_id}/patches/apply
{
  "patch_ids": [1, 2, 3],
  "node_ids": ["node1", "node2"],
  "options": {
    "dry_run": false,
    "reboot_required": true
  }
}

# Get patch application status
GET /api/project/{project_id}/patches/application/{application_id}
```

### Patch History API

```bash
# Get patch history
GET /api/project/{project_id}/patches/history?limit=50&offset=0
```

## Best Practices

1. **Regular Checks**: Schedule regular patch checks (weekly or monthly)
2. **Test First**: Test patches in non-production environments
3. **Maintenance Windows**: Apply patches during scheduled maintenance windows
4. **Backup First**: Create backups before applying patches
5. **Monitor After**: Monitor systems after patch application
6. **Document Changes**: Keep records of patch applications
7. **Prioritize Critical**: Apply critical patches immediately
8. **Review Dependencies**: Check patch dependencies before applying

## Troubleshooting

### Patch Check Fails

If patch checks fail:

1. Verify node connectivity
2. Check OS type and version are correct
3. Ensure proper credentials are configured
4. Review error messages
5. Check network connectivity to patch repositories

### Patch Application Fails

If patch application fails:

1. Review error messages
2. Check system logs
3. Verify package repositories are accessible
4. Check for conflicting packages
5. Review dependency requirements
6. Try applying patches individually

### Patches Not Detected

If expected patches aren't detected:

1. Verify OS type and version
2. Check patch repositories are up to date
3. Ensure patch check is using correct sources
4. Review patch database for known issues
5. Check for network connectivity issues

## Integration with Compliance

Patch management integrates with compliance:

- Patches address compliance findings
- Compliance scans verify patch application
- Patch history tracked in compliance dashboard
- Remediation playbooks include patch application

