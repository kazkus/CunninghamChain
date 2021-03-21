#!/bin/bash

cat data/z/*.out | grep '^CC' | sed -e 's/CC9:/CC9 /' -e 's/CC10:/CC10 /' -e 's/CC11:/CC11 /' -e 's/CC12:/CC12 /' | sort -t ' ' -k2n -u > data/x/x.out

