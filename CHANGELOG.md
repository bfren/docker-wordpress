# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [8.0.0] - Unreleased

### Added

- Images for `linux/arm/v7` are built again.

### Changed

- **Breaking:** base image updated to `bfren/nginx-php` 10.0.0 - see the
  [Nginx + PHP changelog](https://github.com/bfren/docker-nginx-php/blob/main/CHANGELOG.md).
  `bf env set` must now run as root.
- Images are built and published by the shared `bfren/docker` build workflow (`build.yml`), replacing the separate
  `dev.yml` and `publish.yml` workflows.

### Removed

- **Breaking:** the PHP `imap` extension - WordPress does not use it, and Alpine no longer packages it for PHP 8.4 and
  8.5. Install it in your own image if a plugin needs it.

### Fixed

- A failed plugin download no longer leaves an empty plugin directory that later starts treat as installed - which
  meant Ninja Firewall could be silently missing. An empty directory left by an earlier version is now reinstalled.

[8.0.0]: https://github.com/bfren/docker-wordpress/compare/v7.3.2...v8.0.0
