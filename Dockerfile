FROM dahanna/python-alpine-package:pandas-alpine
# Numba does not require SciPy,
# but we want to keep a minimum number of images for simplicity, and
# most of the things that require Numba also require SciPy.

# Since this image is intended for continuous integration, we want to
# keep the size down, hence Alpine.
# Some packages might have tests that take much longer than it could ever
# take to download even a large Docker image, but we want this image to
# be applicable to all packages including small packages.
# python:3.7-alpine is 32.27MB.

# An apk del in an extra layer has no benefit.
# Removing files makes images larger, not smaller.
# You must apk add and apk del in the same layer to benefit from it.
# The --no-cache option means to not cache the index locally, which is useful for keeping containers small.
# --no-cache equals apk update in the beginning and rm -rf /var/cache/apk/* in the end.

# Building llvmlite requires LLVM 9.0.x, Alpine 3.10 only has llvm8 available
# RuntimeError: Building llvmlite requires LLVM 9.0.x, got '10.0.0'.
# need make or else FileNotFoundError: [Errno 2] No such file or directory: 'make'
# need py3-numpy-dev else fatal error: numpy/ndarrayobject.h: No such file or directory
# need libtbb-dev else TBB not found
RUN apk --no-cache add --virtual llvm9-dev \
    && find / -name *llvm* \
    && ls /usr/lib/llvm9/bin/llvm-config

