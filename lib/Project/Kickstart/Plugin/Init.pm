package Project::Kickstart::Plugin::Init;
use Moose;
extends 'Project::Kickstart::Plugin';

our $VERSION = '0.01';

sub name { 'init' }
sub description { 'Initialize the project-kickstart repository' }
sub help { <<'_EOF_' }
usage: project-kickstart init

  Init a project-kickstart repository in this directory.
  It expects either a Makefile.PL or Build.PL file at the same directory
  level as this file.
_EOF_

sub init {
  my $self = shift;
  my ( $args ) = @_;
  return 1;
}

sub act {
  my $self = shift;
  my ( $args ) = @_;
}

no Moose;
__PACKAGE__->meta->make_immutable;
