#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( '@@canonical_perl_name@@' ) || print "Bail out!\n";
}
