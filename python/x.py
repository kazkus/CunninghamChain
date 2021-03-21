# $Id$
import os
import sys
import pandas as pd

df = pd.read_csv('data/x/x.csv')
# print(len(df))
df = df.drop_duplicates()
df = df.sort_values('p', ascending=True)
df = df.reset_index(drop=True)
df['d'] = df['p'].apply(str).apply(len)
df['k'] = 1
df = df[['p','d','k','l']]
df.to_csv('data/p.csv', index=False)
# print(df.head(10))
# print(df.tail(10))
