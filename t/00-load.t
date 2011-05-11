#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'WebService::Mendeley' ) || print "Bail out!
";
}

diag( "Testing WebService::Mendeley $WebService::Mendeley::VERSION, Perl $], $^X" );
