#!/bin/bash

TAG=${TAG:-latest}

docker build --rm -t lpodkalicki/avr-toolchain:${TAG} .
