#! /bin/bash
set -euo pipefail

# codespell
python -m pip install codespell

# install
MIASM_REQUIRE_JIT=1 python -m pip install --group dev '.[cparser,z3,llvm]'

# extended tests
git clone https://github.com/cea-sec/miasm-extended-tests
