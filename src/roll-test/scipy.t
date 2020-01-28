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
  'astropy','billiard','IPython', 'libxml2', 'llvmlite', 'matplotlib', 'numba',
  'pandas','requests', 'scipy', 'sympy'
);

my $TESTFILE = 'tmpscipy';
my @pyversions = split(/\s+/,'PYV');

open(OUT, ">$TESTFILE.sh");
print OUT <<END;
#!/bin/bash
module load ROLLPY
version=\$2
module load scipy/\${version}
python\${version} <<ENDPY
import \$1
help(\$1)
print("\$1 name is %s" % \$1.__name__)
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

  skip 'scipy not installed', int(@MODULES) + 3
    if ! $isInstalled;
  foreach my $pyversion(@pyversions) {
    foreach my $module(@MODULES) {
     SKIP: {
      skip "no python$pyversion $module module available", 1
         if ( $module =~ /astropy|IPython|pandas|numba/  && $pyversion < 3 );
      $output = `bash $TESTFILE.sh $module $pyversion 2>&1`;
      like($output, qr/$module name is $module/, "$module module for python $pyversion load works");
     }
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
