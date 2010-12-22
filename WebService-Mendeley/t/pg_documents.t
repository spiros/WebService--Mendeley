use strict;
use warnings;

use Test::More tests => 25;

use_ok(' WebService::Mendeley' );

{
   my $rh_params = { 
      'mode'   => 'public_groups',
      'method' => 'documents',
      'id'     => '486101',
      'consumer_key' => '6eeb092c9ca3b42e5b1e47c29f8a4a2d04d0f37fa',
   };

   my $M = WebService::Mendeley->new( $rh_params );

   isa_ok( $M, 'WebService::Mendeley' );

   my $Mreply = $M->query;

   isa_ok( $Mreply, 'WebService::Mendeley::Reply' );

   my $rh = $Mreply->results;

   ok( $rh, 'API returned results' );

   for my $k qw( total_pages total_results current_page document_ids items_per_page ) {
      ok( exists $rh->{$k} );
   }
   

}

{
   my $rh_params = { 
      'mode'   => 'public_groups',
      'method' => 'documents',
      'id'     => 486101,
      'items'  => '5',
      'consumer_key' => '6eeb092c9ca3b42e5b1e47c29f8a4a2d04d0f37fa',
   };

   my $M = WebService::Mendeley->new( $rh_params );

   isa_ok( $M, 'WebService::Mendeley' );

   my $Mreply = $M->query;

   isa_ok( $Mreply, 'WebService::Mendeley::Reply' );

   my $rh = $Mreply->results;

   ok( $rh, 'API returned results' );


   for my $k qw( total_pages total_results current_page document_ids items_per_page ) {
      ok( exists $rh->{$k} );
   }

}


{
   my $rh_params = { 
      'mode'   => 'public_groups',
      'method' => 'documents',
      'items'  => 5,
      'details' => 1,
      'id'     => 486101,
      'consumer_key' => '6eeb092c9ca3b42e5b1e47c29f8a4a2d04d0f37fa',
   };

   my $M = WebService::Mendeley->new( $rh_params );

   isa_ok( $M, 'WebService::Mendeley' );

   my $Mreply = $M->query;

   isa_ok( $Mreply, 'WebService::Mendeley::Reply' );

   my $rh = $Mreply->results;

   ok( $rh, 'API returned results' );

   for my $k qw( total_pages total_results current_page documents items_per_page ) {
      ok( exists $rh->{$k} );
   }


   
}