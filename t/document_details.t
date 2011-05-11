use strict;
use warnings;

use Test::More tests => 4;
use Data::Dumper;

use_ok(' WebService::Mendeley' );

{
   my $rh_params = { 
      'mode'         => 'search',
      'method'       => 'details',
      'id'           => '2c8d9cb0-6d00-11df-a2b2-0026b95e3eb7',
#      'type'         => 'isbn' ,
      'consumer_key' => '6eeb092c9ca3b42e5b1e47c29f8a4a2d04d0f37fa',
   };

   my $M = WebService::Mendeley->new( $rh_params );

   isa_ok( $M, 'WebService::Mendeley' );

   my $Mreply = $M->query;

   isa_ok( $Mreply, 'WebService::Mendeley::Reply' );

   my $ra = $Mreply->results;

   ok( $ra, 'API returned results' );
          
}
