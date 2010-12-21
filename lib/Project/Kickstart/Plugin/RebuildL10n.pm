package Project::Kickstart::Plugin::RebuildL10n;
use Moose;
extends 'Project::Kickstart::Plugin';

our $VERSION = '0.01';

sub name { 'rebuild-l10n' }
sub description { 'Rebuild localization hash from existing code' }
sub help { <<'_EOF_' }
usage: project-kickstart rebuild-l10n

  Rebuild English localization strings for this application
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