use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'My::Porralia',
    license             => 'perl',
    dist_author         => 'JJ Merelo <jj@merelo.net>',
    dist_version_from   => 'lib/My/Porralia.pm',
    requires => {
        'Test::More' => 0,
        'version'    => 0,
    },
    add_to_cleanup      => [ 'My-Porralia-*' ],
);

$builder->create_build_script();
