use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'WebService::Mendeley',
    AUTHOR              => q{Spiros Denaxas <s.denaxas@gmail.com>},
    VERSION_FROM        => 'lib/WebService/Mendeley.pm',
    ABSTRACT_FROM       => 'lib/WebService/Mendeley.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More'     => 0,
        'Carp'           => 0,
        'LWP::UserAgent' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'WebService-Mendeley-*' },
);
