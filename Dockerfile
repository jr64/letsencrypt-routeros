FROM certbot/dns-cloudflare

WORKDIR /data/

RUN apk add --no-cache bash openssh

ADD scripts/letsencrypt-routeros.sh letsencrypt-routeros.sh
RUN chmod +x letsencrypt-routeros.sh

ADD scripts/main.sh main.sh
RUN chmod +x main.sh

VOLUME [ "/var/lib/letsencrypt", "/etc/letsencrypt"  ]

ENTRYPOINT [ "/data/main.sh" ]