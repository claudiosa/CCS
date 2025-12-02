import subprocess

def call_prolog_factorial(n, verbose=False, debug=False, traditional=False):
    # Base command
    cmd = ["swipl"]

    # Control verbosity
    if verbose:
        # explicit: do not suppress informational messages
        cmd.append("--quiet=false")
    else:
        # keep quiet (no banner)
        cmd.append("-q")

    # Optional extra flags
    if debug:
        cmd.append("--debug")
    if traditional:
        cmd.append("--traditional")

    # Script and goal
    cmd += ["-s", "fatorial.pl", "-g", f"run_fact({n})", "-t", "halt"]

    # Run and capture stdout/stderr
    proc = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)

    # Print raw outputs for debugging
    print("=== CMD ===")
    print(" ".join(cmd))
    print("=== STDOUT ===")
    print(proc.stdout)
    print("=== STDERR ===")
    print(proc.stderr)

    # parse numeric output from stdout if any
    out = proc.stdout.strip()
    try:
        return int(out)
    except Exception:
        return None

# Example usage:
if __name__ == "__main__":
    print("Calling Prolog ....", end = "\n")
    print(call_prolog_factorial(6, verbose=True, debug=False, traditional=False))
    print("Prolog was called ....", end = "\n")

