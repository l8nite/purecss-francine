#!/bin/bash

rm -rf archive

number=0 git rev-list master | while read rev; do
  fmt_num=$(printf -- '%03d' $number)
  mkdir -p archive/$fmt_num
  git archive $rev | (cd archive/$fmt_num; tar x)
  (( ++number ))
  sed -e '5i<meta http-equiv="refresh" content="2;url=../'$(printf -- '%03d' $number)'/index.html"/>' -i archive/$fmt_num/index.html
done
