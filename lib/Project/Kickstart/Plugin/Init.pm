package Project::Kickstart::Plugin::Init;
use Moose;
extends 'Project::Kickstart::Plugin';

our $VERSION = '0.01';

sub name { 'init' }
sub description { 'Initialize the project-kickstart repository' }

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
