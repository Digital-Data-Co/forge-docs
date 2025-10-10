<div class="breadcrumbs">
    <a href="/administration-guide/installation">Installation</a>
    → Snap
</div>

# Snap (deprecated)

To install Forge via snap, run following command in terminal:

```bash
sudo snap install semaphore
```

Forge will be available by URL [https://localhost:3000](https://localhost:3000).&#x20;

But to log in, you should create an admin user. Use the following commands:

```bash
sudo snap stop semaphore

sudo semaphore user add --admin \
--login john \
--name=John \
--email=john1996@gmail.com \
--password=12345

sudo snap start semaphore
```

You can check the status of the Forge service using the following command:

```bash
sudo snap services semaphore
```

It should print the following table:

```
Service               Startup  Current  Notes
semaphore.semaphored  enabled  active   -
```

After installation, you can set up Forge via [Snap Configuration](https://snapcraft.io/docs/configuration-in-snaps). Use the following command to see your Forge configuration:

```bash
sudo snap get semaphore
```

&#x20;List of available options you can find in [Configuration options reference](../configuration.md#configuration-options).

----
