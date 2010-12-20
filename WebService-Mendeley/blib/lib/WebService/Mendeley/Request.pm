package WebService::Mendeley::Request;

use warnings;
use strict;

use Data::Dumper;
use URI;
use HTTP::Request;

=head1 NAME

WebService::Mendeley::Request - The great new WebService::Mendeley!

=head1 SYNOPSIS

=head1 METHODS

=head2 new

=cut

sub new {
   my $class     = shift;
   my $rh_params = shift;
   my $self      = { };   
   
   bless $self, $class;
   
   $self->{ request } =
      HTTP::Request->new( 'GET', $self->create_uri( $rh_params ) );

   warn Dumper $rh_params;
   warn Dumper $self;
   
   return $self;
   
}

=head2 create_uri

Creates and encodes the request URI. Do not use this function directly.

=cut

sub create_uri {
   my $self      = shift;
   my $rh_params = shift;
      
   my $uri  = 
      URI->new( $rh_params->{'config'}->{'url'}, 'http' ) ;
   
   my $rh_query_params = $self->create_query( $rh_params );
   
   $uri->query_form( %$rh_query_params  ) ;
    
   return $uri ;
      
}

=head2 create_query

=cut

sub create_query {
   my $self      = shift;
   my $rh_params = shift;
   
   my $rh_query = { };
   
   foreach my $k ( keys %{ $rh_params->{'config'}{'optional'} } ) {
      next unless exists $rh_params->{ $k };
      $rh_query->{ $k } = $rh_params->{$k};
   }

   foreach my $k ( keys %{ $rh_params->{'config'}{'mandatory'} } ) {
      $rh_query->{ $k } = $rh_params->{$k};
   }
   
   return $rh_query;
      
}

=head2 uri

=cut

sub request {
   my $self = shift;
   return $self->{'request'};
}

=head1 AUTHOR

Spiros Denaxas, C<< <s.denaxas at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-webservice-mendeley at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=WebService-Mendeley>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc WebService::Mendeley


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=WebService-Mendeley>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/WebService-Mendeley>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/WebService-Mendeley>

=item * Search CPAN

L<http://search.cpan.org/dist/WebService-Mendeley/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2010 Spiros Denaxas.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of WebService::Mendeley
