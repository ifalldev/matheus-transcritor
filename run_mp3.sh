docker run --rm \
  -v "$PWD:/work" \
  -v "$HOME/.cache/whisper:/root/.cache/whisper" \
  matheus \
  batch.sh small *.mp3