use strict;
use warnings;

use Test::More tests => 3;
use Data::Dumper;

use_ok(' WebService::Mendeley' );

my $rh_params = { 
   'mode'         => 'stats',
   'method'       => 'papers',
   'consumer_key' => '6eeb092c9ca3b42e5b1e47c29f8a4a2d04d0f37fa',
};

my $M = WebService::Mendeley->new( $rh_params );

isa_ok( $M, 'WebService::Mendeley' );

ok( $M->query, 'query() returns true' );  