

## all  except ...
k = [x for x in range(90) if ((x != 5) and x < 19)]
for i in k:
    print(f'-> %i' %i)