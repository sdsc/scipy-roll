#!/usr/bin/perl -w
# scipy roll installation test.  Usage:
# scipy.t [nodetype]
#   where nodetype is one of "Compute", "Dbnode", "Frontend" or "Login"
#   if not specified, the test assumes either Compute or Frontend

use Test::More qw(no_plan);

my $appliance = $#ARGV >= 0 ? $ARGV[0] :
                -d '/export/rocks/install' ? 'Frontend' : 'Compute';
my $installedOnAppliancesPattern = '.';
my $isInstalled = -d '/opt/scipy';
my $output;

my @MODULES = (
  'IPython', 'libxml2', 'llvmlite','matplotlib', 'numba','pyfits', 'requests','scipy',
  'Scientific', 'sympy'
);
my @PYTHONS = split(/\s+/, "ROLLPY");

my $TESTFILE = 'tmpscipy';

open(OUT, ">$TESTFILE.sh");
print OUT <<END;
#!/bin/bash
module load \$1
export version=`python -c "import sys; print sys.version[:3]"`
module load scipy/\${version}
python <<ENDPY
import \$2
help(\$2)
print "\$2 name %s" % \$2.__name__
ENDPY
END
close(OUT);

# scipy-common.xml
if($appliance =~ /$installedOnAppliancesPattern/) {
  ok($isInstalled, 'scipy installed');
} else {
  ok(! $isInstalled, 'scipy not installed');
}
SKIP: {

  skip 'scipy not installed', int(@PYTHONS) * int(@MODULES) + 3
    if ! $isInstalled;
  foreach my $python(@PYTHONS) {
    foreach my $module(@MODULES) {
      $output = `bash $TESTFILE.sh $python $module 2>&1`;
      like($output, qr/$module name/, "$module/$python module load works");
    }
  }

  `/bin/ls /opt/modulefiles/applications/scipy/[0-9]* 2>&1`;
  ok($? == 0, 'scipy module installed');
  `/bin/ls /opt/modulefiles/applications/scipy/.version.[0-9]* 2>&1`;
  ok($? == 0, 'scipy version module installed');
  ok(-l '/opt/modulefiles/applications/scipy/.version',
     'scipy version module link created');

}

`rm -fr $TESTFILE*`;
