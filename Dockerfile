FROM alpine:3.14

MAINTAINER Lukasz Marcin Podkalicki <lpodkalicki@gmail.com>

# Settings
ARG TARBALLS_PATH=contrib

# Prepare directory for tools
ARG TOOLS_PATH=/tools
RUN mkdir ${TOOLS_PATH}
WORKDIR ${TOOLS_PATH}

# Install basic programs and custom glibc
ARG GLIBC_VERSION=2.33-r0
ARG GLIBC_APK_NAME=glibc-${GLIBC_VERSION}.apk
ARG GLIBC_APK_DOWNLOAD_URL=https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/${GLIBC_APK_NAME}
RUN apk --no-cache add ca-certificates wget make cmake stlink \
        && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
        && wget ${GLIBC_APK_DOWNLOAD_URL} \
        && apk add ${GLIBC_APK_NAME} \
        && rm ${GLIBC_APK_NAME}

# Install AVR toolchain
ARG AVR_TOOLCHAIN_TARBALL=avr8-gnu-toolchain-3.6.2.1778-linux.any.x86_64.tar.gz
ARG AVR_TOOLCHAIN_PATH=${TOOLS_PATH}/avr-toolchain
COPY ${TARBALLS_PATH}/${AVR_TOOLCHAIN_TARBALL} .
RUN tar -xvf ${AVR_TOOLCHAIN_TARBALL} \
        && mv `tar -tf ${AVR_TOOLCHAIN_TARBALL} | head -1` ${AVR_TOOLCHAIN_PATH} \
        && rm ${AVR_TOOLCHAIN_TARBALL}

ENV PATH="${AVR_TOOLCHAIN_PATH}/bin:${PATH}"

WORKDIR /build
