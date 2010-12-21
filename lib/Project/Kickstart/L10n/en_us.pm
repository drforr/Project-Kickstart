package Project::Kickstart::L10n::en_us;
use base qw( Project::Kickstart::L10n );

my $usage_statement = <<'_EOF_';
usage:	project-kickstart ~[-h~] ~[--help~] ~[-q~] ~[--quiet~] ~[--verbose~] ~[-v~]
			~[--version~] <command> ~[args~]

Commands are:
_EOF_

%Lexicon = (
  $usage_statement => $usage_statement,
  q{Version: [_1]} =>
    q{Version: [_1]},
  q{Unknown mode '[_1]'!} =>
    q{Unknown mode '[_1]'!},
  q{Email '[_1]' does not have a '@'!} =>
    q{Email '[_1]' does not have a '@'!},
  q{At least one module name required!} =>
    q{At least one module name required!},
  q{Module name '[_1]' with leading hyphen!} =>
    q{Module name '[_1]' with leading hyphen!},

  q{Add a file to an existing module} =>
    q{Add a file to an existing module},
  q{Create new module(s)} =>
    q{Create new module(s)},
  q{Delete file(s) from the current module} =>
    q{Delete file(s) from the current module},
  q{Initialize the project-kickstart repository} =>
    q{Initialize the project-kickstart repository},
  q{Rebuild localization hash from existing code},
    q{Rebuild localization hash from existing code} =>
);

1;
