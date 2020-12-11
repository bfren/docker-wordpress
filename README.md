# Docker WordPress

![Docker Image Version (latest semver)](https://img.shields.io/docker/v/bcgdesign/wordpress?sort=semver) ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-wordpress/build?label=github) ![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/wordpress?label=docker) ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/wordpress?label=pulls) ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/wordpress/latest?label=size)

[Docker Repository](https://hub.docker.com/r/bcgdesign/wordpress) - [bcg|design ecosystem](https://github.com/bencgreen/docker)

On first run this will download and install the latest version of WordPress according to the `WORDPRESS_LOCALE` environment variable - unless WordPress is detected in `/www`.

The following PHP modules are installed, as required (or recommended) by WordPress:

* `php7-cgi`
* `php7-ctype`
* `php7-curl`
* `php7-dom`
* `php7-exif`
* `php7-fileinfo`
* `php7-ftp`
* `php7-gd`
* `php7-gettext`
* `php7-iconv`
* `php7-imap`
* `php7-json`
* `php7-mbstring`
* `php7-mysqli`
* `php7-sodium`
* `php7-openssl`
* `php7-simplexml`
* `php7-soap`
* `php7-sockets`
* `php7-xml`
* `php7-xmlrpc`
* `php7-xmlreader`
* `php7-zip`
* `php7-pecl-imagick`

Additionally, `unzip` is installed for use in the installation script.

## Ports

* 80

## Environment Variables

See the [Nginx + PHP](https://github.com/bencgreen/docker-nginx-php) image for details of `www.conf` and `php.ini` overrides using environment variables.

```bash
WORDPRESS_LOCALE="en_GB"   # WordPress translation / locale
WORDPRESS_CLEAN_INSTALL=0  # set to 1 to wipe WordPress files and start again (WARNING: YOU WILL LOSE EVERYTHING!)
```

## Volumes

* `/wp` - map this to a volume to backup your configuration and `wp-content` directories
* `/www` - this is where all the WordPress files will be installed

See the [Nginx](https://github.com/bencgreen/docker-nginx) image for other configuration details.

## Authors

* [Ben Green](https://github.com/bencgreen)

## License

> MIT

## Copyright

> Copyright (c) 2020 Ben Green <https://bcgdesign.com>  
> Unless otherwise stated
