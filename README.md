# SDSC "scipy" roll

## Overview

This roll bundles a collection of Python scientific computing modules: cython,ipython,
matplotlib, nose, numpy, pyfits, pytz, scientificpython and scipy.  

For more information about the various packages included in the scipy roll please visit their official web pages:

- <a href="http://cython.org" target="_blank">cython</a> is an optimising static compiler
for both the Python programming language and the extended Cython programming language
- <a href="http://ipython.org" target="_blank">iPython</a> provides a rich
architecture for interactive computing using the Python programming language.
- <a href="http://xmlsoft.org" target="_blank">libxml2</a> Libxml2 is the XML C parser
and toolkit developed for the Gnome project 
- <a href="http://matplotlib.org" target="_blank">matplotlib</a> is a python 2D
plotting library which produces publication quality figures in a variety of
hardcopy formats and interactive environments across platforms.
- <a href="http://nose.readthedocs.org/en/latest/" target="_blank">nose</a> is
nicer testing for python.
- <a href="http://www.numpy.org" target="_blank">numpy</a> is the fundamental
package for scientific computing with Python.
- <a href="http://www.stsci.edu/institute/software_hardware/pyfits"
target="_blank">PyFITS</a> provides an interface to FITS formatted files in the
Python scripting language and PyRAF, the Python-based interface to IRAF.
- <a href="http://pytz.sourceforge.net" target="_blank">pytz</a> brings the
Olson tz database into Python.
- <a href="http://http://dirac.cnrs-orleans.fr/plone/software/scientificpython" target="_blank"></a> is 
- <a href="http://www.scipy.org" target="_blank"></a> is a Python-based
a Python library for common tasks in scientific computing.


## Requirements

To build/install this roll you must have root access to a Rocks development
machine (e.g., a frontend or development appliance).

If your Rocks development machine does *not* have Internet access you must
download the appropriate scipy source file(s) using a machine that does
have Internet access and copy them into the `src/<package>` directories on your
Rocks development machine.


## Dependencies

compiler rolls


## Building

To build the scipy-roll, execute these instructions on a Rocks development
machine (e.g., a frontend or development appliance):

```shell
% make 2>&1 | tee build.log
% grep "RPM build error" build.log
```

If nothing is returned from the grep command then the roll should have been
created as... `scipy-*.iso`. If you built the roll on a Rocks frontend then
proceed to the installation step. If you built the roll on a Rocks development
appliance you need to copy the roll to your Rocks frontend before continuing
with installation.

This roll source supports building with different compilers; by default, it
builds using the gnu compilers.  To build for a different configuration, use
the `ROLLCOMPILER` make variable, e.g.,

```shell
% make ROLLCOMPILER=intel
```

The build process currently supports one or more of the values "gnu", "intel",
and "gnu" for the `ROLLCOMPILER` variable, defaulting to "gnu".  The build
process uses the ROLLCOMPILER value to load an environment module, so you can
also use it to specify a particular compiler version, e.g.,

```shell
% make ROLLCOMPILER=gnu/4.8.1
```

NOTE: the BLAS and ATLAS dynamic libraries need to be installed in order to
build this roll.  The intel compiler comes packaged with these.

The roll also supports specifying building with/for python versions other than
the one included with the o/s.  To use this feature, specify a `ROLLPY` make
variable that includes a space-delimited list of python modulefiles,
e.g.,

```shell
% make ROLLPY=opt-python
```

## Installation

To install, execute these instructions on a Rocks frontend:

```shell
% rocks add roll *.iso
% rocks enable roll scipy
% cd /export/rocks/install
% rocks create distro
% rocks run roll scipy | bash
```

In addition to the software itself, the roll installs scipy environment
module files in:

```shell
/opt/modulefiles/applications/.(compiler)/scipy
```


## Testing

The scipy-roll includes a test script which can be run to verify proper
installation of the scipy-roll documentation, binaries and module files. To
run the test scripts execute the following command(s):

```shell
% /root/rolltests/scipy.t 
```

