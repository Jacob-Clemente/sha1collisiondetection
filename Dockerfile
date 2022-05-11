# Build Stage
FROM --platform=linux/amd64 ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y clang

## Add source code to the build stage.
ADD . /sha1collisiondetection
WORKDIR /sha1collisiondetection

## TODO: ADD YOUR BUILD INSTRUCTIONS HERE.
RUN clang -fsanitize=fuzzer src/main.c lib/sha1.c lib/ubc_check.c -Ilib -o sha1collisiondetection

#Package Stage
FROM --platform=linux/amd64 ubuntu:20.04

## TODO: Change <Path in Builder Stage>
COPY --from=builder /sha1collisiondetection/sha1collisiondetection /
