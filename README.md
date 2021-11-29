# Let's Encrypt RouterOS / Mikrotik
**Let's Encrypt certificates for RouterOS / Mikrotik**

Docker container to automatically request Let's encrypt certificates and deploy them to a Mikrotik device as sstp-server, www-ssl and api-ssl certificate.

Forked from [gitpel/letsencrypt-routeros](https://github.com/gitpel/letsencrypt-routeros) with added Docker and Cloudflare (DNS) support.

### Installation on Ubuntu 20.04

Put your cloudflare API key with DNS:edit permissions into a file:
```sh
cp secrets/cloudflare-creds.example.ini secrets/cloudflare-creds.ini
chmod 600 secrets/cloudflare-creds.ini
vim secrets/cloudflare-creds.ini
```

Write the Mikrotik device's SSH hostkey to a file that can be mounted inside the container.
```
ssh-keyscan mikrotik.local > known_hosts
```

Edit docker-compose.yml, adapt configuration to your environment:
```sh
cp docker-compose.example.yml docker-compose.yml
vim docker-compose.yml
```

Generate SSH Key for RouterOS
```sh
ssh-keygen -f secrets/id_rsa -N ""
```

Copy SSH Key to RouterOS / Mikrotik
```sh
scp secrets/id_rsa.pub admin@mikrotik.local:
```

### Setup RouterOS / Mikrotik side

Make sure you have created an additional user (called "certbot" here) and enabled ssh.

```sh
:put "Add to the user DSA Public Key"
/user ssh-keys import user=certbot public-key-file=id_rsa.pub
```

### Run docker container

```sh
docker-compose build
docker-compose up -d
```