#
# Copyright 2020, Data61/CSIRO
#
# SPDX-License-Identifier: BSD-2-Clause
#

ARG USER_BASE_IMG=trustworthysystems/sel4
# hadolint ignore=DL3006
FROM $USER_BASE_IMG

# This dockerfile is a shim between the images from Dockerhub and the
# user.dockerfile.
# Add extra dependencies in here!

# For example, uncomment this to get cowsay on top of the sel4/camkes/l4v
# dependencies:

# hadolint ignore=DL3008,DL3009
RUN apt-get update -q \
    && apt-get install -y --no-install-recommends \
        python3.9-venv \
        pandoc \
        texlive-latex-base \
        texlive-latex-recommended \
        texlive-formats-extra \
        texlive-fonts-recommended

ARG MUSL_SCRIPT=apply-musl.sh
ARG MUSL_DIR="/usr/local/musl"
ARG SEL4CP_SCRIPT=apply-sel4cp_tools.sh
ARG ARM_SCRIPT=apply-arm_toolchain.sh
ARG ARM_DIR="/usr/local"

COPY scripts /tmp/

RUN /bin/bash "/tmp/${MUSL_SCRIPT}"
ENV PATH="${PATH}:${MUSL_DIR}/bin"

RUN /bin/bash "/tmp/${SEL4CP_SCRIPT}"

RUN /bin/bash "/tmp/${ARM_SCRIPT}"
ENV PATH="${PATH}:${ARM_DIR}/gcc-arm-x86_64-aarch64-none-elf/bin"
