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

my $usage_create = <<'_EOF_';
usage: project-kickstart create <module-names>

  Create module names
_EOF_

my $usage_delete = <<'_EOF_';
usage: project-kickstart delete <files>

  Delete files from module and repository
_EOF_

my $usage_help = <<'_EOF_';
usage: project-kickstart help

  Print this help message. Maybe you wanted 'project-kickstart help'?
_EOF_

my $usage_help = <<'_EOF_';
usage: project-kickstart init

  Init a project-kickstart repository in this directory.
  It expects either a Makefile.PL or Build.PL file at the same directory
  level as this file.
_EOF_

my $usage_rebuild_l10n = <<'_EOF_';
usage: project-kickstart rebuild-l10n

  Rebuild English localization strings for this application
_EOF_

my $usage_init_environment = <<'_EOF_';
usage: project-kickstart init-environment ~[--no-profile~]

  Initialize your work environment,

	--no-profile	Do not edit .bashrc/.zshrc/.sh scripts
_EOF_

%Lexicon = (
  $usage => $usage,
  $usage_add => $usage_add,
  $usage_add_deps => $usage_add_deps,
  $usage_delete => $usage_delete,
  $usage_help => $usage_help,
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
  q{Create new module(s)} =>
    q{Create new module(s)},
  q{Delete file(s) from the current module} =>
    q{Delete file(s) from the current module},
  q{Initialize the project-kickstart repository} =>
    q{Initialize the project-kickstart repository},
  q{Rebuild localization hash from existing code},
    q{Rebuild localization hash from existing code} =>
  q{Add dependencies to Makefile.PL} =>
    q{Add dependencies to Makefile.PL},
);

1;
