#!/bin/bash
#
# Copyright 2020, Data61/CSIRO
#
# SPDX-License-Identifier: BSD-2-Clause
#

set -exuo pipefail

# Source common functions
DIR="${BASH_SOURCE%/*}"
test -d "$DIR" || DIR=$PWD
# shellcheck source=utils/common.sh
. "$DIR/utils/common.sh"

# Get python deps for sel4cp
pushd /usr/local/
as_root python3.9 -m venv pyenv
as_root /usr/local/pyenv/bin/pip install --upgrade pip setuptools wheel
as_root /usr/local/pyenv/bin/pip install \
    pyoxidizer==0.17.0 \
    mypy==0.910 \
    black==21.7b0 \
    flake8==3.9.2 \
    ply==3.11 \
    Jinja2==3.0.3 \
    PyYAML==6.0 \
    pyfdt==0.3 \
    six \
    future \
    # end of list
popd
