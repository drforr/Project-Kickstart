package Project::Kickstart::Plugin::Config;
use Getopt::Long;
use Project::Kickstart::Config_File;
use Moose;
extends 'Project::Kickstart::Plugin';

our $VERSION = '0.01';

sub name { 'config' }
sub description { 'Configure project-kickstart globals' }

sub help { <<'_EOF_' }
usage: project-kickstart config ~[--global~]

  Configure project-kickstart globals

	--global	Set a global property
_EOF_

sub init {
  my $self = shift;
  my ( $args ) = @_;
  my ( $help, @global );
  my $res = GetOptions(
    'h|help' => \$help,
    'global=s{,}' => \@global
  );

  $help and do { print $self->help; exit 0 };

  my ( $section, $key ) = split /\./, $global[0];
  my $value = $global[1];

  my $config = Project::Kickstart::Config_File->new;
  $config->init;
  $config->config->{$section}{$key} = $value;
  $config->write;

  return 1;
}

sub act {
  my $self = shift;
}

no Moose;
__PACKAGE__->meta->make_immutable;
