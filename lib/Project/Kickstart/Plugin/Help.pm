package Project::Kickstart::Plugin::Help;
use Getopt::Long;
use Moose;
extends 'Project::Kickstart::Plugin';

our $VERSION = '0.01';

sub name { 'help' }
sub description { 'Display help for modules' }
sub help { <<'_EOF_' }
usage: project-kickstart help

  Print this help message. Maybe you wanted 'project-kickstart help'?
_EOF_

no Moose;
__PACKAGE__->meta->make_immutable;
