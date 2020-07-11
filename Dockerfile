FROM alpine:edge

RUN apk --no-cache add --virtual build-base llvm9-dev \
    && find / -name *llvm* \
    && ls /usr/lib/llvm9/bin/llvm-config

