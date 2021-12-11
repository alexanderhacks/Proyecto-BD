import pandas as pd
from faker import Faker
from IPython.display import display
from collections import defaultdict

fake = Faker()
select_data = defaultdict(list)

select_data['id'] = ["MEM0000001", "MEM0000002", "MEM0000003", "MEM0000004"]
select_data['nombre'] = ['Contenidos', 'Comunidad', 'Productos', 'Servicios']

df_select_data = pd.DataFrame(select_data)
df_select_data.to_csv('membresia.csv', index=False)
display(df_select_data)
