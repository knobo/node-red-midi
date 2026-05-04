ARG NODE_RED_VERSION=latest
FROM nodered/node-red:${NODE_RED_VERSION}

LABEL org.opencontainers.image.title="node-red-midi" \
      org.opencontainers.image.description="Node-RED with ALSA + MIDI support for Linux audio routing on host" \
      org.opencontainers.image.source="https://github.com/knobo/node-red-midi" \
      org.opencontainers.image.licenses="MIT"

USER root

RUN apk add --no-cache \
        alsa-lib \
        alsa-lib-dev \
        alsa-utils \
        build-base \
        python3 \
 && delgroup audio 2>/dev/null || true \
 && addgroup -g 29 audio \
 && addgroup node-red audio

USER node-red

HEALTHCHECK --interval=30s --timeout=5s --start-period=20s --retries=3 \
  CMD wget -qO- http://localhost:1880/ >/dev/null || exit 1
