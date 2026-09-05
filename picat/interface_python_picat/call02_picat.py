import tkinter as tk
import subprocess
import json

def calcular():
    x = entrada1.get()
    y = entrada2.get()

    resultado = subprocess.run(
        ["picat", "operations.pi", x, y],
        capture_output=True,
        text=True
    )
    
    dados = json.loads(resultado.stdout)

    saida.config(
        text=f"Soma: {dados['soma']}\n"
             f"Produto: {dados['produto']}\n"
             f"Diferença: {dados['diferenca']}"
    )

janela = tk.Tk()
janela.title("Python + Picat")
janela.geometry("300x280")

tk.Label(janela, text="Número 1:").pack()
entrada1 = tk.Entry(janela)
entrada1.pack()

tk.Label(janela, text="Número 2:").pack()
entrada2 = tk.Entry(janela)
entrada2.pack()

tk.Button(
    janela,
    text="Calcular",
    command=calcular
).pack(pady=10)

saida = tk.Label(janela, text=" Resultados ")
saida.pack()

janela.mainloop()