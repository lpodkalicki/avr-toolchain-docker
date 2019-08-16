FROM alpine:3.10

MAINTAINER Lukasz Marcin Podkalicki <lpodkalicki@gmail.com>

# Settings
ARG TARBALLS_PATH=contrib
ARG TOOLS_PATH=/tools

# Prepare directory for tools
RUN mkdir ${TOOLS_PATH}
WORKDIR ${TOOLS_PATH}

RUN apk --no-cache add ca-certificates wget make cmake avrdude \
	&& wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
	&& wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.29-r0/glibc-2.29-r0.apk \
	&& apk add glibc-2.29-r0.apk \
	&& rm glibc-2.29-r0.apk

# Install AVR toolchain
ARG AVR_TOOLCHAIN_TARBALL=avr8-gnu-toolchain-3.6.2.1759-linux.any.x86_64.tar.gz
ARG AVR_TOOLCHAIN_PATH=${TOOLS_PATH}/avr-toolchain
COPY ${TARBALLS_PATH}/${AVR_TOOLCHAIN_TARBALL} .
RUN tar -xvf ${AVR_TOOLCHAIN_TARBALL} \
        && mv `tar -tf ${AVR_TOOLCHAIN_TARBALL} | head -1` ${AVR_TOOLCHAIN_PATH} \
        && rm ${AVR_TOOLCHAIN_TARBALL}

ENV PATH="${AVR_TOOLCHAIN_PATH}/bin:${PATH}"

WORKDIR /build
