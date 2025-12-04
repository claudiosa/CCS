import subprocess
import time

# CONFIGURÁVEIS
N = 1000000
#N_THREADS = 5
#Number of threads = 5
#Tempo total (Python → Prolog → Python): 14.628836 s

N_THREADS = 50
#Number of threads = 50
#Tempo total (Python → Prolog → Python): 17.162353 s

FACT_FILE = "mirror_facts.pl"


############################################################
# 1. Gerar arquivo de fatos mirror(I,Y)
############################################################

def generate_facts_file(filename, n):
    with open(filename, "w") as f:
        for x in range(1, n + 1):
            xs = str(x)
            palindrome = int(xs + xs[::-1])
            f.write(f"mirror({x}, {palindrome}).\n")
    print(f"[Python] Gerado {filename} com {n} fatos.")


############################################################
# 2. Chamar Prolog
############################################################

def run_prolog_sum(fact_file, n, n_threads):
    cmd = [
        "swipl",
        "-q",
        "-s", "03_prolog_mirror.pl",
        "-g", f"main('{fact_file}', {n}, mirror, {n_threads})",
        "-t", "halt"
    ]

    inicio = time.perf_counter()

    proc = subprocess.run(
        cmd,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True
    )

    fim = time.perf_counter()
    elapsed = fim - inicio

    stdout = proc.stdout.strip()
    stderr = proc.stderr.strip()

    print("===== PROLOG STDOUT =====")
    print(stdout)
    print("===== PROLOG STDERR =====")
    print(stderr)

    try:
        result = int(stdout)
    except:
        # tenta converter a última linha em inteiro
        result = None
        for line in stdout.splitlines()[::-1]:  # percorre de trás pra frente
            line = line.strip()
            if line.isdigit():                  # a linha é só número?
                result = int(line)
                break

    return result, elapsed


############################################################
# Execução principal
############################################################

if __name__ == "__main__":
    print(f"Generating  {N} palindroms facts ...")
    generate_facts_file(FACT_FILE, N)

    print(f"\nCalling  Prolog with {N_THREADS} threads...\n")
    total, elapsed = run_prolog_sum(FACT_FILE, N, N_THREADS)

    print(f"\n[SOMA TOTAL] = {total}")
    print(f"\nNumber of threads = {N_THREADS}")
    print(f"⏱ Tempo total (Python → Prolog → Python): {elapsed:.6f} s")
