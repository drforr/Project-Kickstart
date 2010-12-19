package Project::Kickstart::L10n::en_us;
use base qw( Project::Kickstart::L10n );

my $usage_statement = <<'_EOF_';
usage:	project-kickstart ~[-h~] ~[--help~] ~[-q~] ~[--quiet~] ~[--verbose~] ~[-v~]
			~[--version~] <command> ~[args~]

Commands are:
  add		Add a file to an existing module
  create	Create a new module
  delete	Delete a file from the current module
  init		Initialize the project-kickstarter repository
  rebuild-l10n	Rebuild the localization database from existing code
_EOF_

%Lexicon = (
  $usage_statement => $usage_statement,
  q{Version: [_1]} => q{Version: [_1]},
  q{Unknown mode '[_1]'} => q{Unknown mode '[_1]'},
  q{Email '[_1]' does not have a '@'!} => q{Email '[_1]' does not have a '@'!},
  q{Ignoring unknown arguments '[_1]'} => q{Ignoring unknown arguments '[_1]'},
  q{At least one module name required!} => q{At least one module name required!},
);

1;
