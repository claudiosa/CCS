from ortools.sat.python import cp_model

def main():
    # Cria o modelo.
    model = cp_model.CpModel()

    # Define as moedas disponíveis e o valor alvo.
    coins = [1, 5, 10, 25, 50, 100]
    target_value = 119
    num_coins = len(coins)

    n_max_coins = 10   ### total de moedas na caixa
    # Variáveis de decisão: quantidade de cada tipo de moeda.
    x = [model.NewIntVar(0, n_max_coins, f'x{i}') for i in range(num_coins)]

    # Restrição: a soma dos valores das moedas deve ser igual ao valor alvo.
    model.Add(sum(coins[i] * x[i] for i in range(num_coins)) == target_value)

    # Solucionador.
    solver = cp_model.CpSolver()
    status = solver.Solve(model)

    # Verifica se uma solução foi encontrada.
    if status == cp_model.OPTIMAL or status == cp_model.FEASIBLE:
        print(f'Solução encontrada:')
        total = 0
        for i in range(num_coins):
            coin_count = solver.Value(x[i])
            total += coins[i] * coin_count
            print(f'{coins[i]} \t cent: {coin_count}  \t Partial: {total}')

        print(f'\n Total: {total} cents')
    else:
        print('None solution found it.')

if __name__ == '__main__':
    main()
