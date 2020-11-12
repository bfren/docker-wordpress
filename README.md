# Docker WordPress

![build](https://github.com/bencgreen/docker-wordpress/workflows/build/badge.svg)

[Docker Repository](https://hub.docker.com/r/bcgdesign/wordpress)

This comes pre-installed with WordPress.

## Ports

* 80

## Environment Variables

See the [Nginx + PHP](https://github.com/bencgreen/docker-nginx-php) image for details of `www.conf` and `php.ini` overrides using environment variables.

```bash
WORDPRESS_LOCALE="en_GB" # WordPress translation / locale
WORDPRESS_VERSION="5.5.3" # WordPress version
```

## Volumes

* `/www` - this is where the WordPress files will be installed

See the [Nginx](https://github.com/bencgreen/docker-nginx) image for details of other volumes and custom configuration.

## Authors

* [Ben Green](https://github.com/bencgreen)

## License

> MIT

## Copyright

> Copyright (c) 2020 Ben Green <https://bcgdesign.com>  
> Unless otherwise stated
