# $Id$

import os
import sys
import pandas as pd
import numpy as np

sys.path.append('python')
from dl_print import print_table, get_dl_df

def get_table():
  df = pd.read_csv('data/p.csv')
  count_df = df[['d','l','k']].groupby(['d','l']).count().reset_index(drop=False)
  count_df.columns = ['d','l','c']
  #
  df = get_dl_df()
  count_df = pd.concat([count_df,df]).drop_duplicates()
  #
  z = np.zeros([19,14], dtype=np.int)
  for d,l,c in zip(count_df['d'], count_df['l'], count_df['c']):
      z[d-1,l-1] = c
  return z

def get_table1(z0):
  m = z0.shape[0]
  n = z0.shape[1]
  z1 = np.zeros([m,n], dtype=np.int)
  z1[:,:] = z0
  for j in range(n):
    for i in range(m):
      c = z0[i,j]
      if c == 0:
        continue
      for k in range(i+1,m):
        if z1[k,j] == 0 and z0[k-1,j] > 10:
          break
        z1[k,j] += c
  return z1

def get_table2(z1):
  m = z1.shape[0]
  n = z1.shape[1]
  z2 = np.zeros([m,n], dtype=np.int)
  z2[:,:] = z1
  for i in range(m):
    for j in range(n):
      c = z1[i,j]
      if c == 0:
        continue
      for k in range(j-1,-1,-1):
        if z2[i,k] == 0 and i > 0:
          break
        z2[i,k] += c
  return z2

def main():
  z0 = get_table()
  print_table(z0, type=0, d_max=19, l_max=14)
  print('=' * (4+14*9))
  z1 = get_table1(z0)
  print_table(z1, type=1, d_max=19, l_max=14)
  print('=' * (4+14*9))
  z2 = get_table2(z1)
  print_table(z2, type=2, d_max=19, l_max=14)

if __name__ == '__main__':
  main()

