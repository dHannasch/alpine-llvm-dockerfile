FROM alpine:edge

# With llvm9-dev installed, /usr/lib/llvm9/bin/llvm-config is not appearing, even though it should
# according to https://pkgs.alpinelinux.org/contents?branch=edge&name=llvm9-dev&arch=x86_64&repo=main
# (as should /usr/bin/llvm9-config for that matter).
RUN apk --no-cache add --virtual llvm9-dev \
    && find / -name *llvm* \
    && ls /usr/lib/llvm9/bin/llvm-config

