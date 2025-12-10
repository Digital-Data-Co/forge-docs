# STIG Compliance

Forge provides comprehensive DISA STIG (Security Technical Implementation Guide) compliance management with automated remediation capabilities.

## Overview

STIG compliance in Forge includes:

- **STIG Import** - Import CKL (Checklist) files
- **STIG Viewer** - Interactive finding management
- **Policy Packs** - Automated remediation playbooks
- **Remediation Coverage** - Track automation percentage
- **Manual Task Assignment** - Bulk assign templates to findings
- **CKL Export** - Generate updated checklists for certification

## Importing STIG Checklists

### Supported Formats

- **CKL Files** - DISA STIG Checklist format
- **XCCDF Files** - SCAP XCCDF format (converted automatically)

### Import Process

1. Navigate to **Compliance > Frameworks**
2. Click **Import Framework**
3. Select **STIG** as framework type
4. Upload your `.ckl` file
5. (Optional) Select a **Policy Pack** to install automatically
6. Review imported findings
7. Click **Import**

### Import Options

**Policy Pack Selection:**
- Choose a Policy Pack during import to automatically link remediation tasks
- Policy Packs contain Ansible playbooks for automated fixes
- Available packs: RHEL 8/9, Ubuntu 22.04, Windows Server 2022

**Multiple Imports:**
- Import the same STIG multiple times to track versions
- Each import gets a unique version identifier
- Compare findings across versions

## STIG Viewer

The STIG Viewer provides an interactive interface for managing compliance findings.

### Finding Status

Each finding can have one of these statuses:

- **NotAFinding** - System is compliant
- **Open** - Finding requires remediation
- **NotApplicable** - Finding doesn't apply to this system
- **NotReviewed** - Finding hasn't been reviewed yet

### Finding Details

View detailed information for each finding:

- **STIG ID** - Unique identifier (e.g., V-222401)
- **Severity** - CAT I, CAT II, or CAT III
- **Title** - Finding description
- **Discussion** - Detailed explanation
- **Check** - Verification procedure
- **Fix** - Remediation steps
- **Status** - Current compliance status
- **Comments** - Your notes
- **Screenshots** - Attach evidence

### Filtering and Search

- Filter by status (Open, NotAFinding, etc.)
- Filter by severity (CAT I, II, III)
- Search by STIG ID or title
- Filter by remediation coverage (Automated, Manual)
- Filter by assigned template

### Bulk Operations

- Bulk update finding status
- Bulk assign remediation templates
- Bulk export findings
- Bulk add comments

## Policy Packs

Policy Packs are curated collections of Ansible playbooks that automate STIG remediation.

### Installing Policy Packs

1. Navigate to **Compliance > Policy Pack Library**
2. Browse available packs by:
   - Operating System (RHEL 8/9, Ubuntu 22.04, Windows)
   - Framework (STIG, CIS, NIST)
   - Use Case (Web Server, Database, Container)
3. Click **Install Pack**
4. Remediation tasks are automatically created and linked to STIG IDs

### Available Policy Packs

**Operating System Packs:**
- RHEL 8 STIG Baseline
- RHEL 9 STIG Baseline
- Ubuntu 22.04 STIG Baseline
- Windows Server 2022 STIG Baseline

**Application Packs:**
- Apache STIG
- Nginx STIG
- PostgreSQL STIG
- MySQL STIG

**Use Case Packs:**
- Web Server Baseline
- Database Server
- Container Platform

### Policy Pack Contents

Each pack includes:
- **Remediation Tasks** - Ansible playbooks for automated fixes
- **Manual Review Tasks** - Items requiring human verification
- **Documentation** - STIG mappings and instructions
- **Prerequisites** - Required packages and configurations

## Remediation Coverage

Track how many findings have automated remediation available.

### Coverage Metrics

- **Total Findings** - All findings in the framework
- **Automated Tasks** - Findings with linked remediation templates
- **Manual Review** - Findings requiring manual intervention
- **Coverage Percentage** - % of findings with automation

### Improving Coverage

1. **Install Policy Packs** - Get pre-built remediation tasks
2. **Create Custom Templates** - Build your own remediation playbooks
3. **Manual Assignment** - Bulk assign templates to manual findings
4. **Link Existing Tasks** - Connect existing templates to STIG IDs

## Manual Task Assignment

Bulk assign remediation templates to manual findings for automation.

### Assignment Process

1. Navigate to **Compliance > Remediation Coverage**
2. Filter to show only "Manual" findings
3. Click **Assign Template**
4. Select a remediation template
5. Preview which findings will be assigned
6. Click **Assign** to execute

### Benefits

- **Automation** - Convert manual tasks to automated ones instantly
- **Consistency** - Apply same remediation approach across findings
- **Efficiency** - Bulk operations instead of individual assignments
- **Coverage** - Improve overall compliance automation percentage

## Running Remediation

### Automated Remediation

1. Navigate to **Task Templates**
2. Find remediation templates (filter by "Compliance")
3. Review template details and STIG mappings
4. Click **Run** to execute
5. Monitor task progress and logs
6. Update finding status in STIG Viewer

### Manual Remediation

1. Review finding details in STIG Viewer
2. Follow "Fix" instructions manually
3. Verify compliance using "Check" procedure
4. Update finding status to "NotAFinding"
5. Add comments documenting the fix
6. Attach screenshots as evidence

## CKL Export

Generate updated CKL files for certification and reporting.

### Export Process

1. Navigate to **STIG Viewer**
2. Review and update finding statuses
3. Click **Export CKL**
4. Fill in system details:
   - System Name
   - IP Address
   - MAC Address (optional)
   - Host Name
   - Comments
5. Click **Export**
6. Download the updated `.ckl` file

### Export Formats

- **CKL** - Standard DISA STIG Checklist format
- **CSV** - For spreadsheet analysis
- **JSON** - For programmatic processing

## Best Practices

### Organization
- Use separate projects for different STIG versions
- Tag findings with environment (dev, staging, prod)
- Document exceptions and waivers in comments
- Maintain audit trails with status changes

### Automation
- Install Policy Packs early in the process
- Use bulk assignment for manual findings
- Test remediation templates in non-production first
- Document custom remediation procedures

### Reporting
- Export CKL files regularly for certification
- Maintain compliance dashboards
- Track remediation coverage percentage
- Document manual review processes

## Related Documentation

- [STIG Viewer](./stig-viewer.md) - Detailed viewer guide
- [STIG Import](./stig-import.md) - Import procedures
- [Policy Packs](./policy-packs.md) - Automated remediation
- [Remediation Coverage](./remediation.md) - Tracking automation
- [Manual Task Assignment](./manual-assignment.md) - Bulk operations

