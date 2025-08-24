# Upgrading

There are 4 ways for upgrading Semaphore:

* Snap
* Package manager
* Docker
* Binary

### Snap

Use the following command for upgrading Semaphore to the latest stable version:

```
sudo snap refresh semaphore
```

### Package manager

Download a package file from [Releases page](https://github.com/semaphoreui/semaphore/releases).

&#x20;`*.deb` for Debian and Ubuntu, `*.rpm` for CentOS and RedHat.&#x20;

Install it using the package manager.

{{#tabs }}
{{#tab name="Debian / Ubuntu (x64)" }}
```
wget https://github.com/semaphoreui/semaphore/releases/\

download/v2.15.0/semaphore_2.15.0_linux_amd64.deb

sudo dpkg -i semaphore_2.15.0_linux_amd64.deb
```
{{#endtab }}

{{#tab name="Debian / Ubuntu (ARM64)" }}
```
wget https://github.com/semaphoreui/semaphore/releases/\

download/v2.15.0/semaphore_2.15.0_linux_arm64.deb

sudo dpkg -i semaphore_2.15.0_linux_arm64.deb
```
{{#endtab }}

{{#tab name="CentOS (x64)" }}
```
wget https://github.com/semaphoreui/semaphore/releases/\

download/v2.15.0/semaphore_2.15.0_linux_amd64.rpm

sudo yum install semaphore_2.15.0_linux_amd64.rpm
```
{{#endtab }}

{{#tab name="CentOS (ARM64)" }}
```
wget https://github.com/semaphoreui/semaphore/releases/\

download/v2.15.0/semaphore_2.15.0_linux_arm64.rpm

sudo yum install semaphore_2.15.0_linux_arm64.rpm
```
{{#endtab }}
{{#endtabs }}

### Docker

<div class="warning">
      Coming soon
</div>

### Binary

---

## Migrating from Snap to package/binary

Snap installation is deprecated. If you are migrating from Snap to a package or binary installation on the same host and were using BoltDB, ensure you move the BoltDB file and repositories directory and update the corresponding paths in `config.json` for `database.boltdb` and `tmp_path`. Also adjust file ownership for the service user (e.g., `semaphore`).
Download a `*.tar.gz` for your platform from [Releases page](https://github.com/semaphoreui/semaphore/releases). Unpack the binary to the directory where your old Semaphore binary is located.

{{#tabs }}
{{#tab name="Linux (x64)" }}
```
wget https://github.com/semaphoreui/semaphore/releases/\

download/v2.15.0/semaphore_2.15.0_linux_amd64.tar.gz

tar xf semaphore_2.15.0_linux_amd64.tar.gz
```
{{#endtab }}

{{#tab name="Linux (ARM64)" }}
```
wget https://github.com/semaphoreui/semaphore/releases/\

download/v2.15.0/semaphore_2.15.0_linux_arm64.tar.gz

tar xf semaphore_2.15.0_linux_arm64.tar.gz
```
{{#endtab }}

{{#tab name="Windows (x64)" }}
```
Invoke-WebRequest `
-Uri ("https://github.com/semaphoreui/semaphore/releases/" +
      "download/v2.15.0/semaphore_2.15.0_windows_amd64.zip") `
-OutFile semaphore.zip

Expand-Archive -Path semaphore.zip  -DestinationPath ./
```
{{#endtab }}
{{#endtabs }}

