# Overview

Lightweight docker image built on top of **alpine:3.10** with installed AVR toolchain and few additional tools:
* AVR8 toolchain (2019, AVR_8_bit_GNU_Toolchain_3.6.2_1759)
* avrdude (v6.3)
* make (v4.2)
* cmake (v3.14)

DockerHub: https://hub.docker.com/r/lpodkalicki/avr-toolchain

## Building image locally

```bash
git clone git@github.com:lpodkalicki/avr-toolchain-docker.git
cd avr-toolchain
docker build --rm -t lpodkalicki/avr-toolchain:latest .
```

## An example of running toolchain binary

```bash
docker run --rm --privileged -v $(pwd):/build lpodkalicki/avr-toolchain avr-gcc -version
```

# Installing

Bellow you can find recommended simple one-line installer that pulls the newest docker-image and installs **avr-toolchain** script into "/usr/bin/" directory.

```bash
curl https://raw.githubusercontent.com/lpodkalicki/avr-toolchain-docker/master/install.sh | bash -s --
```

## Getting started

1. Install toolchain using recommended simple one-line installer.
2. Use super command **avr-toolchain** for all toolchain binaries. 
3. Execute toolchain binaries inside your working/project directory. 

## Examples

```bash
$ cd your-project/
$ avr-toolchain avr-gcc --version
$ avr-toolchain make -version
$ avr-toolchain avrdude --help
$ avr-toolchain cmake -version
$ avr-toolchain make && make flash
```
