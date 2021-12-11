import pandas as pd
from faker import Faker
from IPython.display import display
from collections import defaultdict
import random
from datetime import datetime

fake = Faker()
select_data = defaultdict(list)

pCSV = pd.read_csv("peliculas.csv")
pId = list(pCSV["id"])
sCSV = pd.read_csv("sala.csv")
sID = list(sCSV["id"])

tuples = 100
for i in range(tuples):
    select_data["funcion_id"].append("FUN" + "0" * (6 - len(str(i + 1))) + str(i + 1))
    select_data["sala_id"].append(sID[random.randint(0, len(sID)-1)])

    idPel = pId[random.randint(0, len(pId) - 1)]
    select_data["pelicula_id"].append(idPel)

    fEstreno = datetime.strptime(list(pCSV.loc[(pCSV.id == idPel)]["fecha_estreno"])[0], '%Y-%m-%d').date()
    fFuncion = fake.date_between(start_date=fEstreno, end_date='+30d')
    select_data["fecha"].append(fFuncion)

    select_data["hora"].append(fake.time())


df_select_data = pd.DataFrame(select_data)
df_select_data.to_csv('funcion.csv', index=False)
df_select_data.drop_duplicates(keep='first', inplace=True)
display(df_select_data)

"""
2da FASE -> MATAR SALAS QUE INCUMPLAN RESTRICCION

for id_ in list(pCSV["id"]):
    fEstreno = list(pCSV.loc[(pCSV.id == id_)]["fecha_estreno"])[0]
    fEstreno = datetime.strptime(fEstreno, '%Y-%m-%d').date()
    fFuncion = fake.date_between(start_date=fEstreno, end_date='+30d')
    print(id_, " -> ", fEstreno, " ", fFuncion)
"""
