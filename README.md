# Docker WordPress

![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-wordpress) ![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Fwordpress) ![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Fwordpress) ![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/bfren/docker-wordpress/dev.yml?branch=main)

[Docker Repository](https://hub.docker.com/r/bfren/wordpress) - [bfren ecosystem](https://github.com/bfren/docker)

Comes with [WordPress](https://en-gb.wordpress.org) en_GB preinstalled - if you want a different locale, use the Dockerfiles and set the `WP_LOCALE` argument.  [Ninja Firewall](https://wordpress.org/plugins/ninjafirewall/) is also preinstalled and setup to work in [Full WAF mode](https://blog.nintechnet.com/full_waf-vs-wordpress_waf/).

The required and recommended PHP modules are all installed.

## Contents

* [Ports](#ports)
* [Volumes](#volumes)
* [Environment Variables](#environment-variables)
* [Helper Functions](#helper-functions)
* [Nginx Configuration Helpers](#nginx-configuration-helpers)
* [Licence / Copyright](#licence)

## Ports

* 80

## Volumes

| Volume         | Purpose                   |
| -------------- | ------------------------- |
| `/wp-content`  | `wp-content` directories. |

See the [Nginx](https://github.com/bfren/docker-nginx) image for other configuration details.

## Environment Variables

See the [Nginx + PHP](https://github.com/bfren/docker-nginx-php) image for details of `www.conf` and `php.ini` overrides using environment variables.

| Variable                       | Values           | Description                                                                                                                                                                                   | Default                                               |
| ------------------------------ | ---------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------- |
| `WP_CLEAN_INSTALL`             | 0 or 1           | Set to 1 to wipe WordPress files and start again (WARNING: YOU WILL LOSE EVERYTHING!).                                                                                                        | 0                                                     |
| `WP_CONFIG_ADDITIONAL`         | string           | Additional configuration settings to add to the end of config.php - use in conjunction with WP_CONFIG_GENERATE=harden.                                                                        | *None*                                                |
| `WP_CONFIG_HARDEN`             | 0 or 1           | Default value 1 generates wp-config.php each time and makes readonly. Value 0 generates if it does not exist, and makes it writeable - helpful for plugins that need to write values to it.   | 'harden'                                              |
| `WP_DB_NAME`                   | string           | Database name.                                                                                                                                                                                | *None* - required if `WP_CONFIG_GENERATE` is 'harden' |
| `WP_DB_USER`                   | string           | Database username.                                                                                                                                                                            | *None* - required if `WP_CONFIG_GENERATE` is 'harden' |
| `WP_DB_PASS`                   | string           | Database password.                                                                                                                                                                            | *None* - required if `WP_CONFIG_GENERATE` is 'harden' |
| `WP_DB_HOST`                   | string           | Database host.                                                                                                                                                                                | *None* - required if `WP_CONFIG_GENERATE` is 'harden' |
| `WP_DB_CHARSET`                | string           | Database character set (leave as default if not sure).                                                                                                                                        | utf8mb4                                               |
| `WP_DB_COLLATE`                | string           | Database collation (leave blank if not sure).                                                                                                                                                 | *None*                                                |
| `WP_DB_PREFIX`                 | string           | Database table prefix - an underscore will be added automatically.                                                                                                                            | wp                                                    |
| `WP_DEBUG`                     | true or false    | Whether or not to enable debug mode.                                                                                                                                                          | false                                                 |
| `WP_DISABLE_MAJOR_UPDATES`     | 0 or 1           | Set to 0 to enable WordPress core major system updates (otherwise they are handled by the image).                                                                                             | 1                                                     |
| `WP_ENABLE_HTTPS_BEHIND_PROXY` | 0 or 1           | Whether or not to enable HTTPS behind a proxy server.                                                                                                                                         | 1                                                     |
| `WP_INSTALL_NINJAFIREWALL`     | 0 or 1           | Whether or not to install the NinjaFirewall plugin.                                                                                                                                           | 1                                                     |
| `WP_REDIS_HOST`                | string           | Set to enable redis on the specified host.                                                                                                                                                    | *None*                                                |
| `WP_REDIS_PORT`                | integer          | Set to override the default redis port (6379).                                                                                                                                                | *None*                                                |
| `WP_USE_SYSTEM_CRON`           | 0 or 1           | Set to 0 to use WordPress cron instead of system cron (reduces page performance).                                                                                                             | 1                                                     |

## Helper Functions

| Function              | Purpose                                                                                        | Usage                 |
| --------------------- | ---------------------------------------------------------------------------------------------- | --------------------- |
| `wp-cron`             | Runs the WordPress cron - if `WP_USE_SYSTEM_CRON` is 1, will be run automatically.             | `wp-cron`             |
| `wp-content-recreate` | **Warning**: deletes everything in `/wp-content` volume and recreates using WordPress default. | `wp-content-recreate` |

## Nginx Configuration Helpers

The image contains a handful of useful Nginx configuration 'helper' files, which you can find in `/overlay/etc/nginx/helpers`.  They all begin with the prefix 'wp':

| Helper               | Description                                                                                                           |
| -------------------- | --------------------------------------------------------------------------------------------------------------------- |
| `-restrictions.conf` | Adds various security-based restrictions.                                                                             |
| `-subdirectory.conf` | Enables WordPress to run in a `wordpress` subdirectory - copy and replace with the name your own subdirectory to use. |

## Licence

> [MIT](https://mit.bfren.dev/2020)

## Copyright

> Copyright (c) 2020-2024 [bfren](https://bfren.dev) (unless otherwise stated)
