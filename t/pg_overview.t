use strict;
use warnings;

use Test::More tests => 18;

use_ok(' WebService::Mendeley' );

{
   my $rh_params = { 
      'mode'   => 'public_groups',
      'method' => 'overview',
      'consumer_key' => '6eeb092c9ca3b42e5b1e47c29f8a4a2d04d0f37fa',
   };

   my $M = WebService::Mendeley->new( $rh_params );

   isa_ok( $M, 'WebService::Mendeley' );

   my $Mreply = $M->query;

   isa_ok( $Mreply, 'WebService::Mendeley::Reply' );

   my $rh = $Mreply->results;

   ok( $rh, 'API returned results' );

   is( 
      scalar @{$rh->{groups}}, 
      20
   );

}

{
   my $rh_params = { 
      'mode'   => 'public_groups',
      'method' => 'overview',
      'items'  => '5',
      'consumer_key' => '6eeb092c9ca3b42e5b1e47c29f8a4a2d04d0f37fa',
   };

   my $M = WebService::Mendeley->new( $rh_params );

   isa_ok( $M, 'WebService::Mendeley' );

   my $Mreply = $M->query;

   isa_ok( $Mreply, 'WebService::Mendeley::Reply' );

   my $rh = $Mreply->results;

   ok( $rh, 'API returned results' );

   is( 
      scalar @{$rh->{groups}}, 
      5
   );

}

{
   my $rh_params = { 
      'mode'   => 'public_groups',
      'method' => 'overview',
      'items'  => 5,
      'cat'    => 23,
      'consumer_key' => '6eeb092c9ca3b42e5b1e47c29f8a4a2d04d0f37fa',
   };

   my $M = WebService::Mendeley->new( $rh_params );

   isa_ok( $M, 'WebService::Mendeley' );

   my $Mreply = $M->query;

   isa_ok( $Mreply, 'WebService::Mendeley::Reply' );

   my $rh = $Mreply->results;

   ok( $rh, 'API returned results' );

   is( 
      scalar @{$rh->{groups}}, 
      5
   );

   foreach my $e ( @{$rh->{groups}} ) {
      is( 
         $e->{disciplines}->{id},
         23
      );
   }
   
}