FROM alpine:3.11

ENV CHECK_URL="https://status.aws.amazon.com/"

# Following https://docs.aws.amazon.com/storagegateway/latest/userguide/gateway-private-link.html

RUN apk add squid curl tini --update && \
chown squid.squid /var/run/ && \
mkdir /var/spool/squid && \
chown squid.squid /var/spool/squid

ADD squid.conf /etc/squid/squid.conf

EXPOSE 3128

VOLUME /var/spool/squid

ADD health.sh /bin/health.sh

HEALTHCHECK --interval=5m --timeout=5s CMD /bin/health.sh

USER squid

ENTRYPOINT ["/sbin/tini", "--"]

CMD squid -f /etc/squid/squid.conf -NYCd 1