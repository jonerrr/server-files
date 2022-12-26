# Server Configuration

This repo includes my configuration files for various services I use.

## Overview

The `containers` folder contains many other folders, each with docker compose files and other configuration files if needed. Almost all apps store their important data in a `VOLUMES` folder that you will need to create. There is also a `BACKUPS` folder that stores most of the backup data. Backups are created by Restic and use RClone + Backblaze to store them. Sensitive data is stored in environment variables. Apps that require a web UI are behind traefik, a reverse proxy, and authelia, an SSO portal.

## Containers (not everything is listed here)

### Media

- Bazarr
- Calibre
- Calibre Web
- Overseerr
- Plex
- Prowlarr
- QBittorrent
- Radarr
- Readarr
- SABnzbd
- Sonarr
- Tautulli
- Tdarr
- Unpackerr

### Metrics and Monitoring

- Diun
- Grafana
- InfluxDB
- Loki
- Promtail
- Portainer
- Telegraf
- ~~Node Exporter~~ (soon to replace telegraf)
- ~~Prometheus~~ (soon to replace InfluxDB)
- ~~CAAdvisor~~ (soon)
- ~~Varken~~ (soon)

### Game Servers

- Ark
- Minecraft

### Other

- Authelia
- Traefik
- Code Server
- Gitlab
- Flaresolverr
- MongoDB
- Vaultwarden

## Disclaimer

This is not something you can setup in 5 minutes, there are many files and configuration not listed here. I am posting this mostly for other people who need a reference for their Docker containers. If you need support or want to provide feedback, contact me on [discord](https://discord.gg/avQZrSyXFf) or create an issue.
