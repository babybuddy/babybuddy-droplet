# Baby Buddy Digital Ocean Droplet

This repository is used to configure and a build the Baby Buddy droplet for the Digital Ocean marketplace 1-click apps.

Configuration and settings are based on [Digital Ocean's Django 1-click droplet example](https://github.com/digitalocean/droplet-1-clicks/tree/master/django-22-04).

## Build

1. Clone and open this repository as a devcontainer

2. [Create a DigitalOcean personal access token](https://docs.digitalocean.com/reference/api/create-personal-access-token/) and set it to the `DIGITALOCEAN_TOKEN` environment variable

3. Set the [branch](https://github.com/babybuddy/babybuddy/branches/all) or [tag](https://github.com/babybuddy/babybuddy/tags) name to use for the build in [marketplace-image.json](./marketplace-image.json) under `variables.branch_or_tag`

4. Run `packer build marketplace-image.json`

## Troubleshooting

Add the `-debug` flag when building for debugging: `packer build -debug marketplace-image.json`

> In debug mode once the remote instance is instantiated, Packer will emit to the current directory an ephemeral private SSH key as a .pem file. Using that you can ssh -i <key.pem> into the remote build instance and see what is going on for debugging. The key will only be emitted for cloud-based builders. The ephemeral key will be deleted at the end of the Packer run during cleanup.

See: [Debugging Packer Builds](https://developer.hashicorp.com/packer/docs/debugging)

### Provisioning step had errors

See: [Shell provisioner with cloud-init fails on Ubuntu 24.04](https://github.com/digitalocean/marketplace-partners/issues/186)