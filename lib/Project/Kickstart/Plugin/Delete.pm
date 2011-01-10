package Project::Kickstart::Plugin::Delete;
use Getopt::Long;
use Moose;
extends 'Project::Kickstart::Plugin';

our $VERSION = '0.01';

sub alias { 'rm' }
sub name { 'delete' }
sub description { 'Delete file(s) from the current module' }
sub help { <<'_EOF_' }
usage: project-kickstart delete <files>

  Delete files from module and repository
_EOF_

sub init {
  my $self = shift;
  my ( $args ) = @_;
  my $help;
  my $res = GetOptions(
    'h|help' => \$help,
  );

  $help and do { print $self->help; exit 0 };

  push @{$self->filenames}, @ARGV;

  return 1;
}

sub act {
  my $self = shift;
  my ( $args ) = @_;
}

no Moose;
__PACKAGE__->meta->make_immutable;
