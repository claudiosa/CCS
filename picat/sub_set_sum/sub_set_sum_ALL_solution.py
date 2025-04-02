from ortools.sat.python import cp_model

def main():
    # Cria o modelo.
    model = cp_model.CpModel()

    # Define as moedas disponíveis e o valor alvo.
    coins = [1, 5, 10, 25, 50, 100]
    target_value = 119
    num_coins = len(coins)

    # Variáveis de decisão: quantidade de cada tipo de moeda.
    x = [model.NewIntVar(0, 10, f'x{i}') for i in range(num_coins)]

    # Restrição: a soma dos valores das moedas deve ser igual ao valor alvo.
    model.Add(sum(coins[i] * x[i] for i in range(num_coins)) == target_value)

    # Solucionador.
    solver = cp_model.CpSolver()

    # Lista para armazenar todas as soluções.
    solutions = []

    class SolutionCollector(cp_model.CpSolverSolutionCallback):
        def __init__(self, variables):
            cp_model.CpSolverSolutionCallback.__init__(self)
            self.__variables = variables

        def on_solution_callback(self):
            solution = [self.Value(v) for v in self.__variables]
            solutions.append(solution)

    # Configura o solucionador para encontrar todas as soluções.
    solution_collector = SolutionCollector(x)
    solver.parameters.max_time_in_seconds = 10.0
    status = solver.SearchForAllSolutions(model, solution_collector)

    # Verifica se soluções foram encontradas.
    if status == cp_model.OPTIMAL or status == cp_model.FEASIBLE:
        print(f'Número de soluções encontradas: {len(solutions)}')
        for i, solution in enumerate(solutions):
            print(f'Solution Number {i + 1}:')
            total = 0
            for j in range(num_coins):
                coin_count = solution[j]
                #if coin_count > 0: ## 
                total += coins[j] * coin_count 
                print(f'{coins[j]} \t cent: {coin_count} \t partial: {total}')
                    
            print(f'Total: {total} cents\n')
    else:
        print('None solution found it.')

if __name__ == '__main__':
    main()
