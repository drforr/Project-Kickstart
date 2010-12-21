package Project::Kickstart::Plugin::Delete;
use Moose;
extends 'Project::Kickstart::Plugin';

our $VERSION = '0.01';

sub name { 'delete' }
sub description { 'Delete file(s) from the current module' }

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
