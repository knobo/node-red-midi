# Changelog

All notable changes to this project will be documented here.
Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
versioning follows [SemVer](https://semver.org/).

## [Unreleased]

### Added
- Initial release: Alpine-based Node-RED image with ALSA + MIDI support.
- Multi-architecture builds (linux/amd64, linux/arm64).
- Nightly rebuilds against upstream `nodered/node-red:latest`.
- Trivy vulnerability scan and SBOM publication on every build.
- HEALTHCHECK for the Node-RED HTTP endpoint.
