#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Project::Kickstart' ) || print "Bail out!
";
}

diag( "Testing Project::Kickstart $Project::Kickstart::VERSION, Perl $], $^X" );
