FROM docker.io/rockylinux/rockylinux:latest
COPY ./config-scripts/init.sh /tmp/init.sh
RUN chmod +x /tmp/init.sh; \
    /tmp/init.sh; \
    rm /tmp/init.sh