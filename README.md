# stash-Docker

Stash Docker image that supports PUID, PGID, Umask settings

```bash
docker run -d \
    --name stash \
    -e PUID=1000 \
    -e PGID=1000 \
    -e UMASK=022 \
    -v ${PWD}/config:/config \
    -p 9999:9999 \
    ddsderek/stash:latest
```

```yaml
version: '3.3'
services:
    stash:
        container_name: stash
        environment:
            - PUID=1000
            - PGID=1000
            - UMASK=022
        volumes:
            - './config:/config'
        ports:
            - '9999:9999'
        image: 'ddsderek/stash:latest'
```