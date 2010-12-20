
use strict;
use warnings;

use Test::More 'no_plan';
use Data::Dumper;

use_ok(' WebService::Mendeley' );

my $M = WebService::Mendeley->new( );

isa_ok( $M, 'WebService::Mendeley' );