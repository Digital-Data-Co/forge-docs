# Compliance Remediation

Forge provides comprehensive remediation capabilities to help you fix compliance violations and security issues automatically.

## Overview

The remediation system allows you to:

- View detailed remediation steps for compliance rules
- Generate Ansible playbooks for automated remediation
- Track remediation history and effectiveness
- Apply fixes across multiple systems

## Remediation Steps API

The Remediation Steps API provides detailed instructions for fixing compliance violations.

### Accessing Remediation Steps

Remediation steps are available in the Rule Drill-Down component:

1. Navigate to a Compliance Framework
2. Click on a compliance finding
3. Open the **Remediation** tab
4. View detailed remediation steps

### API Endpoint

```bash
GET /api/project/{project_id}/compliance/rule-remediation
```

**Query Parameters:**
- `rule_id` (required): The compliance rule ID
- `project_id` (optional): Project ID for context
- `framework_id` (optional): Framework ID to search within

**Response:**
```json
{
  "rule_id": "SV-12345",
  "remediation_steps": "1. Edit /etc/ssh/sshd_config\n2. Set PermitRootLogin no\n3. Restart SSH service",
  "found": true
}
```

## Automated Remediation

### Generating Remediation Playbooks

For compliance findings that have associated Ansible templates:

1. Navigate to the compliance finding
2. Click **Generate Remediation Playbook**
3. Review the generated playbook
4. Execute the playbook to apply fixes

### Remediation Playbook Structure

Remediation playbooks follow this structure:

```yaml
---
- name: Remediate Compliance Finding SV-12345
  hosts: all
  become: yes
  tasks:
    - name: Apply STIG fix for rule SV-12345
      ansible.builtin.lineinfile:
        path: /etc/ssh/sshd_config
        regexp: '^PermitRootLogin'
        line: 'PermitRootLogin no'
        state: present
      notify: restart sshd

  handlers:
    - name: restart sshd
      ansible.builtin.systemd:
        name: sshd
        state: restarted
```

## Manual Remediation Steps

When automated remediation isn't available, follow the manual steps provided:

### Step-by-Step Instructions

Remediation steps are formatted as numbered instructions:

1. **Step 1**: First action to take
2. **Step 2**: Second action to take
3. **Step 3**: Verification step
4. **Step 4**: Final verification

### Example Remediation

For a typical SSH configuration fix:

```
1. Edit /etc/ssh/sshd_config
2. Set PermitRootLogin no
3. Restart SSH service: systemctl restart sshd
4. Verify configuration: sshd -t
```

## Remediation Tracking

### Viewing Remediation History

Track remediation efforts:

1. Navigate to Compliance Framework
2. View rule history
3. See previous remediation attempts
4. Track success/failure rates

### Remediation Status

Remediation status is tracked in the compliance dashboard:

- **Not Remediated**: Finding exists, no remediation applied
- **Remediated**: Fix has been applied
- **Verified**: Remediation verified through compliance scan
- **Failed**: Remediation attempt failed

## Best Practices

1. **Review Before Applying**: Always review remediation steps before applying
2. **Test in Staging**: Test remediation playbooks in non-production environments first
3. **Backup First**: Create backups before applying system changes
4. **Verify After**: Run compliance scans after remediation to verify fixes
5. **Document Changes**: Keep records of remediation actions for audit purposes

## Integration with STIG Playbooks

Remediation integrates with STIG playbooks:

- STIG findings automatically link to remediation templates
- Playbooks are generated based on STIG rule mappings
- Compliance scores update after successful remediation

## Troubleshooting

### No Remediation Steps Available

If remediation steps aren't available:

1. Check that the rule ID is correct
2. Verify the framework contains the rule
3. Ensure the framework metadata is properly loaded
4. Check API permissions

### Remediation Playbook Generation Fails

If playbook generation fails:

1. Verify STIG mappings exist for the finding
2. Check that Ansible templates are available
3. Ensure proper permissions for template access
4. Review error logs for specific issues

### Remediation Doesn't Fix Issue

If remediation doesn't resolve the issue:

1. Verify the remediation steps were applied correctly
2. Check for conflicting configurations
3. Review system logs for errors
4. Re-run compliance scan to verify current state
5. Consult STIG documentation for additional guidance

