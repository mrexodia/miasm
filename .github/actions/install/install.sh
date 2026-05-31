#! /bin/bash
set -euo pipefail

# codespell
python -m pip install codespell

# install
MIASM_REQUIRE_JIT=1 python -m pip install '.[cparser,z3,llvm,test]'

# extended tests
git clone https://github.com/cea-sec/miasm-extended-tests
