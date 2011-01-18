package WebService::Mendeley;

use warnings;
use strict;

use Carp qw( confess );
use Data::Dumper;
use LWP::UserAgent;

use WebService::Mendeley::Request;
use WebService::Mendeley::Reply;

=head1 NAME

WebService::Mendeley - Perl wrapper around Mendeley API

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

=head1 METHODS

=head2 new

=cut

my $rh_api_configuration = {
   
   ##
   ## Stats methods
   
   'stats' => {
      
      'authors'          => {
         'url'       => 'http://www.mendeley.com/oapi/stats/authors/',
         'optional'  => {
            'discipline_id' => 1,
            'upandcoming'   => 1,          
         },
         'mandatory' => {
            'consumer_key'  => 1,
         },
         'query_method'    => 'get', 
      },
      
      'papers'           => {
         'url'       => 'http://www.mendeley.com/oapi/stats/papers/',
         'optional'  => {
            'discipline'    => 1,
            'upandcoming'   => 1,          
         },
         'mandatory' => {
            'consumer_key'  => 1,
         },
         'query_method'    => 'get',
      },
      
      'publications'     => {
         'url'       => 'http://www.mendeley.com/oapi/stats/publications/',
         'optional'  => {
            'discipline'    => 1,
            'upandcoming'   => 1,          
         },
         'mandatory' => {
            'consumer_key'  => 1,
         },
         'query_method'    => 'get',
      },
      
      'tags'             => {
         'url'       => 'http://www.mendeley.com/oapi/stats/tags/%s/',
         'optional'  => {},
         'mandatory' => {
            'discipline'    => 1,
            'consumer_key'  => 1,
         },
         'query_method'    => 'url',
      },
   
   },
   
   ##
   ## Search methods
   
   'search' => {
      'search'           => {
         'url'       => 'http://www.mendeley.com/oapi/documents/search/%s',
         'optional'  => {
            'page'  => 1,
            'items' => 1,
         },
         'mandatory' => {
            'consumer_key'  => 1,
         },
         'query_method'    => 'url',
      },
      'document_details' => 1,
      'related'          => 1,
      'authored'         => 1,
      'tagged'           => 1,
      'categories'       => {
         'url'       => 'http://www.mendeley.com/oapi/documents/categories',
         'optional'  => {},
         'mandatory' => {
            'consumer_key'  => 1,
         },
         'query_method'    => 'get',
         },
      'subcategories'    => {
         'url'       => 'http://www.mendeley.com/oapi/documents/subcategories/%s/',
         'optional'  => { },
         'mandatory' => {
            'consumer_key'  => 1,
            'category_id'   => 1,            
         },
         'query_method'    => 'url',
      },
   },   
   
   ##
   ## Public group methods
   
   'public_groups' => {
      'overview'         => {
         'url'       => 'http://www.mendeley.com/oapi/documents/groups/',
         'optional'  => {
            'page'  => 1,
            'items' => 1,
            'cat'   => 1,
         },
         'mandatory' => {
            'consumer_key'  => 1,
         },
         'query_method'    => 'get',
      },
      
      'details'          => {
         'url'       => 'http://www.mendeley.com/oapi/documents/groups/%s/',
         'optional'  => {},
         'mandatory' => {
            'id'            => 1,
            'consumer_key'  => 1,
         },
         'query_method'    => 'url',
      },
      
      'documents'        => {
         'url'       => 'http://www.mendeley.com/oapi/documents/groups/%s/docs/',
         'optional'  => {
            'details'  => 1,
            'page'     => 1,
            'items'    => 1,
         },
         'mandatory' => {
            'id'            => 1,
            'consumer_key'  => 1,
         },
         'query_method'    => 'url',
      },
      
      'people'           => {
         'url'       => 'http://www.mendeley.com/oapi/documents/groups/%s/people/',
         'optional'  => {},
         'mandatory' => {
            'id'            => 1,
            'consumer_key'  => 1,
         },
         'query_method'    => 'url',
      }
   
   }   
};


sub new {
   my $class     = shift;
   my $rh_params = shift;
   my $self      = { };
   
   confess "Missing parameter hash"
      unless ( defined $rh_params && $rh_params && ref $rh_params eq 'HASH' );
   
   _validate_params( $rh_params );
         
   $self->{ agent }   = LWP::UserAgent->new( );
   $self->{ request } = WebService::Mendeley::Request->new( $rh_params );
   $self->{ params }  = $rh_params;
   
   return bless $self, $class;
   
}

=head2 _validate_params

=cut

sub _validate_params {
   my $rh_params = shift;
   
   my $mode   = $rh_params->{'mode'};
   my $method = $rh_params->{'method'};
   
   ## Validate mode, method and required method parameters.
   
   confess "Missing or invalid `mode` parameter."
      unless ( defined $mode && $mode && exists $rh_api_configuration->{ $mode } );
   
   confess "Missing or invalid `method` parameter."
      unless ( defined $method && $method && exists $rh_api_configuration->{ $mode }->{ $method } );
   
   my $rh_required_params = 
      $rh_api_configuration->{ $mode }->{ $method }->{ mandatory };
   
   foreach my $rp ( keys %$rh_required_params ) {
      
      confess "Mandatory parameter `$rp` is missing."
         unless ( exists $rh_params->{ $rp } && $rh_params->{ $rp } );
      
   }
   
   ## Add static API configuration to parameter hash.
   
   $rh_params->{'config'} = $rh_api_configuration->{ $mode }->{ $method };
   
   return 1;
   
}

=head2 query

This function returns a xxxxx object which can be
interrogated to obtain the results in some form or shape.

This function returns I<undef> on error.

=cut

sub query {
   my $self = shift;
   
   my $response =
      $self->{ agent }->request( $self->{ request }->request );
   
   if ( $response->is_success ) {
      return
         WebService::Mendeley::Reply->new( $response->decoded_content    );
   }
   else {
       confess $response->status_line;
   }
   
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
