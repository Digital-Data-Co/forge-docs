<div class="breadcrumbs">
    <a href="/user-guide/task-templates/">Projects</a>
    → Project Runners (Pro)
</div>

# Project runners (Pro)

Project Runners are a powerful feature in Forge Pro that enables distributed task execution across multiple servers. This feature allows you to run tasks on separate servers from your Forge UI instance, providing enhanced security, scalability, and resource management.


![](<../../.gitbook/assets/project_runners.webp>)


## Overview

Project runners operate on a similar principle to GitLab or GitHub Actions runners:

- A runner is deployed on a separate server from your Forge UI
- The runner connects to your Forge instance using a secure token
- When tasks are created, Forge delegates them to available runners
- Runners execute the tasks and report results back to Forge

## Benefits

Using runners provides several key advantages:

1. **Enhanced Security**
   - Runners can be deployed in isolated environments or restricted networks
   - Sensitive operations can be executed in controlled environments
   - Better separation of concerns between UI and execution environments

2. **Improved Scalability**
   - Distribute workload across multiple servers
   - Add or remove runners based on demand
   - Better resource utilization across your infrastructure

3. **Flexible Deployment**
   - Deploy runners close to your target infrastructure
   - Run tasks in different network zones
   - Support for various deployment models (on-premises, cloud, hybrid)

## Using Project Runners

### Prerequisites

To use runners, you need:

1. A Forge Pro license
2. A separate server for running the runner
3. Network connectivity between the runner and Forge UI
4. Proper configuration on both the Forge UI and runner servers

<!-- ### Configuration

1. **Forge UI Configuration**
  

2. **Runner Setup** -->


### Managing Runners

You can manage runners through the Forge UI:

1. Navigate to the Runners section in your project
2. View all registered runners and their status
3. Add or remove runners as needed
4. Monitor runner health and performance

### Security Considerations

- Always use HTTPS for communication between runners and Forge UI
- Implement proper network security between runners and Forge UI
- Consider using isolated environments for sensitive operations

## Best Practices

1. **Resource Planning**
   - Size your runners appropriately for your workload
   - Monitor runner resource usage
   - Scale runners based on demand

2. **Network Configuration**
   - Ensure proper network connectivity
   - Configure firewalls appropriately
   - Use secure communication channels

3. **Maintenance**
   - Regularly update runner software
   - Monitor runner health
   - Implement proper logging and monitoring
   - Have a backup strategy for runner failures

4. **Security**
   - Follow the principle of least privilege
   - Implement proper access controls
   - Regular security audits
   - Keep software up to date