#!/usr/bin/perl

use strict;
use warnings;

use lib qw(..//lib);
use CGI qw(:standard);

use My::Porralia;

my $porralia = My::Porralia->new();
my $porra = $porralia->porra();

print header, 
  "document.writeln('Porra actual en ",
  a( { -href=> 'http://twitter.com/porralia'}, 'Porralia' ),": ", 
  a( {-href => 'http://twitter.com/porralia/statuses/'.$porra->{'id'}}, 
     "&iquest;".$porra->{'pregunta'}."?" ), " ", 
  $porra->chart( 100, 50 ), "')" ;

	
