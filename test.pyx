import numpy as np
cimport numpy as np
cimport cython
from cpython cimport bool

foo="hi"

DTYPE = np.float
ctypedef np.float_t DTYPE_t

from w3j import drc3jm


@cython.boundscheck(False)
@cython.wraparound(False)
def w3j_ms(DTYPE_t l1, DTYPE_t l2, DTYPE_t l3,
        DTYPE_t m1):
    """
    For given l1, l2, l3, m1, this returns an array of wigner-3js 
    from m2 = -l2 to m2 = +l2, with m3 = -m2-m1


    For example, w3j_ms(2,2,2,0) will return:
    
        [(2,2,2,0,-2,2), (2,2,2,0,-1,1), (2,2,2,0,0,0), (2,2,2,0,1,-1), (2,2,2,0,2,-2)]

    """
    cdef int n 
    n = int(2*l2) + 1
    cdef np.ndarray[DTYPE_t] result = np.empty(n, dtype=float)
    cdef int ier
    drc3jm(l1, l2, l3, m1, -l2, l2, result, ier)
    return result


@cython.boundscheck(False)
@cython.wraparound(False)
def inner_loops(int i, np.ndarray[DTYPE_t, ndim=3] bispectrum,
                np.ndarray[DTYPE_t, ndim=2] Tlm,
                np.ndarray[DTYPE_t, ndim=2] Elm,
                np.ndarray[DTYPE_t, ndim=2] Blm,):
    cdef int N = bispectrum.shape[0]
    cdef int l1 = i
    cdef np.ndarray[int] m1s = np.arange(-l1, l1+1)
    cdef int l2, l3, m1, m2, m3
    cdef int im1, im2, im3, iwig
    cdef np.ndarray[DTYPE_t] w3js  #does not defining the size here hurt?
    cdef DTYPE_t wig_factor
    for l2 in xrange(N):
        for l3 in xrange(N):
            #Check here if the l-conditions are satisfied or not?
            
            for m1 in m1s:
                # This gives all the w3js you will need...
                w3js = w3j_ms(l1, l2, l3, m1)
                for m2 in xrange(-l2,l2+1):
                    m3 = -m2-m1

                    # Find index for the right wig3j.  m2=0 is in the middle
                    iwig = (2*l1 + 1)//2 + m2
                    wig_factor = w3js[iwig]

                    # Fix negative indices to mean the right thing for alms
                    if m1 >= 0:
                        im1 = m1
                    else:
                        #because m1 is negative here, this will count from end
                        im1 = (2*l1 + 1) + m1  
                    if m2 >= 0:
                        im2 = m2
                    else:
                        im2 = (2*l1 + 1) + m2
                    if m3 >= 0:
                        im3 = m3
                    else:
                        im3 = (2*l1 + 1) + m3

                    bispectrum[l1, l2, l3] += wig_factor * Tlm[l1,im1] * Elm[l2,im2] * Blm[l3,im3]
                
