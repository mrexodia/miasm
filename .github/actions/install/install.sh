#! /bin/bash
set -euo pipefail

# codespell
python -m pip install codespell

# Build local miasm-jit wheel so miasm[llvm] can resolve miasm-jit==<version>
python -m pip wheel ./miasm-jit --no-deps -w .miasm-wheels

# install
python -m pip install --find-links .miasm-wheels '.[cparser,z3,llvm,test]'

# extended tests
git clone https://github.com/cea-sec/miasm-extended-tests
