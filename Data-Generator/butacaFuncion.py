import pandas as pd
from faker import Faker
from IPython.display import display
from collections import defaultdict
import random
import numpy as np
import datetime

fake = Faker()
select_data = defaultdict(list)
precios = [10, 15, 22.5, 30]
tipo = ["niño", "adulto"]


fID = list(pd.read_csv("funcion.csv")["funcion_id"])
vID = list(pd.read_csv("ventaEntrada.csv")["id"])


i = 1
for _ in range(len(vID)):
    for j in range(random.randint(1, 5)):
        select_data["butaca_id"].append("BU" + "0" * (7 - len(str(i + 1))) + str(i + 1))
        select_data["ventaentrada_id"].append(vID[_])
        select_data["funcion_id"].append(fID[random.randint(0, len(fID)-1)])
        select_data["nro_fila"].append(chr(random.randint(65, 90)))
        select_data["nro_columna"].append(random.randint(1, 20))
        select_data["tipo_entrada"].append(random.sample(tipo, 1)[0])
        select_data["precio_entrada"].append(random.sample(precios, 1)[0])
        i += 1

df_select_data = pd.DataFrame(select_data)
df_select_data.to_csv('butacaFuncion.csv', index=False)
df_select_data.drop_duplicates(keep='first', inplace=True)
display(df_select_data)
