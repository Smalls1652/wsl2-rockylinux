FROM docker.io/rockylinux/rockylinux:latest
COPY ./config-scripts/init.sh /tmp/init.sh
COPY ./default-bash-profile/ /tmp/default-bash-profile/
RUN chmod +x /tmp/init.sh; \
    /tmp/init.sh; \
    rm /tmp/init.sh