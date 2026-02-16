# fpm-apache-zookeeper

A simple Makefile to create `.deb`, `.rpm` and `.apk` packages of the upstream Apache Zookeeper.

## Building a [deb|rpm] package

To download a specific version of the Apache Zookeeper, update the `Makefile` variable `VERSION`, then run:
```bash
$> make
```
The `VERSION` variable can be overridden by explicitly providing the `VERSION` environment variable to all Makefile targets, like so:

```bash
$> VERSION=3.9.4 make

$> VERSION=3.9.4 make deb
```

To build a deb package for Ubuntu or Debian based Linux distributions, run the Makefile as follows:

```bash
$> make deb
```

To build an RPM package, run as follows:

```bash
$> make rpm
```

To create an APK package (for Alpine) run:

```bash
$> make apk
```

The makefile will automatically download the `tar.gz` package from https://dlcdn.apache.org/zookeeper/ and repackage it.

To clean all packages and downloaded files run `make clean`.

## Prerequisites

In order to create DEB, RPM and APK packages, this project uses [nFPM](https://nfpm.goreleaser.com/); if not available locally, it uses `go install` to install it, so both `make` and `go` must already be available on the packaging machine if you don't want to install nFPM manually.
