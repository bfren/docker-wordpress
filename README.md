# Docker WordPress

![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-wordpress) ![Docker Pulls](https://img.shields.io/docker/pulls/bfren/wordpress?label=pulls) ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bfren/wordpress/php8.0?label=size)<br/>
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-wordpress/dev-php7_3?label=PHP+7.3) ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-wordpress/dev-php7_4?label=PHP+7.4) ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-wordpress/dev-php8_0?label=PHP+8.0)

[Docker Repository](https://hub.docker.com/r/bfren/wordpress) - [bfren ecosystem](https://github.com/bfren/docker)

Comes with [WordPress](https://en-gb.wordpress.org) en_GB preinstalled - if you want a different locale, use the Dockerfiles and set the `WP_LOCALE` argument.

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

| Variable                       | Values        | Description                                                                                       | Default                                        |
| ------------------------------ | ------------- | ------------------------------------------------------------------------------------------------- | ---------------------------------------------- |
| `WP_DB_NAME`                   | string        | Database name.                                                                                    | *None* - required if `WP_GENERATE_CONFIG` is 1 |
| `WP_DB_USER`                   | string        | Database username.                                                                                | *None* - required if `WP_GENERATE_CONFIG` is 1 |
| `WP_DB_PASS`                   | string        | Database password.                                                                                | *None* - required if `WP_GENERATE_CONFIG` is 1 |
| `WP_DB_HOST`                   | string        | Database host.                                                                                    | *None* - required if `WP_GENERATE_CONFIG` is 1 |
| `WP_DB_CHARSET`                | string        | Database character set (leave as default if not sure).                                            | utf8mb4                                        |
| `WP_DB_COLLATE`                | string        | Database collation (leave blank if not sure).                                                     | *None*                                         |
| `WP_DB_PREFIX`                 | string        | Database table prefix - an underscore will be added automatically.                                | wp                                             |
| `WP_CONFIG_HARDEN`             | 0 or 1        | Set to 1 to make `wp-config.php` read-only to the web server user.                                | 0                                              |
| `WP_DEBUG`                     | true or false | Whether or not to enable debug mode.                                                              | false                                          |
| `WP_ENABLE_HTTPS_BEHIND_PROXY` | 0 or 1        | Whether or not to enable HTTPS behind a proxy server.                                             | 1                                              |
| `WP_DISABLE_MAJOR_UPDATES`     | 0 or 1        | Set to 0 to enable WordPress core major system updates (otherwise they are handled by the image). | 1                                              |
| `WP_USE_SYSTEM_CRON`           | 0 or 1        | Set to 0 to use WordPress cron instead of system cron (reduces page performance).                 | 1                                              |

## Helper Functions

| Function              | Purpose                                                                                        | Usage                 |
| --------------------- | ---------------------------------------------------------------------------------------------- | --------------------- |
| `wp-cron`             | Runs the WordPress cron - if `WP_USE_SYSTEM_CRON` is 1, will be run automatically.             | `wp-cron`             |
| `wp-content-recreate` | **Warning**: deletes everything in `/wp-content` volume and recreates using WordPress default. | `wp-content-recreate` |
| `wp-content-setperms` | Sets the correct permissions on `/wp-content` volume.                                          | `wp-content-setperms` |

## Nginx Configuration Helpers

The image contains a handful of useful Nginx configuration 'helper' files, which you can find in `/overlay/etc/nginx/helpers`.  They all begin with the prefix 'wp':

| Helper               | Description                                                                                                           |
| -------------------- | --------------------------------------------------------------------------------------------------------------------- |
| `-restrictions.conf` | Adds various security-based restrictions.                                                                             |
| `-subdirectory.conf` | Enables WordPress to run in a `wordpress` subdirectory - copy and replace with the name your own subdirectory to use. |

## Licence

> [MIT](https://mit.bfren.dev/2020)

## Copyright

> Copyright (c) 2020-2022 [bfren](https://bfren.dev) (unless otherwise stated)
