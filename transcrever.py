import sys
import warnings
warnings.filterwarnings("ignore", message="FP16 is not supported on CPU")
import time
import whisper
import os
import math
import multiprocessing
from multiprocessing import Pool
import subprocess
import json

def barra_progresso(percent, width=30):
    done = int(width * percent)
    left = width - done
    return f"[{'#' * done}{'-' * left}] {int(percent*100)}%"

def duracao_audio(path):
    cmd = [
        "ffprobe", "-v", "quiet", "-print_format", "json",
        "-show_format", "-show_streams", path
    ]
    output = subprocess.check_output(cmd).decode("utf-8")
    info = json.loads(output)
    return float(info["format"]["duration"])

def transcrever_arquivo(args):
    caminho, modelo = args

    nome = os.path.basename(caminho)
    print(f"\n🎙️ Iniciando: {nome}")

    # carregar modelo (cada processo carrega o seu)
    model = whisper.load_model(modelo)

    # obter duração do áudio
    duracao = duracao_audio(caminho)
    print(f"⏳ {nome}: duração {duracao:.2f}s")

    # tempo inicial para barra de progresso
    inicio = time.time()

    # processar transcrição
    result = model.transcribe(caminho, verbose=False)

    # barra de progresso final (apenas estética)
    while True:
        elapsed = time.time() - inicio
        percent = min(elapsed / duracao, 1.0)
        print(f"\r{nome} → {barra_progresso(percent)}", end="")
        if percent >= 1.0:
            break
        time.sleep(0.3)

    print(f"\n✔ {nome}: concluído!")

    # salvar saída somente como .txt
    nome_saida = os.path.splitext(nome)[0]
    out_path = f"transcricoes/{nome_saida}.txt"

    with open(out_path, "w", encoding="utf-8") as f:
        f.write(result["text"])

    print(f"📄 {nome}: salvo em {out_path}")

    return nome


def transcrever_varios(arquivos, modelo="small", paralelismo=2):
    print(f"\n🚀 Iniciando processamento paralelo com {paralelismo} processos…")
    os.makedirs("transcricoes", exist_ok=True)

    # criar pool
    with Pool(paralelismo) as p:
        p.map(transcrever_arquivo, [(c, modelo) for c in arquivos])

    print("\n✨ Todas as transcrições finalizadas!\n")


if __name__ == "__main__":
    modelo = sys.argv[1]
    paralelismo = int(sys.argv[2])
    arquivos = sys.argv[3:]

    transcrever_varios(arquivos, modelo, paralelismo)
