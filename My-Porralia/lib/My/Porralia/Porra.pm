package My::Porralia::Porra;

use warnings;
use strict;
use Carp;

use Net::Twitter;
use YAML qw(LoadFile DumpFile);
use CGI qw(:standard);

use My::Porralia;

use version; our $VERSION = qv('0.0.3');

# Other recommended modules (uncomment to use):
#  use IO::Prompt;
#  use Perl6::Export;
#  use Perl6::Slurp;
#  use Perl6::Say;


# Module implementation here
sub new {
  my $class = shift;
  my $new_poll_file = shift || carp "Falta fichero configuración\n";
  my $new_poll = LoadFile( $new_poll_file )  || carp "No puedo abrir $new_poll_file\n";
  my $porralia = shift || My::Porralia->new();
  bless $new_poll, $class;
  $new_poll->{'_porralia'} = $porralia;
  $new_poll->{'_conf_file'} = $new_poll_file;
  return $new_poll;
}

sub update_conf {
  my $self = shift;
  my $conf = {};
  for my $k ( qw( id nombre opciones pregunta ) ) {
    $conf->{$k} = $self->{$k};
  }
  DumpFile( $self->{'_conf_file'}, $conf );
}

sub post_poll {
  my $self = shift;
  my $porralia = $self->{'_porralia'};
  my $new_status = "Nueva porra: ".$self->{'pregunta'}."?";
  my $result = $porralia->update_status($new_status);
  
  if ( $result ) {
    my ($poll_code) = ($self->{'_conf_file'} =~ /([^\.]+).yaml/ );
    $porralia->{'current_poll'} = $poll_code;
    $porralia->update_conf();
    
    $self->{'id'} = $result->{'id'};
    $self->update_conf();
    return $result;
  } else {
    return -1 ;
  }
}

sub crea_post {
    my $self = shift;
    
    my $post = { titulo => "&iquest;".$self->{'pregunta'}."?"};
    my $contenido = a( { -href => "http://twitter.com/"
			     .$self->{'_porralia'}->{'username'}."/"
			     .$self->{'id'} }, 
		       "Pregunta: ".$post->{'titulo'} );
    #Abrir fichero
    my %resultados = LoadFile($self->{'nombre'}."_results.yaml");
    my $chart = 'http://chart.apis.google.com/chart?cht=p3&chs=360x200&chd=t:';
    my @leyenda;
    my @porcentajes;
    my $total;
    map( $total += $resultados{$_}, keys %resultados );
    for my $k (keys %resultados ) {
	my $porcentaje = $resultados{$k}/$total;
	push( @porcentajes, $porcentaje );
	push( @leyenda, "$k: $porcentaje" );
    }
    autoEscape(0);
    my $img = img( { -src => $chart.join(",", @porcentajes)."&chl=".join("|", keys %resultados),
		     -alt => join(" - ", @leyenda ) } );
    $contenido .= p( $img );
    $post->{'contenido'} = $contenido;
    return $post;
		 
}

1; # Magic true value required at end of module
__END__

=head1 NAME

My::Porralia::Porra - Módulos para manejar Porralia (http://22memes.es/porralia). Nueva porra


=head1 VERSION

This document describes My::Porralia version 0.0.1


=head1 SYNOPSIS

    use My::Porralia;

=for author to fill in:
    Brief code example(s) here showing commonest usage(s).
    This section will be as far as many users bother reading
    so make it as educational and exeplary as possible.
  
  
=head1 DESCRIPTION


    Simplemente incluye los ficherillos necesarios para que funcione porralia


=head1 INTERFACE 

=for author to fill in:
    Write a separate section listing the public components of the modules
    interface. These normally consist of either subroutines that may be
    exported, or methods that may be called on objects belonging to the
    classes provided by the module.


=head1 DIAGNOSTICS

=for author to fill in:
    List every single error and warning message that the module can
    generate (even the ones that will "never happen"), with a full
    explanation of each problem, one or more likely causes, and any
    suggested remedies.

=over

=item C<< Error message here, perhaps with %s placeholders >>

[Description of error here]

=item C<< Another error message here >>

[Description of error here]

[Et cetera, et cetera]

=back


=head1 CONFIGURATION AND ENVIRONMENT

=for author to fill in:
    A full explanation of any configuration system(s) used by the
    module, including the names and locations of any configuration
    files, and the meaning of any environment variables or properties
    that can be set. These descriptions must also include details of any
    configuration language used.
  
My::Porralia requires no configuration files or environment variables.


=head1 DEPENDENCIES

=for author to fill in:
    A list of all the other modules that this module relies upon,
    including any restrictions on versions, and an indication whether
    the module is part of the standard Perl distribution, part of the
    module's distribution, or must be installed separately. ]

None.


=head1 INCOMPATIBILITIES

=for author to fill in:
    A list of any modules that this module cannot be used in conjunction
    with. This may be due to name conflicts in the interface, or
    competition for system or program resources, or due to internal
    limitations of Perl (for example, many modules that use source code
    filters are mutually incompatible).

None reported.


=head1 BUGS AND LIMITATIONS

=for author to fill in:
    A list of known problems with the module, together with some
    indication Whether they are likely to be fixed in an upcoming
    release. Also a list of restrictions on the features the module
    does provide: data types that cannot be handled, performance issues
    and the circumstances in which they may arise, practical
    limitations on the size of data sets, special cases that are not
    (yet) handled, etc.

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-my-porralia@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.


=head1 AUTHOR

JJ Merelo  C<< <jj@merelo.net> >>


=head1 LICENCE AND COPYRIGHT

Copyright (c) 2008, JJ Merelo C<< <jj@merelo.net> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.


=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.
