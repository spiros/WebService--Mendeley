package WebService::Mendeley::Request;

use warnings;
use strict;

use Data::Dumper;
use URI;
use HTTP::Request;

=head1 NAME

WebService::Mendeley::Request - WebService::Mendeley request object

=head1 SYNOPSIS

=head1 METHODS

=head2 new

Creates an instance of the request object. Do not use this function directly.

=cut

sub new {
   my $class     = shift;
   my $rh_params = shift;
   my $self      = { };   
   
   bless $self, $class;
   
   $self->{ request } =
      HTTP::Request->new( 'GET', $self->create_uri( $rh_params ) );
   
   return $self;
   
}

=head2 create_uri

Creates and encodes the request URI. Do not use this function directly.

=cut

sub create_uri {
   my $self      = shift;
   my $rh_params = shift;
   
   my $query_method = 
      $rh_params->{'config'}{'query_method'};
   my $url           = 
      $rh_params->{'config'}->{'url'};
   
   if ( $query_method eq 'get' ) {

      my $uri  = 
         URI->new( $url , 'http' ) ;
            
      my $rh_query_params = $self->create_query( $rh_params );

      $uri->query_form( %$rh_query_params  ) ;
      
      return $uri;
      
   } else {
      
      my $formatted_url = 
         $self->format_url( $url, $rh_params );
      
      my $uri  = 
         URI->new( $formatted_url , 'http' ) ;
            
      my $rh_query_params = $self->create_query( $rh_params );

      $uri->query_form( %$rh_query_params  ) ;
      
      return $uri;
      
   }
   
}

=head2 format_url

Formats a URL with the required parameters. Do not use this function directly.

=cut

sub format_url {
   my $self      = shift;
   my $url       = shift;
   my $rh_params = shift;
   
   if ( $rh_params->{method}  eq 'tags' && $rh_params->{mode} eq 'stats' ){
      $url = sprintf( $url, $rh_params->{'discipline'} );
   } 
   
   elsif ( $rh_params->{method}  eq 'details' && $rh_params->{mode} eq 'public_groups' ){
      $url = sprintf( $url, $rh_params->{'id'} );
   }

   elsif ( $rh_params->{method}  eq 'people' && $rh_params->{mode} eq 'public_groups' ){
      $url = sprintf( $url, $rh_params->{'id'} );
   }

   elsif ( $rh_params->{method}  eq 'documents' && $rh_params->{mode} eq 'public_groups' ){
      $url = sprintf( $url, $rh_params->{'id'} );
   }

   return $url;
   
}

=head2 create_query

Creates and formats the query parameters. Do not use this function directly.

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

=head2 request

Returns the request object. Do not use this function directly.

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

=head1 LICENSE AND COPYRIGHT

Copyright 2010 Spiros Denaxas.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of WebService::Mendeley
