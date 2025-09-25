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

<pre>bash
git clone https://github.com/SEU-USUARIO/whisper-projeto.git
cd whisper-projeto</pre>

## 🖥️ CPU (qualquer máquina)

**Build da imagem:**

<pre>bash
docker build -t whisper-local -f Dockerfile.cpu .</pre>

## ⚡ GPU NVIDIA (opcional)

**Requer drivers + NVIDIA Container Toolkit:**

<pre>docker build -t whisper-gpu -f Dockerfile.gpu .</pre>

## ▶️ Como usar

***Coloque seus áudios (.mp3) na pasta do projeto.***

1. Um arquivo (CPU)
<pre>docker run --rm \
  -v "$PWD:/work" \
  -v "$HOME/.cache/whisper:/root/.cache/whisper" \
  whisper-local \
  "Stories 10x 1 -logica das sequencias.mp3" \
  --model medium --language pt</pre>

2. Vários arquivos (com batch.sh)
<pre>docker run --rm \
  -v "$PWD:/work" \
  -v "$HOME/.cache/whisper:/root/.cache/whisper" \
  whisper-local \
  bash batch.sh medium *.mp3</pre>


***As saídas vão para a pasta `transcricoes/.`***

3. GPU (NVIDIA)
<pre>docker run --rm --gpus all \
  -v "$PWD:/work" \
  -v "$HOME/.cache/whisper:/root/.cache/whisper" \
  whisper-gpu \
  bash batch.sh large *.mp3</pre>

4. Scripts externos

**Você pode usar:**

<pre>run_docker_batch.sh (Bash, macOS/Linux)

run_docker_batch.ps1 (PowerShell, Windows)

Makefile (se usa make)</pre>

***Exemplo (Bash):***

<pre>./run_docker_batch.sh cpu medium *.mp3</pre>
