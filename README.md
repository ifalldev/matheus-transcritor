# Whisper Projeto (Transcrição de Áudios com Docker)

Este projeto usa o [Whisper](https://github.com/openai/whisper) em contêiner Docker
para transcrever áudios `.mp3` para `.txt`, `.srt` e `.vtt`.

## 🚀 Uso rápido

### Build da imagem (CPU)
```bash
docker build -t whisper-local -f Dockerfile.cpu .