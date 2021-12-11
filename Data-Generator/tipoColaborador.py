import pandas as pd
from IPython.display import display
from collections import defaultdict

select_data = defaultdict(list)
select_data["id"] = ["TP00001", "TP00002", "TP00003"]
select_data["especialidad"] = ["de Contacto", "de Oficina", "Consejo"]
select_data["rango_permiso"] = [1, 2, 3]
df_select_data = pd.DataFrame(select_data)
df_select_data.to_csv('tipoColaborador.csv', index=False)
df_select_data.drop_duplicates(keep='first', inplace=True)
display(df_select_data)

