#!/bin/sh

exec \
    g++-12 \
    -std=gnu++20 \
    -O2 \
    -DONLINE_JUDGE \
    -DATCODER \
    -Wall \
    -Wextra \
    -mtune=native \
    -march=native \
    -fconstexpr-depth=2147483647 \
    -fconstexpr-loop-limit=2147483647 \
    -I/opt/ac-library \
    -I/opt/boost/gcc/include \
    -L/opt/boost/gcc/lib \
    -Igmpxx \
    -Igmp \
    -I/usr/include/eigen3 \
    "$@"
