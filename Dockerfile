# This file is part of Miasm-Docker.
# Copyright 2019 Camille Mougey <commial@gmail.com>
#
# Miasm-Docker is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Miasm-Docker is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
# License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Miasm-Docker. If not, see <http://www.gnu.org/licenses/>.

FROM python:3.13-slim-bookworm
LABEL maintainer="Camille Mougey <commial@gmail.com>"

# Download needed packages
RUN apt-get update && apt-get install -y --no-install-recommends \
        gcc \
        g++ \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /root/.cache

WORKDIR /opt/miasm

# Install miasm
COPY README.md /opt/miasm/README.md
COPY LICENSE /opt/miasm/LICENSE
COPY pyproject.toml /opt/miasm/pyproject.toml
COPY setup.py /opt/miasm/setup.py
COPY miasm /opt/miasm/miasm
RUN pip3 install --upgrade pip \
    && MIASM_REQUIRE_JIT=1 pip3 install --group dev '.[cparser,z3,llvm]'

# Get everything else
COPY . /opt/miasm

# Set user
RUN useradd miasm && \
    chown -Rh miasm /opt/miasm
USER miasm

# Default cmd
WORKDIR /opt/miasm/test
CMD ["/bin/bash", "-c", "python test_all.py -m"]
