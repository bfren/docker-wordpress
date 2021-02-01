# Docker WordPress

![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/bcgdesign/wordpress/latest) ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-wordpress/7.3?label=github+7.3) ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-wordpress/7.4?label=github+7.4) ![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/wordpress?label=docker) ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/wordpress?label=pulls) ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/wordpress/latest?label=size)

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

| Variable                  | Values                 | Description                                                                            | Default |
| ------------------------- | ---------------------- | -------------------------------------------------------------------------------------- | ------- |
| `WORDPRESS_LOCALE`        | Valid WordPress locale | The WordPress source files for this locale will be downloaded and installed.           | en_GB   |
| `WORDPRESS_CLEAN_INSTALL` | 0 or 1                 | Set to 1 to wipe WordPress files and start again (WARNING: YOU WILL LOSE EVERYTHING!). | 0       |
| `USE_SYSTEM_CRON`         | 0 or 1                 | Set to 1 to use system cron instead of WordPress cron (improves page performance).     | 0       |

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
