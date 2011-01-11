package Project::Kickstart::Plugin::Config;
use Getopt::Long;
use Project::Kickstart::Config_File;
use Moose;
extends 'Project::Kickstart::Plugin';

our $VERSION = '0.01';

has global => ( is => 'rw' );

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

  if ( @global ) {
    $self->global( { $global[0] => $global[1] } );
  }

  return 1;
}

sub act {
  my $self = shift;
  my $config = Project::Kickstart::Config_File->new;
  $config->init;

  if ( $self->global ) {
    for my $k ( keys %{$self->global} ) {
      my ( $section, $key ) = split /\./, $k;
      my $value = $self->global->{$k};

      $config->config->{$section}{$key} = $value;
    }
    $config->write;
  }
}

no Moose;
__PACKAGE__->meta->make_immutable;
