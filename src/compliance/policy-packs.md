# Policy Pack Library

The Policy Pack Library provides curated compliance policy packs that can be quickly installed and applied to your projects.

## Overview

Policy packs are pre-configured collections of compliance frameworks, templates, and settings designed for specific use cases and compliance requirements.

## Available Policy Packs

### STIG Policy Packs

#### RHEL STIGs
- **RHEL 9 STIG** (V2R5): Latest Red Hat Enterprise Linux 9 DISA STIG
- **RHEL 8 STIG** (V2R4): Red Hat Enterprise Linux 8 DISA STIG
- **RHEL 7 STIG** (V3R15): Red Hat Enterprise Linux 7 DISA STIG

#### Ubuntu STIGs
- **Ubuntu 24.04 STIG** (V1R1): Latest Ubuntu LTS DISA STIG
- **Ubuntu 22.04 STIG** (V2R3): Ubuntu 22.04 LTS DISA STIG
- **Ubuntu 20.04 STIG** (V1R12): Ubuntu 20.04 LTS DISA STIG

#### Windows STIGs
- **Windows Server 2022 STIG** (V2R4): Latest Windows Server DISA STIG
- **Windows Server 2019 STIG** (V3R5): Windows Server 2019 DISA STIG
- **Windows 11 STIG** (V2R4): Windows 11 DISA STIG
- **Windows 10 STIG** (V3R3): Windows 10 DISA STIG

#### Other STIGs
- **SLES 15 STIG** (V2R5): SUSE Linux Enterprise Server 15 DISA STIG
- **Oracle Linux 8 STIG** (V2R4): Oracle Linux 8 DISA STIG

### CIS Benchmark Packs

#### RHEL CIS Benchmarks
- **CIS RHEL 9 Level 1** (2.0.0): Level 1 security controls
- **CIS RHEL 9 Level 2** (2.0.0): Level 2 security controls (includes Level 1)
- **CIS RHEL 8 Level 1** (3.0.0): Level 1 security controls

#### Ubuntu CIS Benchmarks
- **CIS Ubuntu 24.04 Level 1** (1.0.0): Level 1 security controls
- **CIS Ubuntu 22.04 Level 1** (2.0.0): Level 1 security controls

#### Windows CIS Benchmarks
- **CIS Windows Server 2022 Level 1** (2.0.0): Level 1 security controls
- **CIS Windows Server 2019 Level 1** (2.0.0): Level 1 security controls

## Policy Pack Presets

Presets are pre-configured combinations of policy packs designed for specific compliance scenarios.

### Government Cloud - High Security

Designed for government and high-security environments:

- **Includes**: RHEL 8 STIG High + NIST 800-53
- **Use Case**: Government cloud deployments requiring FedRAMP High compliance
- **Settings**:
  - Scan frequency: Daily
  - Auto-remediate: Disabled (manual approval required)

### Enterprise Standard

Designed for enterprise environments:

- **Includes**: CIS Level 1 + PCI-DSS
- **Use Case**: Enterprise environments requiring PCI-DSS compliance
- **Settings**:
  - Scan frequency: Weekly
  - Auto-remediate: Disabled

### Development Environment

Designed for development and testing:

- **Includes**: CIS Level 1 baseline
- **Use Case**: Development systems requiring basic security controls
- **Settings**:
  - Scan frequency: Monthly
  - Auto-remediate: Disabled

## Installing Policy Packs

### From the Policy Pack Library

1. Navigate to **Compliance** → **Policy Pack Library**
2. Browse available policy packs
3. Click **Install** on a policy pack
4. Select the target project
5. Configure installation options
6. Confirm installation

### Using Presets

1. Navigate to **Compliance** → **Policy Pack Library**
2. Select a preset from the presets section
3. Click **Apply Preset**
4. Select the target project
5. Review the included policy packs
6. Confirm installation

### Via API

```bash
# Install a specific policy pack
POST /api/project/{project_id}/policy-packs/install
{
  "pack_id": 1,
  "options": {
    "auto_remediate": false,
    "scan_frequency": "weekly"
  }
}

# Apply a preset
POST /api/project/{project_id}/policy-packs/preset
{
  "preset_id": "govt-high"
}
```

## Policy Pack Catalog API

Access the policy pack catalog programmatically:

```bash
# Get all available policy packs
GET /api/policy-packs/catalog

# Get available presets
GET /api/policy-packs/presets

# Get OS options derived from policy packs
GET /api/policy-packs/os-options
```

## Managing Installed Policy Packs

### Viewing Installed Packs

1. Navigate to a project
2. Go to **Compliance** → **Frameworks**
3. View installed compliance frameworks
4. See which policy packs are active

### Updating Policy Packs

When new versions of policy packs are available:

1. Navigate to **Policy Pack Library**
2. Check for updates
3. Click **Update** on outdated packs
4. Review changes
5. Apply updates

### Removing Policy Packs

1. Navigate to project compliance settings
2. Select the policy pack to remove
3. Click **Remove**
4. Confirm removal

## Policy Pack Structure

Each policy pack includes:

- **Compliance Framework**: The base compliance framework
- **Templates**: Ansible playbooks for remediation
- **Rules**: Compliance rules and checks
- **Metadata**: Version, description, and requirements

## Best Practices

1. **Start with Presets**: Use presets for common scenarios
2. **Customize as Needed**: Adjust settings after installation
3. **Regular Updates**: Keep policy packs updated to latest versions
4. **Test First**: Test policy packs in non-production environments
5. **Document Customizations**: Keep records of any customizations made

## Troubleshooting

### Installation Fails

If policy pack installation fails:

1. Check project permissions
2. Verify network connectivity
3. Review error messages
4. Check available disk space
5. Ensure dependencies are met

### Policy Pack Not Appearing

If a policy pack doesn't appear:

1. Refresh the page
2. Check API connectivity
3. Verify user permissions
4. Check browser console for errors

### Conflicts with Existing Frameworks

If conflicts occur:

1. Review existing compliance frameworks
2. Check for overlapping rules
3. Resolve conflicts manually
4. Consider removing conflicting frameworks

