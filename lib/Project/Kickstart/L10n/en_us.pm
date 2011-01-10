package Project::Kickstart::L10n::en_us;
use base qw( Project::Kickstart::L10n );

my $usage = <<'_EOF_';
usage:	project-kickstart ~[-h~] ~[--help~] ~[-q~] ~[--quiet~] ~[--verbose~] ~[-v~]
			~[--version~] <command> ~[args~]

Commands are:
_EOF_

my $usage_add = <<'_EOF_';
usage: project-kickstart add ~[--no-renumber~] <files>

  Add file(s) to the project repository.

	--no-renumber	Do not renumber test files
_EOF_

my $usage_add_deps = <<'_EOF_';
usage: project-kickstart add-deps

  Add module dependencies to Makefile.PL.
_EOF_

my $usage_config = <<'_EOF_';
usage: project-kickstart config ~[--global~]

  Configure project-kickstart globals

	--global	Set a global property
_EOF_

my $usage_delete = <<'_EOF_';
usage: project-kickstart delete <files>

  Delete files from module and repository
_EOF_

my $usage_help = <<'_EOF_';
usage: project-kickstart help

  Print this help message. Maybe you wanted 'project-kickstart help'?
_EOF_

my $usage_init = <<'_EOF_';
usage: project-kickstart init <module-names>

  Init module repository
_EOF_

my $usage_rebuild_l10n = <<'_EOF_';
usage: project-kickstart rebuild-l10n

  Rebuild English localization strings for this application
_EOF_

my $usage_mv = <<'_EOF_';
usage: project-kickstart mv ~[--no-renumber~] <src> <dest>

  Rename file from <src> to <dest>

	--no-renumber	Do not renumber test files
_EOF_

%Lexicon = (
  $usage => $usage,
  $usage_add => $usage_add,
  $usage_add_deps => $usage_add_deps,
  $usage_config => $usage_config,
  $usage_delete => $usage_delete,
  $usage_help => $usage_help,
  $usage_init => $usage_init,
  $usage_mv => $usage_mv,
  $usage_rebuild_l10n => $usage_rebuild_l10n,

  q{Version: [_1]} =>
    q{Version: [_1]},

#
# Core error text
#
  q{Unknown mode '[_1]'!} =>
    q{Unknown mode '[_1]'!},
  q{Email '[_1]' does not have a '@'!} =>
    q{Email '[_1]' does not have a '@'!},
  q{At least one module name required!} =>
    q{At least one module name required!},
  q{Module name '[_1]' with leading hyphen!} =>
    q{Module name '[_1]' with leading hyphen!},
  q{Init for mode '[_1]' failed!} =>
    q{Init for mode '[_1]' failed!},

#
# Plugin error text
#
  q{project-kickstart add: No Makefile.PL or Build.PL found!} =>
    q{project-kickstart add: No Makefile.PL or Build.PL found!},

#
# Descriptions for standard plugins
#
  q{Add a file to an existing module} =>
    q{Add a file to an existing module},
  q{Add dependencies to Makefile.PL} =>
    q{Add dependencies to Makefile.PL},
  q{Configure project-kickstart globals} =>
    q{Configure project-kickstart globals},
  q{Delete file(s) from the current module} =>
    q{Delete file(s) from the current module},
  q{Display help for modules},
    q{Display help for modules} =>
  q{Init the module repository} =>
    q{Init the module repository},
  q{Rename a file in an existing module} =>
    q{Rename a file in an existing module},
  q{Rebuild localization hash from existing code},
    q{Rebuild localization hash from existing code} =>
);

1;
