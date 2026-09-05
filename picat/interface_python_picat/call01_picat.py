import tkinter as tk
import subprocess

def calcular():
    x = entrada1.get()
    y = entrada2.get()

    resultado = subprocess.run(
        ["picat", "soma.pi", x, y],
        capture_output=True,
        text=True
    )

    saida.config(text="Resultado: " + resultado.stdout.strip())


janela = tk.Tk()
janela.title("Python + Picat")
janela.geometry("300x180")

tk.Label(janela, text="Número 1:").pack()
entrada1 = tk.Entry(janela)
entrada1.pack()

tk.Label(janela, text="Número 2:").pack()
entrada2 = tk.Entry(janela)
entrada2.pack()

tk.Button(janela, text="Somar", command=calcular).pack(pady=10)

saida = tk.Label(janela, text="Resultado:")
saida.pack()

janela.mainloop()