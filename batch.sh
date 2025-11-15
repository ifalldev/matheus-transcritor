#!/usr/bin/env bash
set -euo pipefail

MODEL="${1:-medium}"
shift || true

OUTDIR="transcricoes"
mkdir -p "$OUTDIR"

WHISPER="/usr/local/bin/whisper"

if [ ! -x "$WHISPER" ]; then
  echo "❌ ERRO: Whisper não encontrado em $WHISPER"
  exit 1
fi

if [ "$#" -eq 0 ]; then
  echo "Uso: bash batch.sh <modelo> <arquivos.mp3...>"
  exit 1
fi

for f in "$@"; do
  echo -e "\n==> Transcrevendo: $f"

  $WHISPER "$f" \
    --model "$MODEL" \
    --language pt \
    --output_dir "$OUTDIR"

  echo "✅ Concluído: $f"
done

echo -e "\n✨ Todas as transcrições foram geradas em $OUTDIR/"