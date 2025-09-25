# 🎙️ Whisper Projeto — Transcrição de Áudios com Docker

Este projeto usa o [Whisper](https://github.com/openai/whisper) (open-source, gratuito) em contêiner Docker para **transcrever áudios em texto** e gerar arquivos de legenda (`.txt`, `.srt`, `.vtt`).  
Tudo roda **localmente**, sem custo de API.

---

## 📌 Funcionalidades

- Transcreve `.mp3` (ou `.wav`, `.ogg`, etc.)
- Gera:
  - `.txt` → transcrição completa
  - `.srt` → legendas com timestamps
  - `.vtt` → legendas em WebVTT
- Suporte a **CPU** (qualquer máquina) ou **GPU NVIDIA** (mais rápido)
- Scripts para rodar **vários áudios em lote** (`batch.sh` ou scripts externos)

---

## 🔧 Pré-requisitos

- [Docker](https://www.docker.com/products/docker-desktop/) instalado  
  - macOS Ventura ou mais novo → Docker Desktop  
  - macOS Monterey → usar [OrbStack](https://orbstack.dev) ou [Colima](https://github.com/abiosoft/colima)  
- Pelo menos **4 GB de RAM** alocados no Docker (recomendado)

---

## 🚀 Instalação

Clone este repositório:

```bash
git clone https://github.com/SEU-USUARIO/whisper-projeto.git
cd whisper-projeto

CPU (qualquer máquina)

Build da imagem:

docker build -t whisper-local -f Dockerfile.cpu .

GPU NVIDIA (opcional)

Requer drivers + NVIDIA Container Toolkit
:

docker build -t whisper-gpu -f Dockerfile.gpu .
