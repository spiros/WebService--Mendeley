use strict;
use warnings;

use Data::Dumper;
use Test::More tests => 11;

use_ok(' WebService::Mendeley' );

{
   my $rh_params = { 
      'mode'   => 'public_groups',
      'method' => 'details',
      'id'     => 492511, # TODO silly test, will break if group does not exist
      'consumer_key' => '6eeb092c9ca3b42e5b1e47c29f8a4a2d04d0f37fa',
   };

   my $M = WebService::Mendeley->new( $rh_params );

   isa_ok( $M, 'WebService::Mendeley' );

   my $Mreply = $M->query;

   isa_ok( $Mreply, 'WebService::Mendeley::Reply' );

   my $rh = $Mreply->results;

   ok( $rh, 'API returned results' );

   for my $k qw(total_documents owner name public_url people disciplines id) {
      ok( exists $rh->{$k} );
   }

}

