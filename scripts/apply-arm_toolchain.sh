#!/bin/bash
#

set -exuo pipefail

# Source common functions
DIR="${BASH_SOURCE%/*}"
test -d "$DIR" || DIR=$PWD
# shellcheck source=utils/common.sh
. "$DIR/utils/common.sh"

# Where will the ARM toolchain go
: "${ARM_DIR:=/usr/local}"

ARM_VER="10.2-2020.11"
ARM="gcc-arm-$ARM_VER-x86_64-aarch64-none-elf"
ARM_TAR="$ARM.tar.xz"
ARM_REV="79f65c42-1a1b-43f2-acb7-a795c8427085"
ARM_HASH="61BBFB526E785D234C5D8718D9BA8E61"
ARM_URL="https://developer.arm.com/-/media/Files/downloads/gnu-a/$ARM_VER/binrel/$ARM.tar.xz"

# Force wget to use ipv4 as docker doesn't like ipv6
wget -4 "$ARM_URL"
as_root tar -C "$ARM_DIR" -xvJf "$ARM_TAR"
as_root ln -s "$ARM_DIR/$ARM" "$ARM_DIR/gcc-arm-x86_64-aarch64-none-elf"
