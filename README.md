# SDSC "scipy" roll

## Overview

This roll bundles a collection of Python scientific computing modules: astropy,billiard,ipython, jupyter,libxml2,llvmlite,matplotlib,numba,pandas,requests,scientificpython,scipy and sympy.  

For more information about the various packages included in the scipy roll please visit their official web pages:

- <a href="http://www.astropy.org" target="_blank">astropy</a> contains functionality aimed at professional astronomers and astrophysicists, but may be useful to anyone developing astronomy software
- <a href="https://pypi.python.org/pypi/billiard" target="_blank">billiard</a> is a fork of the Python 2.7 multiprocessing package
- <a href="http://ipython.org" target="_blank">iPython</a> provides a rich
architecture for interactive computing using the Python programming language.
- <a href="https://jupyter.org/" target="_blank">jupyter</a>  is an open-source web application that allows you to create and share documents that contain live code, equations, visualizations and narrative text. 
- <a href="http://xmlsoft.org" target="_blank">libxml2</a> Libxml2 is the XML C parser and toolkit developed for the Gnome project 
- <a href="pypi.python.org/pypi/llvmlite"
target="_blank">llvmlite</a> is a lightweight LLVM python binding for writing JIT compilers
- <a href="http://matplotlib.org" target="_blank">matplotlib</a> is a python 2D
plotting library which produces publication quality figures in a variety of
hardcopy formats and interactive environments across platforms.
- <a href="http://numba.pydata.org"
target="_blank">numba</a> generates optimized machine code from pure Python code
- <a href="http://pandas.pydata.org"
target="_blank">pandas</a> is an open source, BSD-licensed library providing high-performance, easy-to-use data structures and data analysis tools for the Python programming language.
- <a href="http://www.stsci.edu/institute/software_hardware/pyfits"
target="_blank">PyFITS</a> provides an interface to FITS formatted files in the
Python scripting language and PyRAF, the Python-based interface to IRAF.
- <a href="http://docs.python-requests.org"
target="_blank">requests</a> is an Apache2 Licensed HTTP library, written in Python, for human beings.
- <a href="http://http://dirac.cnrs-orleans.fr/plone/software/scientificpython" target="_blank">scientificpython</a> is  a
package for scientific computing with Python.
- <a href="http://www.scipy.org" target="_blank">scipy</a> is a Python-based
a Python library for common tasks in scientific computing.
- <a href="http://sympy.org" target="_blank">sympy</a>  s a Python library for symbolic mathematics

Note that the latest versons of the following packages are no longer supported by python 2.x:

   matplotlib astropy IPython scipy

and that ScientificPython will not build under python 3.x


## Requirements

To build/install this roll you must have root access to a Rocks development
machine (e.g., a frontend or development appliance).

If your Rocks development machine does *not* have Internet access you must
download the appropriate scipy source file(s) using a machine that does
have Internet access and copy them into the `src/<package>` directories on your
Rocks development machine.


## Dependencies

The sdsc-roll must be installed on the build machine, since the build process
depends on make include files provided by that roll.

The roll sources assume that modulefiles provided by SDSC compiler and python
rolls are available, but it will build without them as long as the environment
variables they provide are otherwise defined.

The build process requires the MKL and NETCDF libraries and assumes that the
modulefiles provided by the SDSC intel and netcdf rolls are available.  It will
build without the modulefiles as long as the environment variables they provide
are otherwise defined.

The numba build attempts to load a cuda modulefile; if successful, this package
will be built with cuda support.

Building the llvmlite package requires that LLVM be installed on the build
machine.  The build process assumes that the LLVM modulefile provided by the
SDSC llvm-roll is available.  It will build without the modulefile as long as
the environment variables it provides are otherwise defined.

jupyter requires the following additional rpms available from (centos 6) http://mirror.cs.pitt.edu/epel/6/x86_64/ or (centos 7) http://mirror.cs.pitt.edu/epel/7/x86_64/Packages/z/ : libsodium, openpgm and zeromq-devel


## Building

To build the scipy-roll, execute this on a Rocks development
machine (e.g., a frontend or development appliance):

```shell
% make 2>&1 | tee build.log
```

A successful build will create the file `scipy-*.disk1.iso`.  If you built the
roll on a Rocks frontend, proceed to the installation step. If you built the
roll on a Rocks development appliance, you need to copy the roll to your Rocks
frontend before continuing with installation.

This roll source supports building with different compilers and different
python installations.  The `ROLLCOMPILER` ,`ROLLPY`, and ROLLPYVERSION make
variables can be used to specify the compiler,python modulefiles and python versionsfor building the software, e.g.,

```shell
% make ROLLCOMPILER=intel ROLLPY=opt-python ROLLPYTHONVERSION=3.5 2>&1 | tee build.log
```

The build process recognizes "gnu", "intel" or "pgi" as the value for the
`ROLLCOMPILER` variable; any python modulefile name may be used as the value of
the `ROLLPY` variable.  The default values are "gnu" and "python".
The values for ROLLPYTHONVERSION are dependent on those available in the python roll.

The python installation used to build scipy must included the setuptools module.


## Installation

To install, execute these instructions on a Rocks frontend:

```shell
% rocks add roll *.iso
% rocks enable roll scipy
% cd /export/rocks/install
% rocks create distro
```

Subsequent installs of compute and login nodes will then include the contents
of the scipy-roll.  To avoid cluttering the cluster frontend with unused
software, the scipy-roll is configured to install only on compute and
login nodes. To force installation on your frontend, run this command after
adding the scipy-roll to your distro

```shell
% rocks run roll scipy host=NAME | bash
```

where NAME is the DNS name of a compute or login node in your cluster.

In addition to the software itself, the roll installs scipy environment
module files in:

```shell
/opt/modulefiles/applications/scipy
```


## Testing

The scipy-roll includes a test script which can be run to verify proper
installation of the roll documentation, binaries and module files. To
run the test scripts execute the following command(s):

```shell
% /root/rolltests/scipy.t 
```

