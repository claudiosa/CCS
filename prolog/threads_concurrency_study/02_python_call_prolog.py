import subprocess
import time
# ---------------------------------------------
# 1. Gera arquivo de fatos mirror(X, Palindromo)
# ---------------------------------------------
def generate_facts_file(filename, n):
    with open(filename, "w") as f:
        for x in range(1, n + 1):
            xs = str(x)
            palindrome = int(xs + xs[::-1])  # concatena com o reverso
            f.write(f"mirror({x}, {palindrome}).\n")
    print(f"[Python] Arquivo gerado: {filename} com {n} fatos.")


# ---------------------------------------------
# 2. Chama Prolog e captura o resultado
# ---------------------------------------------
def run_prolog_sum(fact_file, n, predicate_name="mirror"):
    cmd = [
        "swipl",
        #"-q",                    # silencioso
        "-s", "02_prolog_mirror.pl",
        "-g", f"main('{fact_file}', {n}, {predicate_name})",
        "-t", "halt"
    ]

    process = subprocess.run(
        cmd,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True
    )

    print("==== PROLOG STDOUT ====")
    print(process.stdout)
    print("==== PROLOG STDERR ====")
    print(process.stderr)

    # tenta extrair inteiro retornado
    try:
        return int(process.stdout.strip())
    except:
        return None


# ---------------------------------------------
# 3. Execução principal
# ---------------------------------------------
if __name__ == "__main__":
    N = int(input("Digite um valor N para gerar os fatos: "))

    facts_file = "mirror_facts.pl"
     
    generate_facts_file(facts_file, N)
    print("Calling the Prolog")
     # mede o tempo do subprocess inteiro (spawn + exec + retorno)
    start = time.perf_counter()
    result = run_prolog_sum(facts_file, N, "mirror")
    end = time.perf_counter()
    elapsed = end - start
    print("Resuming from Prolog")
    print(f"\n[SOMA TOTAL] = {result}")
    print(f"⏱ Tempo total (Python → Prolog → Python): {elapsed:.6f} segundos")
