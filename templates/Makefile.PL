use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => '@@canonical_name@@',
    AUTHOR              => q{@@author@@ <@@email@@>},
    VERSION_FROM        => 'lib/@@directory@@/@@file@@.pm',
    ABSTRACT_FROM       => 'lib/@@directory@@/@@file@@.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'Locale::Maketext' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => '@@canonical_name@@-*' },
);
