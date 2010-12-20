package WebService::Mendeley::Reply;

use warnings;
use strict;

use JSON::XS;

=head1 NAME

WebService::Mendeley::Reply - WebService::Mendeley reply object

=head1 SYNOPSIS

=head1 METHODS

=head2 new

Creates an instance of the request object. Do not use this function directly.

=cut

sub new {
   my $class    = shift;
   my $raw  = shift;
   my $self     = { };
   
   # todo: need to eval this?
   
   $self->{ data } = decode_json( $raw );
      
   return bless $self, $class;
   
}

=head2 results

=cut

sub results {
   my $self = shift;
   
   return $self->{ data };
   
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
