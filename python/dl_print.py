# $Id$

import os
import sys
import pandas as pd
import numpy as np

def get_dl_df(kind=1):
  return pd.read_csv("data/dl"+str(kind)+".csv")

def get_tables(df, kind=1):
  m = df['d'].max()
  n = df['l'].max()
  z0 = np.zeros([m,n], dtype=np.int)
  z1 = np.zeros([m,n], dtype=np.int)
  z2 = np.zeros([m,n], dtype=np.int)
  for d,l,c in zip(df['d'], df['l'], df['c']):
    c = int(c)
    if c >= 10**18:
      continue
    z0[d-1,l-1] = c
    if kind == 0:
      continue
    for i in range(d-1,11):
      z1[i,l-1] += c
      for j in range(l):
        z2[i,j] += c
  return (z0,z1,z2)
#
def print_table(z, type=0, d_max=11, l_max=10, md=True):
  d_column_len = 1 if d_max <= 9 else 2
  c_len = 10
  if type > 0:
    d_column_len += 2
  if md:
    print('|d\l', end='')
  else:
    print(' ' * (d_column_len-1) + '\\', end='')
  for j in range(l_max):
    if md:
      print('|', end='')
    else:
      print('|', end='')
    if type == 2:
      if md:
        print('%d-' % (j+1), end='')
      else:
        f = '%%%dd-' % (c_len-1)
        print(f % (j+1), end='')
    else:
      if md:
        print('%d' % (j+1), end='')
      else:
        f = '%%%dd' % c_len
        print(f % (j+1), end='')
  if md:
    print('|', end='')
  print()
  #
  if md:
    print('|---:', end='')
  else:
    print('-' * d_column_len,end='')
  for j in range(l_max):
    if md:
      print('|---:', end='')
    else:
      print('+', end='')
      print('-' * c_len, end='')
  if md:
    print('|', end='')
  print()
  #
  for i in range(d_max):
    if type == 0:
      if md:
        f = '%d'
      else:
        f = '%%%dd' % d_column_len
    else:
      if md:
        f = '1&#x2011;%d'
      else:
        f = '1-%%%dd' % (d_column_len - 2)
    print(f % (i+1), end='')
    for j  in range(l_max):
        print('|', end='')
        c = z[i,j]
        if md:
          if c > 0:
            print('`%d`' % c, end='')
        else:
          s = ' ' * c_len
          if c > 0:
            f = '%%%dd' % c_len
            s = f % c
          print(s, end='')
    if md:
      print('|', end='')
    print()

def main():
  kind = 1
  if len(sys.argv) > 1:
    kind = int(sys.argv[1])
  df = get_dl_df(kind=kind)
  z0,z1,z2 = get_tables(df, kind=kind)
  d_max = z0.shape[0]
  l_max = z0.shape[1]
  print_table(z0, d_max=d_max, l_max=l_max)
  if kind == 0:
    return
  print("=" * (4+10*11))
  print_table(z1, type=1, d_max=11, l_max=10)
  print("=" * (4+10*11))
  print_table(z2, type=2, d_max=11, l_max=10)

if __name__ == '__main__':
  main()

