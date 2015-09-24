from setuptools import setup, Extension
from Cython.Build import cythonize
import numpy

ext = [Extension('test',sources=["test.pyx"], include_dirs=[numpy.get_include()])]

setup(
  name = 'test',
    ext_modules = cythonize(ext)
)
