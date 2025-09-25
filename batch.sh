#!/usr/bin/env bash
set -euo pipefail

# Uso:
#  ./batch.sh medium "arquivo 1.mp3" "arquivo 2.mp3" ...
#  ./batch.sh small *.mp3
MODEL="${1:-medium}"
shift || true

# Cria a pasta de saída se não existir
OUTDIR="transcricoes"
mkdir -p "$OUTDIR"

if [ "$#" -eq 0 ]; then
  echo "Uso: $0 <modelo> <arquivos.mp3...>"
  echo "Ex.: $0 medium \"Stories 10x 1 -logica das sequencias.mp3\" \"Stories 10x 2 - engenharia social 1.mp3\""
  exit 1
fi

for f in "$@"; do
  base=$(basename "$f")
  name="${base%.*}"

  echo -e "\n==> Transcrevendo: $f"
  whisper "$f" --model "$MODEL" --language pt --output_dir "$OUTDIR"

  echo "✅ Concluído: $f → arquivos salvos em $OUTDIR/$name.*"
done

echo -e "\n✨ Pronto! Todas as transcrições estão em $OUTDIR/"