use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
	      NAME                => 'My::Porralia',
	      AUTHOR              => 'JJ Merelo <jj@merelo.net>',
	      VERSION_FROM        => 'lib/My/Porralia.pm',
	      ABSTRACT_FROM       => 'lib/My/Porralia.pm',
	      PL_FILES            => {},
	      PREREQ_PM => {
			    'Test::More' => 0,
			    'version'    => 0,
			    'YAML'       => 0,
			    'Net::Twitter' => 0,
			    'File::Slurp' => 0,
			    'CGI'         => 0 
			   },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'My-Porralia-*' },
);
