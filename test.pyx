import numpy as np
cimport numpy as np
cimport cython
from cpython cimport bool

foo="hi"

DTYPE = np.float
ctypedef np.float_t DTYPE_t

from w3j._w3j import drc3jm


@cython.boundscheck(False)
@cython.wraparound(False)
def w3j_ms(DTYPE_t l1, DTYPE_t l2, DTYPE_t l3,
        DTYPE_t m1):
    cdef int n 
    n = int(2*l2) + 1
    cdef np.ndarray[DTYPE_t] result = np.empty(n, dtype=float)
    cdef int ier
    drc3jm(l1, l2, l3, m1, -l2, l2, result, ier)
    return result


@cython.boundscheck(False)
@cython.wraparound(False)
def inner_loops(int i, np.ndarray[DTYPE_t, ndim=3] bispectrum):
    cdef int N = bispectrum.shape[0]
    cdef int l1 = i
    cdef np.ndarray[int] m1s = np.arange(-l1, l1+1)
    cdef int l2, l3, m1, m2, m3
    for l2 in xrange(N):
        for l3 in xrange(N):
            for m1 in m1s:
                #
                cdef np.ndarray[ind] w3js = w3j_ms(l1, l2, l3, m1)
                
                
