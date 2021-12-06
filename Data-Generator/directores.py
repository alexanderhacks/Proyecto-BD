
import pandas as pd
from faker import Faker
from IPython.display import display
from collections import defaultdict

fake = Faker()
select_data = defaultdict(list)

director_list = open("directores.txt", "r", encoding='utf8').readlines()
n = 100
tuples = min(n, len(director_list))

for i in range(tuples):
    select_data['id'].append("DIR" + "0" * (6 - len(str(i + 1))) + str(i + 1))
    select_data['nombre'].append(director_list[i][:-1])


df_select_data = pd.DataFrame(select_data)
df_select_data.to_csv('directores.csv', index = False)
display(df_select_data)
