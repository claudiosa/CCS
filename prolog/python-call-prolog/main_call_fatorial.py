import subprocess

def call_prolog_fatorial(n):
    """
    Calls SWI-Prolog to compute factorial(n).
    Output is just the number (e.g., "720").
    """

    cmd = [
        "swipl",
        "-q",
        "-s", "fatorial.pl",
        "-g", f"run_fact({n})",
        "-t", "halt"
    ]

    result = subprocess.run(
        cmd,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True
    )

    if result.stderr:
        print("Erro no Prolog:", result.stderr)
        return None

    output = result.stdout.strip()

    try:
        return int(output)
    except ValueError:
        print("Saída inesperada:", output)
        return None


if __name__ == "__main__":
    num = int(input("Digite um número inteiro positivo: "))
    print("Calling Prolog ....", end = "\n")
    r = call_prolog_fatorial(num)
    print(r)
    print("Backing from Prolog ....", end = "\n")

    if r is not None:
        print(f"Fatorial de {num} é: {r}")
        
