# Docker WordPress

![GitHub release (latest by date)](https://img.shields.io/github/v/release/bencgreen/docker-wordpress) ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-wordpress/7.3-dev?label=github+7.3) ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-wordpress/7.4-dev?label=github+7.4) ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-wordpress/8.0-dev?label=github+8.0) ![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/wordpress?label=docker) ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/wordpress?label=pulls) ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/wordpress/latest?label=size)

[Docker Repository](https://hub.docker.com/r/bcgdesign/wordpress) - [bcg|design ecosystem](https://github.com/bencgreen/docker)

On first run this will download and install the latest version of WordPress according to the `WORDPRESS_LOCALE` environment variable - unless WordPress is detected in `/www`.

The required and recommended PHP modules are all installed.

## Contents

* [Ports](#ports)
* [Volumes](#volumes)
* [Environment Variables](#environment-variables)
* [Helper Functions](#helper-functions)
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

| Variable                    | Values                 | Description                                                                                                       | Default                                     |
| --------------------------- | ---------------------- | ----------------------------------------------------------------------------------------------------------------- | ------------------------------------------- |
| `LOCALE`                    | Valid WordPress locale | The WordPress source files for this locale will be downloaded and installed.                                      | en_GB                                       |
| `CLEAN_INSTALL`             | 0 or 1                 | Set to 1 to wipe WordPress files and start again (WARNING: YOU WILL LOSE EVERYTHING!).                            | 0                                           |
| `GENERATE_CONFIG`           | 0 or 1                 | Set to 0 to user your own `wp-config.php` - otherwise it will be generated fresh every time the container starts. | 1                                           |
| `WPDB_NAME`                 | string                 | Database name.                                                                                                    | *None* - required if `GENERATE_CONFIG` is 1 |
| `WPDB_USER`                 | string                 | Database username.                                                                                                | *None* - required if `GENERATE_CONFIG` is 1 |
| `WPDB_PASS`                 | string                 | Database password.                                                                                                | *None* - required if `GENERATE_CONFIG` is 1 |
| `WPDB_HOST`                 | string                 | Database host.                                                                                                    | *None* - required if `GENERATE_CONFIG` is 1 |
| `WPDB_CHARSET`              | string                 | Database character set (leave as default if not sure).                                                            | utf8mb4                                     |
| `WPDB_COLLATE`              | string                 | Database collation (leave blank if not sure).                                                                     | *None*                                      |
| `WPDB_PREFIX`               | string                 | Database table prefix - an underscore will be added automatically.                                                | wp                                          |
| `DEBUG`                     | true or false          | Whether or not to enable debug mode.                                                                              | false                                       |
| `ENABLE_HTTPS_BEHIND_PROXY` | 0 or 1                 | Whether or not to enable HTTPS behind a proxy server.                                                             | 1                                        |
| `USE_SYSTEM_CRON`           | 0 or 1                 | Set to 1 to use system cron instead of WordPress cron (improves page performance).                                | 1                                           |

## Helper Functions

| Function  | Purpose                                                                         | Usage     |
| --------- | ------------------------------------------------------------------------------- | --------- |
| `wp-cron` | Runs the WordPress cron - if `USE_SYSTEM_CRON` is 1, will be run automatically. | `wp-cron` |

## Authors

* [Ben Green](https://github.com/bencgreen)

## License

> MIT

## Copyright

> Copyright (c) 2021 Ben Green <https://bcgdesign.com>
> Unless otherwise stated
