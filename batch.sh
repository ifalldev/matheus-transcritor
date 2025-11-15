#!/usr/bin/env bash
set -euo pipefail

MODEL="${1:-small}"
PARALLEL="${2:-2}"
shift 2 || true

mkdir -p transcricoes

python3 transcrever.py "$MODEL" "$PARALLEL" "$@"