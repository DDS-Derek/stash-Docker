#!/bin/bash

if [ ! -d /config ]; then
    mkdir /config
fi

chown -R ${PUID}:${PGID} /config

export "USER=${PUID}:${PGID}"

umask ${UMASK}

exec su-exec ${PUID}:${PGID} /usr/bin/stash --host 0.0.0.0 --port 9999