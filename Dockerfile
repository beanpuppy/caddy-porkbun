ARG CADDY_VERSION

# Builder
FROM caddy:${CADDY_VERSION}-builder-alpine AS builder

RUN xcaddy build --with github.com/caddy-dns/porkbun

# Container
FROM caddy:${CADDY_VERSION}-alpine

# install additional packages
RUN apk add --no-cache tzdata curl

LABEL org.opencontainers.image.vendor="beanpuppy"
LABEL org.opencontainers.image.documentation="https://github.com/beanpuppy/caddy-porkbun"
LABEL org.opencontainers.image.source="https://github.com/beanpuppy/caddy-porkbun"

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
