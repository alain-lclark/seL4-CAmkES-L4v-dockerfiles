#!/bin/bash
#

set -exuo pipefail

# Source common functions
DIR="${BASH_SOURCE%/*}"
test -d "$DIR" || DIR=$PWD
# shellcheck source=utils/common.sh
. "$DIR/utils/common.sh"

# Where will the MUSL library go
: "${MUSL_DIR:=/usr/local/musl}"

as_root mkdir "$MUSL_DIR"

MUSL_VER="1.2.2"
MUSL="musl-$MUSL_VER"
MUSL_TAR="$MUSL.tar.gz"
MUSL_URL="https://musl.libc.org/releases/$MUSL_TAR"

# Force wget to use ipv4 as docker doesn't like ipv6
wget -4 "$MUSL_URL"
tar -xvzf "$MUSL_TAR"

pushd "$MUSL"
./configure --prefix="$MUSL_DIR"
make
as_root make install
popd
