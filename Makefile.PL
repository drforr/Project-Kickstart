use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Project::Kickstart',
    AUTHOR              => q{Jeff Goff <jgoff@cpan.org>},
    VERSION_FROM        => 'lib/Project/Kickstart.pm',
    ABSTRACT_FROM       => 'lib/Project/Kickstart.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'Locale::Maketext' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Project-Kickstart-*' },
);
