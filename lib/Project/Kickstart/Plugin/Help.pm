package Project::Kickstart::Plugin::Help;
use Moose;
extends 'Project::Kickstart::Plugin';

our $VERSION = '0.01';

sub name { 'help' }
sub description { 'Display help for modules' }
sub help { <<'_EOF_' }
usage: project-kickstart help

  Print this help message. Maybe you wanted 'project-kickstart help'?
_EOF_

sub init {
  my $self = shift;
  my ( $args ) = @_;
  my %action = (
    '-h' => sub { print $self->help; exit 0 },
  );

  while ( my $arg = shift @$args ) {
    if ( $action{$arg} ) {
      $action{$arg}->();
    }
    else {
      push @{$self->filenames}, $arg;
    }
  }
  return 1;
}

sub act {
  my $self = shift;
  my ( $args ) = @_;
}

no Moose;
__PACKAGE__->meta->make_immutable;
