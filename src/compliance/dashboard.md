# Compliance Dashboard

The Compliance Dashboard provides a comprehensive overview of your organization's compliance posture across all projects. It aggregates data from compliance scans, tasks, and security events to give you real-time visibility into your security and compliance status.

## Overview

The Compliance Dashboard is accessible from the main navigation menu and provides:

- **Summary Statistics**: Quick overview of total tasks, success rates, active users, and security incidents
- **Trend Analysis**: Visual charts showing task execution trends and success rates over time
- **Task Compliance**: Detailed view of all compliance-related tasks and their status
- **Project Compliance**: Compliance metrics broken down by project
- **User Activity**: Audit trail of user actions and compliance-related activities
- **Security Events**: Real-time view of security incidents and compliance violations

## Accessing the Dashboard

### Global Dashboard

Access the global compliance dashboard from the main navigation:

1. Click on **Compliance Dashboard** in the sidebar
2. View compliance data across all projects
3. Filter by date range and specific projects

### Project-Specific Dashboard

Access project-specific compliance data:

1. Navigate to a project
2. Click on **Compliance Dashboard** in the project sidebar
3. View compliance data filtered to the current project

## Dashboard Components

### Summary Cards

The dashboard displays four key summary cards:

- **Total Tasks**: Number of compliance-related tasks executed in the selected time period
- **Success Rate**: Percentage of tasks that completed successfully
- **Active Users**: Number of unique users who executed compliance tasks
- **Security Incidents**: Count of security events and compliance violations

### Compliance Trends

Two interactive charts display compliance trends:

#### Task Execution Trends

Shows the number of tasks executed per day over the selected time period. This helps you identify:
- Peak activity periods
- Task execution patterns
- Workload distribution

#### Success Rate Trends

Displays the daily success rate percentage, helping you track:
- Overall compliance health
- Trends in task success/failure
- Impact of changes or updates

### Task Compliance Table

The Task Compliance table provides detailed information about each compliance task:

- **Task ID**: Unique identifier for the task
- **Project**: Project where the task was executed
- **Template**: Compliance template/playbook used
- **Status**: Current task status (success, failed, running, etc.)
- **Compliance Score**: Percentage score indicating compliance level
- **Duration**: Time taken to complete the task
- **User**: User who initiated the task
- **Created**: Timestamp when the task was created
- **Issues**: List of any compliance issues found

#### Viewing Task Details

Click the eye icon (👁️) next to a task to view detailed information. Note that framework compliance findings (indicated by `is_framework_task: true`) are informational and don't have associated task details. For these items, you'll be directed to the Compliance Framework view instead.

### Project Compliance Table

Shows compliance metrics aggregated by project:

- **Project Name**: Name of the project
- **Total Tasks**: Number of compliance tasks in the project
- **Successful**: Count of successful tasks
- **Failed**: Count of failed tasks
- **Compliance Rate**: Overall compliance percentage for the project

Click the eye icon to view detailed project compliance information.

### User Activity Table

Provides an audit trail of user actions:

- **Action Type**: Type of action performed (Login, Task Event, etc.)
- **Description**: Detailed description of the action
- **Username**: User who performed the action
- **Project**: Project context (if applicable)
- **Created**: Timestamp of the action

### Security Events Table

Lists security-related events and compliance violations:

- **Event Type**: Type of security event (failed_login, compliance_scan, etc.)
- **Severity**: Severity level (high, medium, low)
- **Description**: Detailed description of the event
- **Username**: User associated with the event
- **Project**: Project context
- **Resolved**: Whether the event has been resolved
- **Created**: Timestamp of the event

#### Resolving Security Events

Click the checkmark icon (✓) next to an unresolved event to mark it as resolved.

## Filtering and Date Ranges

### Date Range Selection

Select from predefined date ranges:

- **Last 7 days**: View data from the past week
- **Last 30 days**: View data from the past month (default)
- **Last 90 days**: View data from the past quarter
- **Last year**: View data from the past 365 days

### Project Filtering

When viewing the global dashboard:

1. Use the **Project Filter** dropdown
2. Select "All Projects" to view aggregate data
3. Select a specific project to filter data to that project only

## Exporting Reports

Export compliance dashboard data for external analysis:

1. Click the **Export Report** button
2. Select your desired date range and project filter
3. The report will be downloaded as a CSV file
4. Open the CSV in Excel, Google Sheets, or your preferred analysis tool

The exported report includes:
- Summary statistics
- Task compliance details
- Project compliance metrics
- User activity logs
- Security events

## Real-Time Updates

The dashboard automatically refreshes when:

- Tasks are created, updated, or completed
- Compliance scans finish
- Security events occur
- WebSocket notifications are received

You'll see a "Last updated" timestamp indicating when the data was last refreshed.

## Understanding Compliance Scores

Compliance scores are calculated based on task status:

- **100%**: Task completed successfully (all checks passed)
- **50%**: Task is currently running
- **0%**: Task failed or encountered errors

For framework compliance findings:
- **100%**: Finding is mapped to a remediation template
- **0%**: Finding has no associated remediation template

## Best Practices

1. **Regular Monitoring**: Check the dashboard daily to stay informed about compliance status
2. **Trend Analysis**: Use the trend charts to identify patterns and potential issues
3. **Project Comparison**: Compare compliance rates across projects to identify areas needing attention
4. **Security Events**: Review security events regularly and resolve them promptly
5. **Export Reports**: Export monthly reports for compliance audits and documentation

## Troubleshooting

### Empty Dashboard

If the dashboard appears empty:

1. Verify you have compliance tasks or scans in the selected date range
2. Check that you have permission to view the projects
3. Try expanding the date range
4. Ensure compliance scans have been executed

### Missing Data

If certain data is missing:

1. Verify the date range includes the relevant time period
2. Check project filters aren't excluding relevant data
3. Ensure tasks have completed (not just queued)
4. Check user permissions for viewing project data

### Performance Issues

If the dashboard loads slowly:

1. Reduce the date range to a shorter period
2. Filter to a specific project instead of "All Projects"
3. Check network connectivity
4. Clear browser cache and refresh

## API Access

The Compliance Dashboard data is also available via the API:

```bash
# Get dashboard data for all projects (last 30 days)
GET /api/compliance/dashboard

# Get dashboard data for a specific project
GET /api/compliance/dashboard?project_id=123

# Get dashboard data for custom date range
GET /api/compliance/dashboard?days=90
```

See the [API Reference](../administration-guide/api.md) for complete API documentation.

