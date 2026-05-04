# node-red-midi

[![Build](https://github.com/knobo/node-red-midi/actions/workflows/build.yml/badge.svg)](https://github.com/knobo/node-red-midi/actions/workflows/build.yml)
[![GHCR](https://img.shields.io/badge/ghcr.io-knobo%2Fnode--red--midi-2496ed?logo=docker)](https://github.com/knobo/node-red-midi/pkgs/container/node-red-midi)
[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Multi-arch](https://img.shields.io/badge/arch-amd64%20%7C%20arm64-blue)](#)
[![Nightly](https://img.shields.io/badge/build-nightly-orange)](#)

> **Node-RED + ALSA + MIDI**, packaged for Linux hosts that want to route audio and MIDI through flows.

A drop-in [Node-RED](https://nodered.org/) Docker image with the missing pieces for ALSA / MIDI work:

- The `audio` group fixed to **GID 29** (matches most Linux distributions, so `/dev/snd` permissions Just Work™)
- `node-red` user added to the `audio` group
- `alsa-lib`, `alsa-utils`, and build toolchain pre-installed (so MIDI/audio Node-RED nodes compile in-container)
- HEALTHCHECK on the Node-RED HTTP endpoint
- Multi-arch builds (amd64 + arm64), nightly against upstream

## Quick start

```bash
docker run -d --name node-red \
  --device /dev/snd \
  --network host \
  -v node-red-data:/data \
  ghcr.io/knobo/node-red-midi:latest
```

Or with Compose — see [`examples/docker-compose.yml`](examples/docker-compose.yml).

## Tags

| Tag | What it is |
|---|---|
| `latest` | Most recent successful build off `main` |
| `nightly` | Last automatic rebuild against upstream `nodered/node-red:latest` |
| `vX.Y.Z` | Tagged release |
| `sha-<short>` | Per-commit immutable tag |

## Why this exists

Running Node-RED in Docker on Linux and trying to drive a MIDI device or sound card usually breaks on:

1. The container's `audio` group GID not matching the host's, so `/dev/snd/*` is owned by `nobody` inside.
2. ALSA dev headers missing — so `node-red-contrib-midi` and friends fail to `npm install`.

This image fixes both, and stays current via nightly rebuilds.

## Building locally

```bash
docker build -t node-red-midi .
```

Or pin upstream:
```bash
docker build --build-arg NODE_RED_VERSION=4.0 -t node-red-midi:nr4 .
```

## Contributing

PRs welcome. The CI pipeline runs on every push:

- `docker buildx build` (amd64 + arm64)
- Trivy security scan
- SBOM (CycloneDX) attached to the image
- Push to `ghcr.io/knobo/node-red-midi`

## License

MIT — see [LICENSE](LICENSE).
