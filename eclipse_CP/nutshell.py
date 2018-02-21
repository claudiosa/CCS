def solucionar(CSP):
    continuar = True
    
    while continuar and not satisfeito(CSP):
        pre_processar(CSP)
        propagar_restricoes(CSP)
        
        if not satisfeito(CSP):
            if atomico(CSP):
                continuar = False
            else:
                for subCSP in dividir(CSP):
                    solucionar(subCSP)
