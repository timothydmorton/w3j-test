#!/usr/bin/env python

import numpy as np
import numba
from numba import jit

"""
from cffi import FFI
ffi = FFI()

lib = ffi.dlopen('./test.so')
ffi.cdef('void w3j_ms(double, double, double, double);')
_w3j_ms = lib.___pyx_pw_4test_1w3j_ms
drc3jm = lib.drc3jm_
"""
from test import w3j_ms as _w3j_ms

@jit#(nopython=True)
def w3j_ms(l1, l2, l3, m1):
    """
    for l1, l2, l3, m1

    returns w3js from m2 from -l2 to +l2
    """
    return  _w3j_ms(l1, l2, l3, m1)

print(w3j_ms(2,2,2,0))
