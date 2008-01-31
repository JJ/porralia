#!/usr/bin/perl

use strict;
use warnings;

use lib qw(..//lib);

use My::Porralia;
use My::Porralia::Porra;
use Data::Dumper qw(Dumper);

#Prog starts here
my $new_poll_file = shift || die "Falta fichero configuración\n";
my $porralia = My::Porralia->new();
my $porra = My::Porralia::Porra->new( $new_poll_file, $porralia );
print Dumper($porra->crea_post());



