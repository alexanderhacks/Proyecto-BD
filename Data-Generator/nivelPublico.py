import pandas as pd
from faker import Faker
from IPython.display import display
from collections import defaultdict

fake = Faker()
select_data = defaultdict(list)

select_data['id'] = ["RE00000001", "RE00000002", "RE00000003", "RE00000004"]
select_data['rango_edad'] = ['A', 'B', 'C', 'D']

df_select_data = pd.DataFrame(select_data)
df_select_data.to_csv('nivelPublico.csv', index = False)
display(df_select_data)