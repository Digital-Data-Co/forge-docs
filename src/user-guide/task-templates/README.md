# Task Templates

Templates define how to run Forge tasks. Currently the following task types are supported:

* [Ansible](./ansible.md)
* [Terraform/OpenTofu](./terraform.md)
* [Shell](./bash.md)
* [Powershell](./powershell.md)
* [Python](./python.md)

---

## Parallel tasks

By default, tasks from the same template execute sequentially. To allow concurrent runs of the same template, enable the "Allow parallel tasks" option in the template settings.
