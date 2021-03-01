# Docker WordPress

![GitHub release (latest by date)](https://img.shields.io/github/v/release/bencgreen/docker-wordpress) ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-wordpress/7.3-dev?label=github+7.3) ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-wordpress/7.4-dev?label=github+7.4) ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-wordpress/8.0-dev?label=github+8.0) ![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/wordpress?label=docker) ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/wordpress?label=pulls) ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/wordpress/latest?label=size)

[Docker Repository](https://hub.docker.com/r/bcgdesign/wordpress) - [bcg|design ecosystem](https://github.com/bencgreen/docker)

On first run this will download and install the latest version of WordPress according to the `WORDPRESS_WP_LOCALE` environment variable - unless WordPress is detected in `/www`.

The required and recommended PHP modules are all installed.

## Contents

* [Ports](#ports)
* [Volumes](#volumes)
* [Environment Variables](#environment-variables)
* [Helper Functions](#helper-functions)
* [Nginx Configuration Helpers](#nginx-configuration-helpers)
* [Authors / Licence / Copyright](#authors)

## Ports

* 80

## Volumes

| Volume | Purpose                                                                                                                                          |
| ------ | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| `/www` | This is where all the WordPress files will be installed (if you are taking over an existing WordPress installation, map this to that directory). |
| `/wp`  | Map this to backup your configuration and `wp-content` directories.                                                                              |

See the [Nginx](https://github.com/bencgreen/docker-nginx) image for other configuration details.

## Environment Variables

See the [Nginx + PHP](https://github.com/bencgreen/docker-nginx-php) image for details of `www.conf` and `php.ini` overrides using environment variables.

| Variable                       | Values        | Description                                                                                 | Default                                        |
| ------------------------------ | ------------- | ------------------------------------------------------------------------------------------- | ---------------------------------------------- |
| `WP_DB_NAME`                   | string        | Database name.                                                                              | *None* - required if `WP_GENERATE_CONFIG` is 1 |
| `WP_DB_USER`                   | string        | Database username.                                                                          | *None* - required if `WP_GENERATE_CONFIG` is 1 |
| `WP_DB_PASS`                   | string        | Database password.                                                                          | *None* - required if `WP_GENERATE_CONFIG` is 1 |
| `WP_DB_HOST`                   | string        | Database host.                                                                              | *None* - required if `WP_GENERATE_CONFIG` is 1 |
| `WP_DB_CHARSET`                | string        | Database character set (leave as default if not sure).                                      | utf8mb4                                        |
| `WP_DB_COLLATE`                | string        | Database collation (leave blank if not sure).                                               | *None*                                         |
| `WP_DB_PREFIX`                 | string        | Database table prefix - an underscore will be added automatically.                          | wp                                             |
| `WP_DEBUG`                     | true or false | Whether or not to enable debug mode.                                                        | false                                          |
| `WP_ENABLE_HTTPS_BEHIND_PROXY` | 0 or 1        | Whether or not to enable HTTPS behind a proxy server.                                       | 1                                              |
| `WP_DISABLE_UPDATES`           | 0 or 1        | Set to 0 to enable WordPress core system updates (otherwise they are handled by the image). | 1                                              |
| `WP_USE_SYSTEM_CRON`           | 0 or 1        | Set to 0 to use WordPress cron instead of system cron (reduces page performance).           | 1                                              |

## Helper Functions

| Function  | Purpose                                                                         | Usage     |
| --------- | ------------------------------------------------------------------------------- | --------- |
| `wp-cron` | Runs the WordPress cron - if `WP_USE_SYSTEM_CRON` is 1, will be run automatically. | `wp-cron` |

## Nginx Configuration Helpers

The image contains a handful of useful Nginx configuration 'helper' files, which you can find in `/overlay/etc/nginx/helpers`.  They all begin with the prefix 'wp':

| Helper               | Description                                                                                                           |
| -------------------- | --------------------------------------------------------------------------------------------------------------------- |
| `-restrictions.conf` | Adds various security-based restrictions.                                                                             |
| `-subdirectory.conf` | Enables WordPress to run in a `wordpress` subdirectory - copy and replace with the name your own subdirectory to use. |

## Authors

* [Ben Green](https://github.com/bencgreen)

## License

> MIT

## Copyright

> Copyright (c) 2021 Ben Green <https://bcgdesign.com>
> Unless otherwise stated
