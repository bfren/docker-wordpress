# WordPress

![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-wordpress) ![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Fwordpress) ![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Fwordpress) ![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/bfren/docker-wordpress/dev.yml?branch=main)

[Docker Hub](https://hub.docker.com/r/bfren/wordpress) - [Quay.io](https://quay.io/repository/bfren/wordpress) - [bfren ecosystem](https://github.com/bfren/docker)

## Introduction

[WordPress](https://wordpress.org), with the core files kept read-only inside the image, and everything that changes - themes, plugins, uploads and `wp-config.php` - in one volume.

It is [Nginx + PHP](https://github.com/bfren/docker-nginx-php) with:

* WordPress 7.1.3 (British English) installed read-only, so core updates come from pulling a new image and can't be changed by plugins or attackers
* the PHP extensions WordPress requires and recommends, including Imagick and Redis (PHP 8 builds)
* `wp-config.php` generated from environment variables, with secret keys downloaded once and kept
* WordPress's scheduled tasks run every minute by the system's cron, instead of on page loads
* the [WP-WebAuthn](https://wordpress.org/plugins/wp-webauthn/) plugin (passkey logins) and, optionally, [NinjaFirewall](https://wordpress.org/plugins/ninjafirewall/) installed for you
* nginx rules that block access to hidden files and to PHP files in uploads

It is designed to run behind a reverse proxy that handles SSL, such as [Caddy Proxy](https://github.com/bfren/docker-caddy-proxy).

## Quickstart

With a MariaDB database (e.g. [bfren/mariadb](https://github.com/bfren/docker-mariadb)):

```yaml
services:
  wordpress:
    image: quay.io/bfren/wordpress:php8.4-7.1
    environment:
      - BF_WP_DB_HOST=db
      - BF_WP_DB_NAME=wordpress
      - BF_WP_DB_USER=wordpress
      - BF_WP_DB_PASS=change-me
    ports:
      - "8080:80"
    volumes:
      - ./v/wp-content:/wp-content
```

Open the site and follow WordPress's installation (site title and admin user).

## Features

* 🔒 Read-only WordPress core, with minor updates only through new images
* 📝 `wp-config.php` generated from environment variables at every start
* ⏰ System cron for WordPress's scheduled tasks
* 🛡️ Optional NinjaFirewall in full web application firewall mode, and WebAuthn passkey logins
* ⚡ Redis object cache settings, for use with a Redis plugin
* 🐘 PHP 7.4 to 8.5 - choose with the image tag
* 🗜️ Everything from [Nginx + PHP](https://github.com/bfren/docker-nginx-php#features): PHP-FPM, OPcache, compression and logs
* 🩺 Health check that loads the login page
* 🖥️ Built for `linux/amd64`, `linux/arm64` and `linux/arm/v7`

## Tags

Images are published to Docker Hub (`bfren/wordpress`) and Quay.io (`quay.io/bfren/wordpress`). Tags start with the PHP version, and can include the WordPress version.

| Tag                          | Example                 | Use when                                    |
| ---------------------------- | ----------------------- | ------------------------------------------- |
| `phpX.Y`                     | `php8.4`                | You want the latest image for a PHP version |
| `phpX.Y-MAJOR`               | `php8.4-7`              | You want updates, but not breaking changes  |
| `phpX.Y-MINOR`               | `php8.4-7.1`            | You want fixes only - **recommended**       |
| `phpX.Y-VERSION`             | `php8.4-7.1.34`         | You want to pin this image exactly          |
| `phpX.Y-wpA.B`               | `php8.4-wp7.1`          | You want to stay on a WordPress version     |
| `phpX.Y-wpA.B.C`             | `php8.4-wp7.1.3`        | You want an exact WordPress release         |
| `…-VERSION` versions of both | `php8.4-wp7.1.3-7.1.34` | You want to pin both                        |
| `phpX.Y.Z`                   | `php8.4.26`             | You want an exact PHP release               |

There is no `latest` tag. PHP 8.1 and older no longer receive security fixes - see [Nginx + PHP](https://github.com/bfren/docker-nginx-php#tags) for support dates.

## Configuration

### Ports

| Port | Purpose                                            |
| ---- | -------------------------------------------------- |
| `80` | HTTP - put a reverse proxy in front of it for SSL. |

### Volumes

| Volume        | Purpose                                                                                                |
| ------------- | ------------------------------------------------------------------------------------------------------ |
| `/wp-content` | Themes, plugins, uploads and languages, plus `wp-config.php` and `salt` (the secret keys). Back it up. |

### Environment Variables

| Variable                          | Values          | Description                                                                                                                        | Default   |
| --------------------------------- | --------------- | ---------------------------------------------------------------------------------------------------------------------------------- | --------- |
| `BF_WP_DB_HOST`                   | host name       | **Required.** Database server.                                                                                                     | *blank*   |
| `BF_WP_DB_NAME`                   | text            | **Required.** Database name.                                                                                                       | *blank*   |
| `BF_WP_DB_USER`                   | text            | **Required.** Database user.                                                                                                       | *blank*   |
| `BF_WP_DB_PASS`                   | text            | **Required.** Database password.                                                                                                   | *blank*   |
| `BF_WP_DB_PREFIX`                 | text            | Table prefix - an underscore is added (e.g. `wp_`).                                                                                | `wp`      |
| `BF_WP_DB_CHARSET`                | text            | Database character set.                                                                                                            | `utf8mb4` |
| `BF_WP_DB_COLLATE`                | text            | Database collation - leave blank unless you know you need it.                                                                      | *blank*   |
| `BF_WP_DEBUG`                     | `true`, `false` | WordPress debug mode.                                                                                                              | `false`   |
| `BF_WP_CONFIG_REGENERATE`         | `0`, `1`        | `1` generates `wp-config.php` at every start. `0` only generates it if it doesn't exist, so you can edit it yourself.              | `1`       |
| `BF_WP_CONFIG_HARDEN`             | `0`, `1`        | `1` makes `wp-config.php` read-only to WordPress. `0` makes it writable, for plugins that need to change it.                       | `1`       |
| `BF_WP_CONFIG_ADDITIONAL`         | PHP code        | Extra lines added to `wp-config.php`, e.g. `define( 'WP_MEMORY_LIMIT', '256M' );`.                                                 | *blank*   |
| `BF_WP_ENABLE_HTTPS_BEHIND_PROXY` | `0`, `1`        | Treat requests as HTTPS when the proxy sends `X-Forwarded-Proto: https`.                                                           | `1`       |
| `BF_WP_USE_SYSTEM_CRON`           | `0`, `1`        | Run scheduled tasks from the system's cron every minute, instead of during page loads.                                             | `1`       |
| `BF_WP_DISABLE_MAJOR_UPDATES`     | `0`, `1`        | Limit WordPress's automatic core updates to minor releases.                                                                        | `1`       |
| `BF_WP_INSTALL_WEBAUTHN`          | `0`, `1`        | Install the WP-WebAuthn plugin (you still activate it in WordPress).                                                               | `1`       |
| `BF_WP_INSTALL_NINJAFIREWALL`     | `0`, `1`        | Install NinjaFirewall and set up full firewall mode - **only after WordPress is installed** (see [NinjaFirewall](#ninjafirewall)). | `0`       |
| `BF_WP_REDIS_HOST`                | host name       | Redis server for an object cache plugin.                                                                                           | *blank*   |
| `BF_WP_REDIS_PORT`                | port            | Redis port, if not 6379.                                                                                                           | *blank*   |

`BF_NGINX_HEALTHCHECK_URI` is set to `http://localhost/wp-login.php`. [Nginx + PHP](https://github.com/bfren/docker-nginx-php#environment-variables) adds the PHP settings, and [Nginx](https://github.com/bfren/docker-nginx#environment-variables) the nginx ones.

## How It Works

### Starting

When the container starts, [Nginx + PHP](https://github.com/bfren/docker-nginx-php#starting) sets up nginx and PHP, then this image:

1. **Content** - if `/wp-content` is empty, fills it with WordPress's default content, then links WordPress's own `wp-content` folder to it
2. **Configuration** - generates `/wp-content/wp-config.php` from the environment variables (or keeps yours, with `BF_WP_CONFIG_REGENERATE=0`) and links it into WordPress. The secret keys are downloaded from WordPress.org the first time and saved in `/wp-content/salt`, so logins survive restarts
3. **Plugins** - installs WP-WebAuthn and NinjaFirewall, if enabled and not already installed
4. **Permissions** - makes `/wp-content` owned by the `www` user, and `wp-config.php` read-only (or writable, with `BF_WP_CONFIG_HARDEN=0`)

If any step fails - e.g. a required database variable is missing - the container stops. Check `docker logs`.

### Updates

The WordPress core files are read-only, so WordPress can't update itself - pull a new image instead. Plugins and themes are in `/wp-content`, so update them from WordPress as normal. The "background updates" check in Site Health is removed, as it would always fail.

### Scheduled tasks

With `BF_WP_USE_SYSTEM_CRON=1`, WordPress's own cron is turned off in `wp-config.php`, and the system cron runs `wp-cron` every minute, which requests `http://localhost/wp-cron.php`. Run it yourself with `docker exec <container> wp-cron`.

### NinjaFirewall

With `BF_WP_INSTALL_NINJAFIREWALL=1`, the plugin is installed and two files are generated so it runs in full web application firewall mode (before WordPress loads). Turn this on **only after** WordPress has been installed - otherwise the firewall blocks the installation. Then activate and set up the plugin in WordPress.

### nginx

The site blocks hidden files (e.g. `.htaccess`) and PHP files in `uploads` (`helpers/wp-restrictions.conf`), and routes "pretty" permalinks to `index.php`. `helpers/wp-subdirectory.conf` is an example for running WordPress in a `/wordpress` sub-folder - copy it and change the name.

## Testing

```sh
./test.sh        # builds the image and runs /test
```

This image has no tests of its own. `/test` runs the tests inherited from the base images, and fails if tests don't execute.

## Troubleshooting

### The container stops at start-up with "You must define WP_DB_…"

Set all four database variables: `BF_WP_DB_HOST`, `BF_WP_DB_NAME`, `BF_WP_DB_USER` and `BF_WP_DB_PASS`.

### Changes I made to `wp-config.php` disappear

It is regenerated at every start. Use `BF_WP_CONFIG_ADDITIONAL` for extra settings, or set `BF_WP_CONFIG_REGENERATE=0` to manage the file yourself.

### A plugin says it can't write to `wp-config.php`

Set `BF_WP_CONFIG_HARDEN=0`.

### Links and redirects use `http://` behind my proxy

Check the proxy sends `X-Forwarded-Proto: https`, and that `BF_WP_ENABLE_HTTPS_BEHIND_PROXY` is `1`.

### WordPress says an update is available but won't install it

Core updates come with the image - pull the latest tag and recreate the container.

## Licence

> [MIT](https://mit.bfren.dev/2020)

## Copyright

> Copyright (c) 2020-2026 [bfren](https://bfren.dev) (unless otherwise stated)
