# Forge Project Creation Guide

## Overview

This guide provides comprehensive documentation on how to create projects in Forge, a modern UI for Ansible, Terraform, OpenTofu, Bash, PowerShell, and other DevOps tools. Projects in Forge serve as containers for organizing your automation workflows, compliance frameworks, and infrastructure management tasks.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Project Creation Methods](#project-creation-methods)
3. [Web UI Project Creation](#web-ui-project-creation)
4. [API Project Creation](#api-project-creation)
5. [Project Types](#project-types)
6. [Project Configuration](#project-configuration)
7. [Troubleshooting](#troubleshooting)

## Prerequisites

Before creating a project in Forge, ensure you have:

- **Admin privileges** OR **Non-admin project creation enabled** (`NonAdminCanCreateProject` configuration)
- Access to the Forge web interface or API
- Required permissions for the target environment

## Project Creation Methods

Forge supports multiple ways to create projects:

### 1. Web UI (Recommended)
- Interactive project builder with guided setup
- Visual configuration options
- Immediate feedback and validation

### 2. API Endpoints
- Programmatic project creation
- Integration with CI/CD pipelines
- Bulk project creation

### 3. CLI Commands
- Command-line project creation
- Scripted automation
- Headless environments

## Web UI Project Creation

### Accessing the Project Builder

1. **Login** to your Forge instance
2. **Navigate** to the main dashboard
3. **Click** the "New Project" or "Create Project" button
4. **Access** the Project Builder interface

### Project Builder Interface

The Project Builder uses a **tabbed interface** with the following sections:

#### Tab 1: Project Details
**Required Fields:**
- **Project Name** (`projectName`): Unique identifier for your project
- **Environment** (`environment`): Target deployment environment (Development, Staging, Production, etc.)

**Optional Fields:**
- **Project Description** (`projectDescription`): Detailed description (max 500 characters)
- **Alert Settings**: Configure notifications and alerts
- **Max Parallel Tasks**: Limit concurrent task execution

**Example:**
```
Project Name: "web-app-deployment"
Environment: "Production"
Description: "Automated deployment pipeline for web application with CI/CD integration"
```

#### Tab 2: Compliance Framework (Optional)
Configure compliance and security frameworks:

**Available Frameworks:**
- **CIS Benchmarks**: Center for Internet Security benchmarks
- **NIST**: National Institute of Standards and Technology
- **PCI DSS**: Payment Card Industry Data Security Standard
- **HIPAA**: Health Insurance Portability and Accountability Act
- **SOX**: Sarbanes-Oxley Act
- **Custom**: User-defined compliance frameworks

**Configuration Options:**
- **Compliance Source**: Choose from available sources (default: ansible-lockdown)
- **Framework**: Select specific compliance framework
- **Operating System**: Target OS for compliance (Linux, Windows, macOS)
- **STIG Support**: Enable Security Technical Implementation Guides

**Example Configuration:**
```json
{
  "complianceFramework": "CIS",
  "complianceOS": "Ubuntu 20.04",
  "enableSTIG": true,
  "complianceSource": "ansible-lockdown"
}
```

#### Tab 3: Cloud Provider (Optional)
Configure cloud provider integration:

**Supported Providers:**
- **AWS**: Amazon Web Services
- **Azure**: Microsoft Azure
- **GCP**: Google Cloud Platform
- **DigitalOcean**: DigitalOcean Cloud
- **Linode**: Linode Cloud

**Provider-Specific Configuration:**

**AWS Configuration:**
```json
{
  "cloudProvider": "AWS",
  "aws": {
    "region": "us-east-1",
    "vpcId": "vpc-12345678",
    "subnetId": "subnet-12345678",
    "securityGroups": ["sg-12345678"],
    "keyPairName": "my-key-pair"
  }
}
```

**Azure Configuration:**
```json
{
  "cloudProvider": "Azure",
  "azure": {
    "subscriptionId": "12345678-1234-1234-1234-123456789012",
    "resourceGroup": "my-resource-group",
    "location": "East US",
    "vnetName": "my-vnet",
    "subnetName": "my-subnet"
  }
}
```

#### Tab 4: Kubernetes (Optional)
Configure Kubernetes cluster integration:

**Cluster Types:**
- **Managed Kubernetes**: EKS, AKS, GKE
- **Self-Managed**: On-premises or custom clusters
- **Development**: Local development clusters

**Configuration Options:**
- **Cluster Type**: Select deployment model
- **Node Count**: Number of worker nodes
- **Additional Software**:
  - Observability (monitoring, logging)
  - Service Mesh (Istio, Linkerd)
  - Certificate Manager
  - Gateway API
  - Nginx Ingress Proxy

**Example Configuration:**
```json
{
  "kubernetesType": "EKS",
  "nodeCount": 3,
  "additionalSoftware": {
    "observability": true,
    "serviceMesh": false,
    "certificateManager": true,
    "gatewayApi": false,
    "nginxIngressProxy": true
  }
}
```

### Creating the Project

1. **Fill Required Fields**: Complete at least the Project Details tab
2. **Navigate Tabs**: Use "Next" and "Back" buttons to configure optional sections
3. **Validate Input**: Ensure all required fields are completed
4. **Create Project**: Click the "Create" button
5. **Confirmation**: Review the created project and access project dashboard

## API Project Creation

### Endpoint

```http
POST /api/projects
Content-Type: application/json
Authorization: Bearer <your-token>
```

### Request Body Structure

#### Basic Project Creation
```json
{
  "name": "string (required)",
  "description": "string (optional)",
  "environment": "string (optional)",
  "alert": "boolean (optional, default: false)",
  "alert_chat": "string (optional)",
  "max_parallel_tasks": "integer (optional, default: 0)",
  "demo": "boolean (optional, default: false)"
}
```

#### Compliance Project Creation
```json
{
  "name": "string (required)",
  "description": "string (optional)",
  "environment": "string (optional)",
  "complianceFramework": "string (required for compliance)",
  "complianceOS": "string (required for compliance)",
  "complianceSource": "string (optional, default: ansible-lockdown)",
  "enableSTIG": "boolean (optional, default: false)"
}
```

#### Advanced Project Creation
```json
{
  "name": "string (required)",
  "description": "string (optional)",
  "environment": "string (optional)",
  "alert": "boolean (optional)",
  "alert_chat": "string (optional)",
  "max_parallel_tasks": "integer (optional)",
  "demo": "boolean (optional)",
  "complianceFramework": "string (optional)",
  "complianceOS": "string (optional)",
  "complianceSource": "string (optional)",
  "enableSTIG": "boolean (optional)",
  "cloudProvider": "string (optional)",
  "kubernetesType": "string (optional)",
  "kubernetesConfig": {
    "nodeCount": "integer (optional)",
    "additionalSoftware": {
      "observability": "boolean (optional)",
      "serviceMesh": "boolean (optional)",
      "certificateManager": "boolean (optional)",
      "gatewayApi": "boolean (optional)",
      "nginxIngressProxy": "boolean (optional)"
    }
  }
}
```

### Example API Calls

#### Create Basic Project
```bash
curl -X POST "https://your-forge-instance.com/api/projects" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer your-api-token" \
  -d '{
    "name": "my-automation-project",
    "description": "Automated infrastructure management",
    "environment": "Production",
    "alert": true,
    "max_parallel_tasks": 5
  }'
```

#### Create Compliance Project
```bash
curl -X POST "https://your-forge-instance.com/api/projects" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer your-api-token" \
  -d '{
    "name": "compliance-audit-project",
    "description": "CIS compliance auditing for Linux servers",
    "environment": "Production",
    "complianceFramework": "CIS",
    "complianceOS": "Ubuntu 20.04",
    "enableSTIG": true
  }'
```

#### Create Demo Project
```bash
curl -X POST "https://your-forge-instance.com/api/projects" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer your-api-token" \
  -d '{
    "name": "demo-project",
    "description": "Demo project with sample templates",
    "demo": true
  }'
```

### Response Format

**Success Response (201 Created):**
```json
{
  "id": 123,
  "name": "my-automation-project",
  "description": "Automated infrastructure management",
  "environment": "Production",
  "alert": true,
  "alert_chat": null,
  "max_parallel_tasks": 5,
  "created": "2024-01-15T10:30:00Z",
  "type": null,
  "compliance_framework": null,
  "compliance_os": null,
  "compliance_source": null,
  "enable_stig": false
}
```

**Error Response (400 Bad Request):**
```json
{
  "error": "Project name is required"
}
```

**Error Response (401 Unauthorized):**
```json
{
  "error": "Not authorized to create projects"
}
```

## Project Types

### 1. Standard Projects
- **Purpose**: General automation and infrastructure management
- **Use Cases**: Application deployment, configuration management, monitoring setup
- **Features**: Full template support, inventory management, task scheduling

### 2. Compliance Projects
- **Purpose**: Security and compliance auditing
- **Use Cases**: CIS benchmarks, NIST compliance, regulatory requirements
- **Features**: Pre-configured compliance frameworks, STIG support, automated scanning

### 3. Demo Projects
- **Purpose**: Learning and demonstration
- **Use Cases**: Training, proof-of-concept, feature exploration
- **Features**: Sample templates, pre-configured examples, educational content

### 4. Cloud Provider Projects
- **Purpose**: Cloud infrastructure management
- **Use Cases**: Multi-cloud deployments, cloud-native applications
- **Features**: Provider-specific configurations, cloud resource management

### 5. Kubernetes Projects
- **Purpose**: Container orchestration management
- **Use Cases**: Microservices deployment, cluster management, DevOps workflows
- **Features**: K8s-specific templates, cluster configuration, service mesh support

## Project Configuration

### Automatic Setup

When a project is created, Forge automatically sets up:

1. **Project Owner Relationship**: Creator becomes project owner
2. **Default Access Key**: "None" key for basic authentication
3. **Empty Environment**: Default environment configuration
4. **Default Views**: Basic project organization views

### Demo Project Setup

When creating a demo project (`demo: true`), Forge automatically creates:

1. **Sample Repository**: Demo Git repository with example playbooks
2. **Multiple Views**: Build, Deploy, and Tools views
3. **Sample Templates**: 8 pre-configured templates including:
   - Build Job (Ansible)
   - Deploy demo app to Production (Ansible)
   - Apply infrastructure (OpenTofu)
   - Apply infrastructure (Terragrunt)
   - Print system info (Bash)
   - Print system info (PowerShell)
4. **Sample Inventories**: Build, Dev, and Prod inventories
5. **Vault Key**: Sample vault password for secrets management

### Compliance Project Setup

Compliance projects automatically include:

1. **Compliance Framework Integration**: Pre-configured compliance rules
2. **OS-Specific Templates**: Operating system specific compliance checks
3. **STIG Integration**: Security Technical Implementation Guides (if enabled)
4. **Compliance Scanning**: Automated compliance assessment tools

## Project Permissions

### User Roles

Projects support the following user roles:

- **Owner**: Full project access and management
- **Manager**: Project management and task execution
- **Task Runner**: Task execution only
- **Guest**: Read-only access

### Permission Matrix

| Action | Owner | Manager | Task Runner | Guest |
|--------|-------|---------|-------------|-------|
| Create Project | ✓ | ✓* | ✗ | ✗ |
| Edit Project | ✓ | ✓ | ✗ | ✗ |
| Delete Project | ✓ | ✗ | ✗ | ✗ |
| Manage Users | ✓ | ✓ | ✗ | ✗ |
| Execute Tasks | ✓ | ✓ | ✓ | ✗ |
| View Tasks | ✓ | ✓ | ✓ | ✓ |
| Manage Templates | ✓ | ✓ | ✗ | ✗ |
| View Templates | ✓ | ✓ | ✓ | ✓ |

*Only if `NonAdminCanCreateProject` is enabled

## Troubleshooting

### Common Issues

#### 1. "Not authorized to create projects" Error
**Cause**: Insufficient permissions
**Solution**: 
- Ensure you have admin privileges, OR
- Enable `NonAdminCanCreateProject` in configuration

#### 2. "Project name is required" Error
**Cause**: Missing required field
**Solution**: Provide a valid project name

#### 3. "Project already exists" Error
**Cause**: Duplicate project name
**Solution**: Use a unique project name

#### 4. Compliance Framework Errors
**Cause**: Invalid compliance configuration
**Solution**: 
- Verify compliance framework is supported
- Ensure OS selection matches available frameworks
- Check compliance source configuration

#### 5. Cloud Provider Configuration Errors
**Cause**: Invalid cloud provider settings
**Solution**:
- Verify cloud provider credentials
- Check region and resource availability
- Validate network configuration

### Debug Mode

Enable debug logging for detailed project creation information:

```bash
# Set environment variable
export FORGE_DEBUG=true

# Or configure in config.json
{
  "debug": true,
  "log_level": "debug"
}
```

### API Debugging

Use verbose curl for API debugging:

```bash
curl -v -X POST "https://your-forge-instance.com/api/projects" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer your-api-token" \
  -d @project-config.json
```

## Best Practices

### 1. Project Naming
- Use descriptive, consistent naming conventions
- Include environment or purpose in the name
- Avoid special characters and spaces

### 2. Environment Configuration
- Set appropriate environment labels
- Use consistent environment naming across projects
- Document environment-specific configurations

### 3. Compliance Projects
- Choose appropriate compliance frameworks
- Enable STIG for enhanced security
- Regularly update compliance templates

### 4. Cloud Integration
- Use least-privilege access principles
- Configure appropriate regions and availability zones
- Document cloud provider specific settings

### 5. Documentation
- Always provide project descriptions
- Document custom configurations
- Maintain project-specific documentation

## Related Documentation

- [User Management Guide](user-management.md)
- [Template Creation Guide](template-creation.md)
- [Inventory Management Guide](inventory-management.md)
- [Task Execution Guide](task-execution.md)
- [API Reference](api-reference.md)

## Support

For additional support:
- Check the [Forge GitHub Issues](https://github.com/Digital-Data-Co/forge/issues)
- Review the [Forge Documentation](https://github.com/Digital-Data-Co/forge/wiki)
- Contact the Forge community for assistance
