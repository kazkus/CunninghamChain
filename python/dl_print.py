# $Id$

import pandas as pd
import numpy as np

def get_dl_df():
  return pd.read_csv('data/dl.csv')

def get_tables(df):
  z0 = np.zeros([9,9], dtype=np.int)
  z1 = np.zeros([9,9], dtype=np.int)
  z2 = np.zeros([9,9], dtype=np.int)
  for d,l,c in zip(df['d'], df['l'], df['c']):
    z0[d-1,l-1] = c
    for i in range(d-1,9):
      z1[i,l-1] += c
      for j in range(l):
        z2[i,j] += c
  return (z0,z1,z2)
#
def print_table(z, type=0):
  d_column_len = 3
  print(' ' * (d_column_len-1) + '\\', end='')
  for j in range(9):
    print('|', end='')
    if type == 2:
      print('%7d-' % (j+1), end='')
    else:
      print('%8d' % (j+1), end='')
  print()
  #
  print('-' * d_column_len,end='')
  for j in range(9):
    print('+', end='')
    print('-' * 8, end='')
  print()
  #
  for i in range(9):
    if type == 0:
      print('%3d' % (i+1), end='')
    else:
      print('1-%1d' % (i+1), end='')
    for j  in range(9):
        print('|', end='')
        c = z[i,j]
        s = ' ' * 8
        if c > 0:
          s = '%8d' % c
        print(s, end='')
    print()

def main():
  df = get_dl_df()
  z0,z1,z2 = get_tables(df)
  print_table(z0)
  print("=" * (3+9*9))
  print_table(z1, type=1)
  print("=" * (3+9*9))
  print_table(z2, type=2)

if __name__ == '__main__':
  main()

