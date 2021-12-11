import pandas as pd
from faker import Faker
from IPython.display import display
from collections import defaultdict
import random

fake = Faker()
select_data = defaultdict(list)

vID = list(pd.read_csv("venta.csv")["id"])
prID = list(pd.read_csv("productos.csv")["id"])
precioID = list(pd.read_csv("productos.csv")["precio_venta"])
tuples = 100

for _ in range(tuples):
    select_data["venta_id"].append(vID[random.randint(0, len(vID)-1)])
    idxPr = random.randint(0, len(vID)-1)
    select_data["producto_id"].append(prID[idxPr])
    c = random.randint(1, 5)
    select_data["cantidad"].append(c)
    select_data["precio"].append(precioID[idxPr]*c)

df_select_data = pd.DataFrame(select_data)
df_select_data.to_csv('ventaProducto.csv', index=False)
df_select_data.drop_duplicates(keep='first', inplace=True)
display(df_select_data)

"""
2da iteracion -> remover tupleas donde (ventaID, producto_id) entre filas sean iguales 
"""
