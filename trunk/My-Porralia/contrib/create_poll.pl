#!/usr/bin/perl

#Creates a poll, and posts it

use lib qw(../lib);

use strict;
use warnings;

use lib qw(My-Porralia/lib);
use My::Porralia;
use My::Porralia::Porra;

#Prog starts here
my $new_poll_file = shift || die "Falta fichero configuración\n";
my $porralia = My::Porralia->new();
my $porra = My::Porralia::Porra->new( $new_poll_file, $porralia );
$porra->post_poll();


