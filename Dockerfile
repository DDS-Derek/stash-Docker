FROM alpine:3.17

ARG STASH_VERSION

ENV LANG=C.UTF-8 \
    PS1="\[\e[32m\][\[\e[m\]\[\e[36m\]\u \[\e[m\]\[\e[37m\]@ \[\e[m\]\[\e[34m\]\h\[\e[m\]\[\e[32m\]]\[\e[m\] \[\e[37;35m\]in\[\e[m\] \[\e[33m\]\w\[\e[m\] \[\e[32m\][\[\e[m\]\[\e[37m\]\d\[\e[m\] \[\e[m\]\[\e[37m\]\t\[\e[m\]\[\e[32m\]]\[\e[m\] \n\[\e[1;31m\]$ \[\e[0m\]" \
    STASH_CONFIG_FILE=/config/config.yml \
    PUID=1000 \
    PGID=1000 \
    UMASK=022

RUN apk add --no-cache \
        ca-certificates \
        vips-tools \
        ffmpeg \
        bash \
        su-exec \
        dumb-init \
    && \
    if [ "$(uname -m)" = "x86_64" ]; then ARCH="linux"; elif [ "$(uname -m)" = "aarch64" ]; then ARCH="linux-arm64v8"; elif [ "$(uname -m)" = "armv7l" ]; then ARCH="linux-arm32v7"; fi && \
    wget \
        --no-check-certificate \
        -O /usr/bin/stash \
        https://github.com/stashapp/stash/releases/download/${STASH_VERSION}/stash-${ARCH} \
    && \
    chmod 755 /usr/bin/stash

COPY --chmod=755 entrypoint.sh /entrypoint.sh

EXPOSE 9999

ENTRYPOINT ["/entrypoint.sh"]