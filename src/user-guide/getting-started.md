# Getting Started with Forge

This guide will help you get started with Forge and run your first automation task.

## Prerequisites

- Forge installed and running (see [Installation Guide](../administration-guide/installation.md))
- Access to the Forge web UI
- Admin user account created

## Key Concepts

Before we begin, let's understand some key Forge concepts:

### Projects
Projects are containers for organizing your automation work. All resources (templates, tasks, inventories, keys) belong to a project.

### Task Templates
Reusable definitions of tasks that can be executed. Templates define what to run (Ansible playbook, Terraform code, script, etc.) and how to run it.

### Tasks
Specific instances of task template execution. Each time you run a template, it creates a task with logs and results.

### Inventories
Collections of target hosts where tasks will execute. Can be static (file-based) or dynamic (API-based).

### Key Store
Secure storage for credentials, SSH keys, and secrets. All credentials are encrypted.

### Variable Groups
Environment variables and secrets that can be used by tasks during execution.

## Step 1: Create Your First Project

1. Log in to Forge
2. Click **New Project** (or **Projects** → **New Project**)
3. Fill in project details:
   - **Name**: "My First Project"
   - **Description**: (optional)
4. Click **Create**

## Step 2: Add Credentials

Before running tasks, you need to add credentials for accessing your systems.

1. In your project, navigate to **Key Store**
2. Click **New Key**
3. Choose key type:
   - **SSH Key** - For SSH access to Linux servers
   - **Login with password** - For password-based authentication
   - **AWS** - For AWS cloud access
   - **Azure** - For Azure cloud access
   - **GCP** - For Google Cloud access
4. Fill in the required information
5. Click **Save**

## Step 3: Add an Inventory

Define the hosts where your tasks will run.

1. Navigate to **Inventories**
2. Click **New Inventory**
3. Choose inventory type:
   - **Static** - File-based inventory
   - **Dynamic** - API-based (NetBox, etc.)
4. Add hosts manually or import from file
5. Click **Save**

## Step 4: Connect a Repository (Optional)

If your playbooks or scripts are in Git:

1. Navigate to **Repositories**
2. Click **New Repository**
3. Enter repository URL
4. Select authentication method (SSH key, access token, etc.)
5. Click **Save**

## Step 5: Create a Task Template

Let's create a simple task template:

1. Navigate to **Task Templates**
2. Click **New Template**
3. Choose template type (e.g., **Ansible**, **Shell**, **Terraform**)
4. Configure the template:
   - **Name**: "Hello World"
   - **Repository**: (select if using Git)
   - **Playbook/File**: Path to your playbook or script
   - **Inventory**: Select your inventory
   - **Key**: Select your SSH key
5. Click **Save**

## Step 6: Run Your First Task

1. Find your task template in the list
2. Click **Run** (or **Build**/ **Deploy** button)
3. Review task parameters
4. Click **Run Task**
5. Watch the task execute in real-time
6. View logs and results when complete

## Next Steps

Now that you've run your first task, explore more features:

- **[Projects](./projects.md)** - Learn more about project management
- **[Task Templates](./task-templates/README.md)** - Create more complex templates
- **[Compliance](./compliance/README.md)** - Manage STIG compliance
- **[Golden Images](./golden-images/README.md)** - Build hardened images
- **[Schedules](./schedules.md)** - Automate task execution

## Common Workflows

### Running an Ansible Playbook

1. Create project
2. Add repository with playbook
3. Add inventory with target hosts
4. Add SSH key for access
5. Create Ansible task template
6. Run the template

### Building Infrastructure with Terraform

1. Create project
2. Add repository with Terraform code
3. Add cloud provider credentials (AWS, Azure, GCP)
4. Create Terraform task template
5. Run `terraform plan` to preview
6. Run `terraform apply` to deploy

### Building a Golden Image

1. Create project
2. Add cloud provider credentials
3. Navigate to Golden Images
4. Use Visual Builder or import Packer template
5. Configure STIG hardening (optional)
6. Build the image
7. View in Image Catalog

## Getting Help

- **[User Guide](./README.md)** - Comprehensive feature documentation
- **[Administration Guide](../administration-guide/README.md)** - System administration
- **[FAQ](../faq/README.md)** - Common questions and troubleshooting

