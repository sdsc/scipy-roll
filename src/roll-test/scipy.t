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
  'IPython', 'libxml2', 'matplotlib', 'nose', 'numpy', 'pyfits', 'pytz',
  'scipy','Scientific', 'sympy'
);

my $TESTFILE = 'tmpscipy';

open(OUT, ">$TESTFILE.sh");
print OUT <<END;
#!/bin/bash
if test -f /etc/profile.d/modules.sh; then
  . /etc/profile.d/modules.sh
  module load intel scipy
fi
PYPATH <<ENDPY
import \$1
help(\$1)
print "\$1 name %s" % \$1.__name__
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

  skip 'scipy not installed', int(@MODULES) + 3 if ! $isInstalled;
  foreach my $module(@MODULES) {
    $output = `bash $TESTFILE.sh $module 2>&1`;
    like($output, qr/$module name/, "$module module load works");
  }

  skip 'modules not installed', 3 if ! -f '/etc/profile.d/modules.sh';
  `/bin/ls /opt/modulefiles/applications/scipy/[0-9]* 2>&1`;
  ok($? == 0, 'scipy module installed');
  `/bin/ls /opt/modulefiles/applications/scipy/.version.[0-9]* 2>&1`;
  ok($? == 0, 'scipy version module installed');
  ok(-l '/opt/modulefiles/applications/scipy/.version',
     'scipy version module link created');

}

# scipy-doc.xml
SKIP: {
  skip 'not server', 1 if $appliance ne 'Frontend';
  ok(-d '/var/www/html/roll-documentation/scipy', 'doc installed');
}

`rm -fr $TESTFILE*`;
