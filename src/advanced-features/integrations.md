# Forge Integrations - Complete Guide

## What Are Integrations?

**Integrations** in Forge are **webhook receivers** that allow external services
to trigger Ansible/Terraform tasks automatically. They enable **event-driven automation**
where external events (like GitHub pushes, CI/CD pipeline completions, monitoring alerts)
can automatically execute Forge templates.

---

## 🎯 Primary Use Cases

### 1. CI/CD Pipeline Integration
**Scenario:** Automatically deploy when code is pushed to GitHub

```
GitHub Push Event
       ↓
GitHub Webhook → Forge Integration
       ↓
Triggers Deployment Template
       ↓
Ansible deploys to production
```

### 2. Monitoring & Auto-Remediation
**Scenario:** Monitoring system detects issue, triggers fix

```
Prometheus Alert
       ↓
Alertmanager Webhook → Forge Integration
       ↓
Triggers Remediation Template
       ↓
Ansible fixes the issue
```

### 3. Infrastructure Provisioning
**Scenario:** New customer signup triggers infrastructure setup

```
Application API
       ↓
Custom Webhook → Forge Integration
       ↓
Triggers Terraform Template
       ↓
Creates customer environment
```

### 4. ChatOps
**Scenario:** Slack command triggers infrastructure changes

```
Slack Slash Command
       ↓
Slack Webhook → Forge Integration
       ↓
Triggers Ansible Template
       ↓
Executes requested operation
```

---

## 🔧 How Integrations Work

### Architecture

```
External Service
       ↓
HTTP POST to Integration URL
       ↓
Authentication (GitHub/Bitbucket/Token/HMAC/Basic)
       ↓
Matchers (Filter which events to process)
       ↓
Extract Values (Pull data from webhook payload)
       ↓
Task Parameters (Pass data to template)
       ↓
Run Template (Execute Ansible/Terraform)
```

### Components

**1. Integration Alias**
- Unique URL path for receiving webhooks
- Example: `/api/integrations/my-deploy-hook`
- Can be shared across multiple integrations (routing)

**2. Authentication Methods**
- **None:** No authentication required
- **GitHub:** Validates GitHub webhook signatures
- **Bitbucket:** Validates Bitbucket webhook signatures
- **Token:** Requires specific token in header
- **HMAC:** HMAC-SHA256 signature verification
- **BasicAuth:** HTTP Basic Authentication

**3. Matchers** (Filters)
- Filter which webhook events should trigger the task
- Match against HTTP headers or body content
- Methods: equals, not equals, contains
- Example: Only trigger on `push` events, ignore `pull_request`

**4. Extract Values**
- Pull data from webhook payload
- Sources: HTTP headers or body (JSON/String)
- Map to task parameters or environment variables
- Example: Extract `git_branch` from webhook body

**5. Task Template**
- The Ansible/Terraform template to execute
- Receives extracted values as parameters
- Runs with project inventory and environment

---

## 📋 Integration Configuration

### Basic Integration Setup

**Step 1: Create Integration**
- Navigate to Project → Integrations
- Click "New Integration"
- Enter name (e.g., "Deploy on GitHub Push")

**Step 2: Select Template**
- Choose which template to run
- Template can be Ansible, Terraform, or any supported app

**Step 3: Configure Authentication**
- Select auth method based on webhook source
- For GitHub: Select "GitHub Webhooks"
- For custom: Select "Token" or "None"

**Step 4: Add Secret (if needed)**
- For GitHub/Bitbucket: Add webhook secret as "login_password" key
- For Token: Add token as "login_password" key
- Stored securely in Forge vault

**Step 5: Create Alias**
- Click "Add Alias"
- Enter alias name (e.g., "deploy")
- Get webhook URL: `https://forge.example.com/api/integrations/deploy`

---

## 🔍 Advanced Features

### Matchers (Event Filtering)

**Purpose:** Only process specific webhook events

**Example 1: GitHub - Only Deploy on Master Branch**
```
Matcher 1:
  Type: Body (JSON)
  Key: ref
  Method: Equals
  Value: refs/heads/master
```

**Example 2: Multiple Conditions**
```
Matcher 1: Event type == push
Matcher 2: Branch contains production
Matcher 3: Repository == my-app
```
All matchers must match for the task to run.

### Extract Values (Data Passing)

**Purpose:** Extract data from webhook and pass to template

**Example 1: Extract Git Branch**
```
Name: branch
Source: Body (JSON)
Key: ref
Variable: git_branch
Type: Task Parameter
```

**Example 2: Extract Commit SHA**
```
Name: commit
Source: Body (JSON)
Key: after
Variable: git_commit
Type: Task Parameter
```

**Example 3: Extract from Header**
```
Name: event_type
Source: Header
Key: X-GitHub-Event
Variable: event_type
Type: Environment Variable
```

### Task Parameters

Extracted values can be:
- **Task Parameters:** Passed to template as Ansible variables
- **Environment Variables:** Set as shell environment variables

---

## 🌐 Webhook URL Structure

### Single Integration Alias
```
https://forge.example.com/api/integrations/{alias}
```
- Routes to single integration
- Runs one specific template
- Simplest configuration

### Project-Level Alias
```
https://forge.example.com/api/integrations/{alias}
```
- Can route to multiple integrations
- Uses matchers to determine which integration(s) to run
- One webhook URL, multiple actions

---

## 💡 Real-World Examples

### Example 1: GitHub Auto-Deploy

**Setup:**
```
Integration: "Deploy Production"
Template: "Deploy Application"
Auth: GitHub Webhooks
Secret: GitHub webhook secret (from repo settings)
Alias: "deploy-prod"

Matcher 1:
  Type: Body (JSON)
  Key: ref
  Method: Equals
  Value: refs/heads/main

Extract Value:
  Name: commit_sha
  Source: Body (JSON)
  Key: after
  Variable: deploy_version
  Type: Task Parameter
```

**GitHub Setup:**
1. Go to repo Settings → Webhooks
2. Add webhook: `https://forge.example.com/api/integrations/deploy-prod`
3. Content type: application/json
4. Secret: (same as stored in Forge)
5. Events: Just the push event

**Result:**
- Push to `main` branch triggers deployment
- Commit SHA passed to Ansible as `deploy_version` variable
- Automated zero-touch deployments

---

### Example 2: Bitbucket Pipeline Trigger

**Setup:**
```
Integration: "Run Tests"
Template: "Execute Test Suite"
Auth: Bitbucket Webhooks
Alias: "run-tests"

Matcher 1:
  Type: Header
  Key: X-Event-Key
  Method: Equals
  Value: repo:push
```

**Bitbucket Setup:**
1. Repository Settings → Webhooks
2. Add webhook: `https://forge.example.com/api/integrations/run-tests`
3. Triggers: Repository push

**Result:**
- Every push runs the test suite
- Results visible in Forge task history

---

### Example 3: Prometheus Auto-Remediation

**Setup:**
```
Integration: "Fix High CPU"
Template: "Restart Service"
Auth: HMAC
Secret: Shared secret with Alertmanager
Alias: "auto-remediate"

Matcher 1:
  Type: Body (JSON)
  Key: alerts[0].labels.alertname
  Method: Equals
  Value: HighCPU

Extract Value:
  Name: affected_host
  Source: Body (JSON)
  Key: alerts[0].labels.instance
  Variable: target_host
  Type: Environment Variable
```

**Prometheus Alertmanager Config:**
```yaml
receivers:
  - name: 'forge-remediation'
    webhook_configs:
      - url: 'https://forge.example.com/api/integrations/auto-remediate'
        send_resolved: false
```

**Result:**
- High CPU alert automatically triggers service restart
- Affected host extracted from alert payload
- Self-healing infrastructure

---

### Example 4: Custom API Integration

**Setup:**
```
Integration: "Provision Customer"
Template: "Create Customer Infrastructure"
Auth: Token
Header: X-API-Token
Secret: API token stored in Forge
Alias: "provision"

Extract Values:
  1. Customer ID from body.customer_id
  2. Region from body.region
  3. Tier from body.tier
```

**External Application:**
```bash
curl -X POST https://forge.example.com/api/integrations/provision \
  -H "X-API-Token: your-secret-token" \
  -H "Content-Type: application/json" \
  -d '{
    "customer_id": "12345",
    "region": "us-east-1",
    "tier": "premium"
  }'
```

**Result:**
- Customer infrastructure provisioned automatically
- Parameters passed to Terraform template
- Consistent, automated deployments

---

## 🔐 Authentication Methods Detail

### 1. None
- No authentication required
- ⚠️ **Warning:** Anyone with URL can trigger tasks
- Use only for internal/trusted networks

### 2. GitHub Webhooks
- Uses GitHub's webhook signature verification
- Validates `X-Hub-Signature-256` header
- Secret must match GitHub webhook secret
- Most secure for GitHub integrations

### 3. Bitbucket Webhooks
- Similar to GitHub
- Validates Bitbucket signatures
- Secure for Bitbucket repositories

### 4. Token
- Simple bearer token authentication
- Token sent in custom header (e.g., `X-API-Token`)
- Good for custom applications

### 5. HMAC
- HMAC-SHA256 signature verification
- Custom implementation
- Flexible for various webhook sources

### 6. BasicAuth
- HTTP Basic Authentication
- Username:password in Authorization header
- Standard HTTP auth

---

## 📊 Database Schema

### Integration Table
```
id: Unique identifier
name: Human-readable name
project_id: Which project it belongs to
template_id: Which template to run
auth_method: Authentication method
auth_secret_id: Reference to secret key
auth_header: Header name for token auth
searchable: Whether to show in searches
task_params_id: Reference to task parameters
```

### IntegrationMatcher Table
```
id: Unique identifier
integration_id: Parent integration
name: Matcher name
match_type: header or body
method: equals, unequals, contains
body_data_type: json or string
key: Header name or JSON path
value: Expected value
```

### IntegrationExtractValue Table
```
id: Unique identifier
integration_id: Parent integration
name: Extract name
value_source: body or header
body_data_type: json or string
key: Header name or JSON path
variable: Variable name to set
variable_type: environment or task
```

### IntegrationAlias Table
```
id: Unique identifier
alias: URL path segment
project_id: Project
integration_id: Target integration (null for project-level)
```

---

## 🚀 Benefits

### Automation
✅ **Zero-Touch Deployments** - Code push automatically deploys
✅ **Auto-Remediation** - Alerts trigger fixes automatically
✅ **Event-Driven** - React to external events instantly
✅ **Scalable** - Handle any number of webhooks

### Integration
✅ **GitHub/GitLab/Bitbucket** - Git platform integration
✅ **CI/CD Tools** - Jenkins, CircleCI, Travis, etc.
✅ **Monitoring** - Prometheus, Grafana, Datadog
✅ **Chat Platforms** - Slack, Teams, Discord
✅ **Custom APIs** - Any service that can send HTTP POST

### Security
✅ **Signature Verification** - Validates webhook authenticity
✅ **Encrypted Secrets** - Tokens stored encrypted in vault
✅ **Access Control** - Project-level permissions
✅ **Audit Trail** - All triggered tasks logged

---

## 🔒 Security Best Practices

1. **Always Use Authentication**
   - Never use "None" in production
   - Use GitHub/Bitbucket auth for those platforms
   - Use Token or HMAC for custom webhooks

2. **Rotate Secrets Regularly**
   - Update webhook secrets periodically
   - Change tokens after security incidents

3. **Use Matchers**
   - Filter events to only process expected ones
   - Prevent accidental task execution

4. **Monitor Integration Usage**
   - Review task history for unexpected runs
   - Alert on failed authentications

5. **Limit Template Permissions**
   - Integration templates should use least-privilege
   - Separate templates for different security levels

---

## 📝 Configuration Example

### Complete Integration Setup

**Project:** Production Deployment
**Goal:** Deploy app when main branch is updated

```json
{
  "name": "Deploy Production on Main Push",
  "template_id": 42,
  "auth_method": "github",
  "auth_secret_id": 15,
  "auth_header": "",
  "searchable": true,

  "matchers": [
    {
      "name": "Check branch",
      "match_type": "body",
      "method": "equals",
      "body_data_type": "json",
      "key": "ref",
      "value": "refs/heads/main"
    },
    {
      "name": "Check event",
      "match_type": "header",
      "method": "equals",
      "key": "X-GitHub-Event",
      "value": "push"
    }
  ],

  "extract_values": [
    {
      "name": "Commit SHA",
      "value_source": "body",
      "body_data_type": "json",
      "key": "after",
      "variable": "git_commit",
      "variable_type": "task"
    },
    {
      "name": "Branch",
      "value_source": "body",
      "body_data_type": "json",
      "key": "ref",
      "variable": "git_ref",
      "variable_type": "environment"
    }
  ]
}
```

---

## 🛠️ API Endpoints

### Create Integration
```
POST /api/project/{project_id}/integrations
```

### Get Integrations
```
GET /api/project/{project_id}/integrations
```

### Update Integration
```
PUT /api/project/{project_id}/integrations/{integration_id}
```

### Delete Integration
```
DELETE /api/project/{project_id}/integrations/{integration_id}
```

### Receive Webhook
```
POST /api/integrations/{alias}
```

### Create Alias
```
POST /api/project/{project_id}/integrations/alias
```

---

## 🎨 UI Features

### Integrations Page
- Location: Project → Integrations
- Lists all integrations for the project
- Shows webhook URLs with copy button
- Create, edit, delete integrations

### Integration Form
- **Name:** Human-readable identifier
- **Template:** Which template to run
- **Auth Method:** How to authenticate webhooks
- **Auth Secret:** Token/password for verification
- **Task Parameters:** Pre-configured parameters for template

### Alias Management
- **Add Alias:** Create new webhook URL
- **Copy URL:** Quick copy to clipboard
- **Delete:** Remove webhook endpoint

### Matchers (Advanced)
- Add conditions to filter events
- Header matching
- Body/JSON path matching
- Multiple matchers = AND logic

### Extract Values (Advanced)
- Pull data from webhook payload
- Map to template variables
- Support for nested JSON paths

---

## 📖 Comparison with Alerts

| Feature | Integrations | Alerts |
|---------|-------------|--------|
| **Direction** | Inbound webhooks | Outbound notifications |
| **Purpose** | Trigger tasks from external events | Notify about task completion |
| **Trigger** | External service calls Forge | Forge calls external service |
| **Use Case** | Event-driven automation | Status notifications |
| **Configuration** | Per integration, matchers, extractors | Per project, simple enable/disable |

**They work together:**
```
GitHub Push
    ↓
Integration triggers deploy task
    ↓
Deployment executes
    ↓
Alert sends success to Slack
```

---

## 🚨 Common Patterns

### Pattern 1: GitOps Deployment
```
Git Repo → Webhook → Integration → Deploy Template → Production
```

### Pattern 2: Auto-Scaling
```
Metrics → Alertmanager → Integration → Terraform → Add Servers
```

### Pattern 3: Backup Automation
```
Schedule → Webhook → Integration → Backup Template → S3
```

### Pattern 4: Compliance Scanning
```
New Instance → Cloud API → Integration → Compliance Template → Hardening
```

---

## 🐛 Troubleshooting

### Integration Not Triggering

**Check 1: Webhook URL Correct?**
- Verify alias is correct
- Check HTTPS vs HTTP
- Ensure Forge is accessible from external service

**Check 2: Authentication Working?**
- Review Forge logs for auth errors
- Verify secret matches webhook configuration
- Check header names (case-sensitive)

**Check 3: Matchers Passing?**
- Temporarily remove matchers to test
- Log webhook payload to see actual values
- Verify JSON paths are correct

**Check 4: Template Valid?**
- Ensure template exists
- Check template has required inventory/environment
- Verify template permissions

### Webhook Timing Out

**Symptoms:** External service reports timeout
**Cause:** Forge takes too long to respond
**Solutions:**
- Forge responds immediately (non-blocking)
- Task runs asynchronously
- Check if Forge server is slow/overloaded

---

## 📈 Performance Considerations

### Scalability
- Integrations run tasks asynchronously
- Webhook endpoint responds immediately
- Task queued in TaskPool
- No blocking of webhook sender

### Rate Limiting
- Consider rate limiting webhook endpoints
- Prevent DOS attacks
- Queue management for burst events

### Logging
- All webhook calls logged
- Failed authentications tracked
- Task execution history maintained

---

## 🎯 Key Takeaways

1. **Integrations = Inbound Webhooks**
   - External services trigger Forge tasks
   - Event-driven automation

2. **Secure by Design**
   - Multiple authentication methods
   - Signature verification
   - Encrypted secret storage

3. **Flexible Routing**
   - Aliases for clean URLs
   - Matchers for event filtering
   - Extract values for dynamic parameters

4. **Production-Ready**
   - Supports GitHub, Bitbucket, custom APIs
   - Async execution
   - Full audit trail

5. **Powerful Automation**
   - CI/CD integration
   - Auto-remediation
   - Infrastructure-as-Code triggers
   - ChatOps enablement

---

**Integrations transform Forge from a task runner into a complete automation platform!** 🚀

