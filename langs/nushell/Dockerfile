ARG VER=0.111.0

# If building from scratch is needed for some reason, upstream has a Dockerfile:
# https://github.com/nushell/nushell/blob/main/docker/Dockerfile
FROM ghcr.io/nushell/nushell:$VER-alpine AS builder

FROM codegolf/lang-base

# We don't include any of the plugins from the builder
COPY --from=builder /usr/bin/nu /usr/bin/

COPY config.nu /etc/

ENTRYPOINT ["nu"]

CMD ["--version"]
