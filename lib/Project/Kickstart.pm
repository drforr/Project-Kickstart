package Project::Kickstart;

use List::Util qw(max);
use Module::Pluggable require => 1;
use Project::Kickstart::L10n;
use Config::Any;
use Moose;

has config => ( is => 'rw' );
has lh => ( is => 'rw' );
has plugin => ( is => 'rw' );

our $VERSION = '0.01';

sub maketext {
  my $self = shift;
  return $self->lh->maketext( @_ );
}

sub init {
  my $self = shift;
  my ( $argv ) = @_;

  my $lh = Project::Kickstart::L10n->get_handle( 'en_us' ) ||
    die "English translations not found!";
  $self->lh( $lh );

  my %reg;
  for my $plugin ( $self->plugins ) {
    my $name = $plugin->name;
    my $description = $plugin->description;
    $reg{$name} = { description => $description, module => $plugin };
    if ( $plugin->can( 'alias' ) ) {
      for my $alias ( $plugin->alias ) {
        $reg{$alias} = { description => $description, module => $plugin };
      }
    }
  }
  $self->plugin( \%reg );
  $self->configure( $argv );

  $self->Usage unless @$argv;
}

sub configure {
  my $self = shift;
  my ( $argv ) = @_;
  my %config;

  $config{author} = $ENV{KICKSTART_AUTHOR}
    if $ENV{KICKSTART_AUTHOR} and $ENV{KICKSTART_AUTHOR} ne '';
  $config{email} = $ENV{KICKSTART_EMAIL}
    if $ENV{KICKSTART_EMAIL} and $ENV{KICKSTART_EMAIL} ne '';

  $self->Usage unless @$argv;
  my $kickstart_path = '.kickstart';
  my $kickstart_file = 'config.ini';

  my @config_filepaths = (
    $ENV{HOME} . '/' . $kickstart_path . '/' . $kickstart_file
  );
  if ( $ENV{KICKSTART_CONFIG_DIR} ) {
    unshift @config_filepaths,
      $ENV{KICKSTART_CONFIG_DIR} . '/' . $kickstart_file;
  }
  
  my $cfg = Config::Any->load_files( {
    files => \@config_filepaths,
    use_ext => 1
  } );
  for my $config_file ( @$cfg ) {
    my ( $filename, $config ) = %$config_file;
    for my $k ( keys %$config ) {
      $config{$k} ||= $config->{$k};
    }
  }

  while ( @$argv and $argv->[0] =~ /^-/ ) {
    my $arg = shift @$argv;

    $self->Usage if $arg eq '-h' or $arg eq '--help';
    $self->Usage(
      $self->maketext( q{Version: [_1]}, $VERSION )
    ) if $arg eq '-v' or $arg eq '--version';
    $config{verbose} = 1 if $arg eq '--verbose';
    $config{quiet} = 1 if $arg eq '-q' or $arg eq '--quiet';
  }
  $self->config( \%config );
}

sub _print_plugins {
  my $self = shift;
  my $max_length = max( map { length $_ } keys %{$self->plugin} );
  for my $name ( sort keys %{$self->plugin} ) {
    printf "  %-${max_length}s  %s\n",
           $name,
           $self->maketext( $self->plugin->{$name}{description} );
  }
}

sub Usage {
  my $self = shift;
  my $message = shift;
  print $message."\n" if $message;
  print $self->maketext( <<'_EOF_' );
usage:	project-kickstart ~[-h~] ~[--help~] ~[-q~] ~[--quiet~] ~[--verbose~] ~[-v~]
			~[--version~] <command> ~[args~]

Commands are:
_EOF_

  $self->_print_plugins;
  exit defined $message ? 1 : 0;
}

sub run_plugin {
  my $self = shift;
  my ( $mode, $args ) = @_;

  $self->Usage( $self->maketext( q{Unknown mode '[_1]'!}, $mode ) )
    unless $self->plugin->{$mode};

  if ( $mode eq 'help' ) {
    my $module = shift @$args;
    if ( $module and $self->plugin->{$module} ) {
      print $self->maketext( $self->plugin->{$module}{module}->help );
    }
    else {
      print $self->maketext( $self->plugin->{help}{module}->help );
    }
  }
  else {
    my $p = $self->plugin->{$mode}{module}->new;
    $p->config( $self->config );
    $p->lh( $self->lh );
    if ( $p->can( 'init' ) ) {
      $p->init( $args )
        or die $self->maketext( q{Init for mode '[_1]' failed!}, $mode ) . "\n";
    }

    $p->act
      if $p->can( 'act' );
  }
}

no Moose;
__PACKAGE__->meta->make_immutable;
