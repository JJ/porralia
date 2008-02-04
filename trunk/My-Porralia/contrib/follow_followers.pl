#!/usr/bin/perl

use strict;
use warnings;
use lib qw(../lib);

use My::Porralia;

my $porralia = My::Porralia->new();
my $known_followers = $porralia->known_followers();
my $followers = $porralia->followers();
for my $f ( keys %$followers ) {
  if (!$known_followers->{$f} ) {
    $porralia->follow( $f );
    print "Following $f \n";
  }
}
$porralia->update_known_followers();

