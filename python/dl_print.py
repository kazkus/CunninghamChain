# $Id$

import pandas as pd
import numpy as np

def get_dl_df():
  return pd.read_csv('data/dl.csv')

def get_tables(df):
  z0 = np.zeros([10,9], dtype=np.int)
  z1 = np.zeros([10,9], dtype=np.int)
  z2 = np.zeros([10,9], dtype=np.int)
  for d,l,c in zip(df['d'], df['l'], df['c']):
    z0[d-1,l-1] = c
    for i in range(d-1,10):
      z1[i,l-1] += c
      for j in range(l):
        z2[i,j] += c
  return (z0,z1,z2)
#
def print_table(z, type=0, d_max=9, l_max=9):
  d_column_len = 1 if d_max <= 9 else 2
  c_len = 9
  if type > 0:
    d_column_len += 2
  print(' ' * (d_column_len-1) + '\\', end='')
  for j in range(l_max):
    print('|', end='')
    if type == 2:
      f = '%%%dd-' % (c_len-1)
      print(f % (j+1), end='')
    else:
      f = '%%%dd' % c_len
      print(f % (j+1), end='')
  print()
  #
  print('-' * d_column_len,end='')
  for j in range(l_max):
    print('+', end='')
    print('-' * c_len, end='')
  print()
  #
  for i in range(d_max):
    if type == 0:
      f = '%%%dd' % d_column_len
    else:
      f = '1-%%%dd' % (d_column_len - 2)
    print(f % (i+1), end='')
    for j  in range(l_max):
        print('|', end='')
        c = z[i,j]
        s = ' ' * c_len
        if c > 0:
          f = '%%%dd' % c_len
          s = f % c
        print(s, end='')
    print()

def main():
  df = get_dl_df()
  z0,z1,z2 = get_tables(df)
  print_table(z0, d_max=10)
  print("=" * (4+9*10))
  print_table(z1, type=1, d_max=10)
  print("=" * (4+9*10))
  print_table(z2, type=2, d_max=10)

if __name__ == '__main__':
  main()

