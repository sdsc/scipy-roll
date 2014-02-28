# http://developer.intel.com/software/products/compilers/flin/
from __future__ import division, absolute_import, print_function

import sys

from numpy.distutils.ccompiler import simple_version_match
from numpy.distutils.fcompiler import FCompiler, dummy_fortran_file

compilers = ['IntelFCompiler', 'IntelVisualFCompiler',
             'IntelItaniumFCompiler', 'IntelItaniumVisualFCompiler',
             'IntelEM64VisualFCompiler', 'IntelEM64TFCompiler']

def intel_version_match(type):
    # Match against the important stuff in the version string
    return simple_version_match(start=r'Intel.*?Fortran.*?(?:%s).*?Version' % (type,))

class BaseIntelFCompiler(FCompiler):
    def update_executables(self):
        f = dummy_fortran_file()
        self.executables['version_cmd'] = ['<F77>', '-FI', '-V', '-c',
                                           f + '.f', '-o', f + '.o']

class IntelFCompiler(BaseIntelFCompiler):

    compiler_type = 'intel'
    compiler_aliases = ('ifort',)
    description = 'Intel Fortran Compiler for 32-bit apps'
    version_match = intel_version_match('32-bit|IA-32')

    possible_executables = ['ifort', 'ifc']

    executables = {
        'version_cmd'  : None,          # set by update_executables
        'compiler_f77' : [None, "-72", "-w90", "-w95"],
        'compiler_f90' : [None],
        'compiler_fix' : [None, "-FI"],
        'linker_so'    : ["<F90>", "-shared"],
        'archiver'     : ["ar", "-cr"],
        'ranlib'       : ["ranlib"]
        }

    pic_flags = ['-fPIC']
    module_dir_switch = '-module ' # Don't remove ending space!
    module_include_switch = '-I'

    def get_flags_free(self):
        return ["-FR"]

    def get_flags(self):
        return ['-fPIC']

    def get_flags_opt(self):
        #return ['-i8 -xhost -openmp -fp-model strict']
        return ['-xhost -openmp -fp-model strict']

    def get_flags_arch(self):
        return []

    def get_flags_linker_so(self):
        opt = FCompiler.get_flags_linker_so(self)
        v = self.get_version()
        if v and v >= '8.0':
            opt.append('-nofor_main')
        if sys.platform == 'darwin':
            # Here, it's -dynamiclib
            try:
                idx = opt.index('-shared')
                opt.remove('-shared')
            except ValueError:
                idx = 0
            opt[idx:idx] = ['-dynamiclib', '-Wl,-undefined,dynamic_lookup', '-Wl,-framework,Python']
        return opt

class IntelItaniumFCompiler(IntelFCompiler):
    compiler_type = 'intele'
    compiler_aliases = ()
    description = 'Intel Fortran Compiler for Itanium apps'

    version_match = intel_version_match('Itanium|IA-64')

    possible_executables = ['ifort', 'efort', 'efc']

    executables = {
        'version_cmd'  : None,
        'compiler_f77' : [None, "-FI", "-w90", "-w95"],
        'compiler_fix' : [None, "-FI"],
        'compiler_f90' : [None],
        'linker_so'    : ['<F90>', "-shared"],
        'archiver'     : ["ar", "-cr"],
        'ranlib'       : ["ranlib"]
        }

class IntelEM64TFCompiler(IntelFCompiler):
    compiler_type = 'intelem'
    compiler_aliases = ()
    description = 'Intel Fortran Compiler for 64-bit apps'

    version_match = intel_version_match('EM64T-based|Intel\\(R\\) 64|64|IA-64|64-bit')

    possible_executables = ['ifort', 'efort', 'efc']

    executables = {
        'version_cmd'  : None,
        'compiler_f77' : [None, "-FI"],
        'compiler_fix' : [None, "-FI"],
        'compiler_f90' : [None],
        'linker_so'    : ['<F90>', "-shared"],
        'archiver'     : ["ar", "-cr"],
        'ranlib'       : ["ranlib"]
        }

    def get_flags(self):
        return ['-fPIC']

    def get_flags_opt(self):
        #return ['-i8 -xhost -openmp -fp-model strict']
        return ['-xhost -openmp -fp-model strict']

    def get_flags_arch(self):
        return['-fPIC', '-openmp']

# Is there no difference in the version string between the above compilers
# and the Visual compilers?

class IntelVisualFCompiler(BaseIntelFCompiler):
    compiler_type = 'intelv'
    description = 'Intel Visual Fortran Compiler for 32-bit apps'
    version_match = intel_version_match('32-bit|IA-32')

    def update_executables(self):
        f = dummy_fortran_file()
        self.executables['version_cmd'] = ['<F77>', '/FI', '/c',
                                           f + '.f', '/o', f + '.o']

    ar_exe = 'lib.exe'
    possible_executables = ['ifort', 'ifl']

    executables = {
        'version_cmd'  : None,
        'compiler_f77' : [None, "-FI", "-w90", "-w95"],
        'compiler_fix' : [None, "-FI", "-4L72", "-w"],
        'compiler_f90' : [None],
        'linker_so'    : ['<F90>', "-shared"],
        'archiver'     : [ar_exe, "/verbose", "/OUT:"],
        'ranlib'       : None
        }

    compile_switch = '/c '
    object_switch = '/Fo'     #No space after /Fo!
    library_switch = '/OUT:'  #No space after /OUT:!
    module_dir_switch = '/module:' #No space after /module:
    module_include_switch = '/I'

    def get_flags(self):
        opt = ['/nologo', '/MD', '/nbs', '/Qlowercase', '/us']
        return opt

    def get_flags_free(self):
        return ["-FR"]

    def get_flags_debug(self):
        return ['/4Yb', '/d2']

    def get_flags_opt(self):
        return ['/O2']

    def get_flags_arch(self):
        return ["/arch:IA-32", "/QaxSSE3"]

class IntelItaniumVisualFCompiler(IntelVisualFCompiler):
    compiler_type = 'intelev'
    description = 'Intel Visual Fortran Compiler for Itanium apps'

    version_match = intel_version_match('Itanium')

    possible_executables = ['efl'] # XXX this is a wild guess
    ar_exe = IntelVisualFCompiler.ar_exe

    executables = {
        'version_cmd'  : None,
        'compiler_f77' : [None, "-FI", "-w90", "-w95"],
        'compiler_fix' : [None, "-FI", "-4L72", "-w"],
        'compiler_f90' : [None],
        'linker_so'    : ['<F90>', "-shared"],
        'archiver'     : [ar_exe, "/verbose", "/OUT:"],
        'ranlib'       : None
        }

class IntelEM64VisualFCompiler(IntelVisualFCompiler):
    compiler_type = 'intelvem'
    description = 'Intel Visual Fortran Compiler for 64-bit apps'

    version_match = simple_version_match(start='Intel\(R\).*?64,')

    def get_flags_arch(self):
        return ["/arch:SSE2"]


if __name__ == '__main__':
    from distutils import log
    log.set_verbosity(2)
    from numpy.distutils.fcompiler import new_fcompiler
    compiler = new_fcompiler(compiler='intel')
    compiler.customize()
    print(compiler.get_version())
