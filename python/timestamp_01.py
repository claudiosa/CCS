from datetime import datetime

def convert_timestamp_MINUTES( time_object ):
    hours = time_object.hour
    minutes = time_object.minute
    return(hours*60 + minutes)

### Example .....
timestamp = 1545730073
dt_object = datetime.fromtimestamp(timestamp)
print("dt_object =", dt_object)

print("type(dt_object) =", type(dt_object))
## Convert
horas = dt_object.hour
minutos = dt_object.minute

print('Hora: ', horas)
print('Minutos: ', minutos)

print('Em minutos ...:', convert_timestamp_MINUTES(dt_object) )
print('Exemplo 02 minutos ...:', convert_timestamp_MINUTES( datetime.fromtimestamp(1574556698) ))
data_2 = datetime.fromtimestamp(1574556698) 
print('Time_2: ', data_2)

