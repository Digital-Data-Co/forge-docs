# Compliance Management

Forge provides comprehensive compliance management capabilities, supporting multiple compliance frameworks and automated remediation.

## Overview

Forge's compliance features help you:

- **Import Compliance Frameworks** - STIG, CIS, NIST, PCI-DSS
- **Track Findings** - Manage compliance findings and their status
- **Automate Remediation** - Use Policy Packs and task templates
- **Monitor Coverage** - Track automated vs manual remediation
- **Export Reports** - Generate CKL files and compliance reports
- **Scan Systems** - Use OpenSCAP for automated compliance scanning

## Key Features

### STIG Compliance
- Import STIG checklists (CKL files)
- Interactive STIG Viewer for finding management
- Policy Packs for automated remediation
- Manual task assignment for bulk operations
- CKL export for certification

[Learn more →](./stig.md)

### OpenSCAP Compliance
- Upload SCAP DataStream files
- Create compliance policies
- Schedule automated scans
- View detailed compliance reports
- Download ARF files for analysis

[Learn more →](./openscap.md)

### Compliance Frameworks
- Support for multiple frameworks per project
- Framework-specific workflows
- Compliance dashboard
- Historical tracking

[Learn more →](./frameworks.md)

## Quick Start

### 1. Import a STIG Checklist

1. Navigate to **Compliance > Frameworks**
2. Click **Import Framework**
3. Upload your `.ckl` file
4. Select a Policy Pack (optional)
5. Review imported findings

### 2. Install a Policy Pack

1. Navigate to **Compliance > Policy Pack Library**
2. Browse available packs
3. Click **Install Pack**
4. Remediation tasks are automatically linked

### 3. Assign Remediation Templates

1. Navigate to **Compliance > Remediation Coverage**
2. Filter to show "Manual" findings
3. Click **Assign Template**
4. Select a remediation template
5. Review and execute assignment

### 4. Run Remediation Tasks

1. Navigate to **Task Templates**
2. Find remediation templates
3. Click **Run** to execute
4. Monitor task progress
5. Update finding status in STIG Viewer

## Workflow Examples

### STIG Hardening Workflow

1. **Import STIG** - Upload CKL file for your system
2. **Install Policy Pack** - Get automated remediation tasks
3. **Review Findings** - Use STIG Viewer to assess status
4. **Assign Templates** - Link manual findings to tasks
5. **Run Remediation** - Execute automated fixes
6. **Verify Compliance** - Re-scan or manually verify
7. **Export CKL** - Generate updated checklist for certification

### OpenSCAP Scanning Workflow

1. **Upload SCAP Content** - Add DataStream files
2. **Create Policy** - Define scan policy and profile
3. **Assign Targets** - Select inventories or hosts
4. **Schedule Scans** - Set up periodic scanning
5. **Review Reports** - Analyze compliance results
6. **Remediate Issues** - Create tasks for findings
7. **Track Progress** - Monitor compliance over time

## Best Practices

### Organization
- Use separate projects for different compliance frameworks
- Tag findings with environment (dev, staging, prod)
- Document exceptions and waivers
- Maintain audit trails

### Automation
- Install Policy Packs for common remediations
- Use bulk assignment for manual findings
- Schedule regular compliance scans
- Automate remediation where possible

### Reporting
- Export CKL files regularly for certification
- Maintain compliance dashboards
- Track remediation coverage percentage
- Document manual review processes

## Related Documentation

- [STIG Compliance](./stig.md) - Detailed STIG workflow
- [OpenSCAP Compliance](./openscap.md) - SCAP-based scanning
- [Policy Packs](./policy-packs.md) - Automated remediation
- [Remediation Coverage](./remediation.md) - Tracking automation
- [Golden Images](../golden-images/README.md) - STIG-hardened images

