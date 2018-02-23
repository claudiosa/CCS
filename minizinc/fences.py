from collections import deque

def solve(lados, disponiveis):
    lados  = sorted(lados)
    disponiveis = deque(sorted(disponiveis))
    usadas = []
    
    for lado in lados:
        while disponiveis:
            comprimento = disponiveis.popleft()
            
            if comprimento > lado:
                usadas.append(comprimento)
                break
        
        if not disponiveis: break
        
    return list(zip(lados, usadas)), sum(usadas)

# teste
lados = [8, 9, 5, 4, 6]
disponiveis = [18, 7, 2, 3, 19, 15, 4, 14, 6, 6, 6, 7, 10, 6]

solucao = solve(lados, disponiveis)
print(solucao)
