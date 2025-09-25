docker run --rm \
  -v "$PWD:/work" \
  -v "$HOME/.cache/whisper:/root/.cache/whisper" \
  whisper-local \
  bash batch.sh medium *.mp3