#!/bin/bash

certbot certonly \
    --dns-cloudflare \
    --dns-cloudflare-credentials "$CLOUDFLARE_CREDS"\
    -d $DOMAIN \
    -m $EMAIL \
    --agree-tos \
    --non-interactive \
    --post-hook /data/letsencrypt-routeros.sh

while /bin/true; do
    certbot renew --deploy-hook /data/letsencrypt-routeros.sh
    sleep $RENEW_INTERVAL
done