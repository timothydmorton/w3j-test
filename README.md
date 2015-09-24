# w3j-test


Build with `python setup.py build_ext --inplace` to give you `test.so`.

Importing `test` will then give you access to the `w3j_ms` function:

    In [1]: import test
    
    In [2]: test.w3j_ms?
    Docstring:
    For given l1, l2, l3, m1, this returns an array of wigner-3js 
    from m2 = -l2 to m2 = +l2, with m3 = -m2-m1
    
    
    For example, w3j_ms(2,2,2,0) will return:
    
        [(2,2,2,0,-2,2), (2,2,2,0,-1,1), (2,2,2,0,0,0), (2,2,2,0,1,-1), (2,2,2,0,2,-2)]
    Type:      builtin_function_or_method
