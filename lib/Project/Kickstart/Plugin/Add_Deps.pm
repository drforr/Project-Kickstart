package Project::Kickstart::Plugin::Add_Deps;
use Getopt::Long;
use Moose;
extends 'Project::Kickstart::Plugin';

has filenames => ( is => 'rw' );

our $VERSION = '0.01';

sub name { 'add-deps' }
sub description { 'Add dependencies to Makefile.PL' }

sub help { <<'_EOF_' }
usage: project-kickstart add-deps

  Add module dependencies to Makefile.PL.
_EOF_

sub init {
  my $self = shift;
  my ( $args ) = @_;
  my $help;
  my $res = GetOptions(
    'h|help' => \$help,
  );

  $help and do { print $self->help; exit 0 };

  push @{$self->filename}, @ARGV;

  return 1;
}

sub act {
  my $self = shift;
}

no Moose;
__PACKAGE__->meta->make_immutable;
