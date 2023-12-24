# Netbox Plugin Customization

## What is this?

This project allows you to customize the Netbox Docker community project to add plugins and more.

## How's it work?

Github actions will trigger off new netbox-docker builds, customize the image, publish it up to Github Packages and then using the docker-compose you can launch and instance.

## Why did I create it?

I challenged myself to be able to recreate my entire home network and lab using nothing but devops tools. The premise is that the only thing I can start with is factory defaulted hardware, a laptop, a hotspot, and code hosted in a repo. Success is defined as reducing it to as few steps as possible - Ideally one command/playbook/script whatever builds the entire thing from scratch. Before I can configure anything, I have to start with a source of truth - therefore, this is where I'm starting. It's a work in progress and these manual steps will continue to be pruned away as I automate them.

## How to use

### Step 1

Copy example directories and files

```bash
cp ./examples/configuration-example ./configuration
cp ./examples/env-example ./env
cp ./examples/plugin_requirements.txt ./plugin_requirements.txt
```

### Step 2

Add the [plugins](https://netbox.dev/plugins/) you want installed to plugin_requirements.txt. This will only do a pip install during build time so in /configuration you'll need to customize the [plugins.py](https://github.com/netbox-community/netbox-docker/blob/release/configuration/plugins.py) so they load when starting Netbox. Also update [logging.py](https://github.com/netbox-community/netbox-docker/blob/release/configuration/logging.py) and [extra.py](https://github.com/netbox-community/netbox-docker/blob/release/configuration/extra.py) if you customize those as well.

### Step 3

[Customize all files in /env.](https://github.com/netbox-community/netbox-docker/wiki/Configuration#configure-for-production) You'll want to make sure to store passwords and secrets in a secure way - aka your secrets vault and not plaintext.

### Step 4

Build the custom netbox-plugins container and publish it to ghcr.io

```bash
docker login --username randygagnon --password <yourPATtoken> ghcr.io
```

```bash
docker build . -t ghcr.io/randygagnon/netbox-plugins:latest
```

```bash
docker push ghcr.io/randygagnon/netbox-plugins:latest
```

### Step 5

Run the docker compose to start Netbox

```bash
docker compose pull
docker compose up
```

### Step 6

Configure the Superuser and Password

```bash

```
