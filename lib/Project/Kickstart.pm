package Project::Kickstart;
use Module::Pluggable require => 1;
use Project::Kickstart::L10n;
use Config::Any;
use Moose;

has config => ( is => 'rw', isa => 'HashRef' );
has lh => ( is => 'rw' );
has plugin => ( is => 'rw' );

our $VERSION = '0.01';

sub init {
  my $self = shift;
  my $argv = shift;

  my $lh = Project::Kickstart::L10n->get_handle( 'en_us' ) ||
    die "No language specified!\n";
  $self->lh( $lh );

  my %reg;
  for my $plugin ( $self->plugins ) {
    my $name = $plugin->name;
    my $description = $plugin->description;
    $reg{$name} = $description;
  }
  $self->plugin( \%reg );
  $self->configure( $argv );
}

sub configure {
  my $self = shift;
  my ( $argv ) = @_;
  $self->config( {} );

  $self->config->{author} = $ENV{KICKSTART_AUTHOR}
    if $ENV{KICKSTART_AUTHOR} and $ENV{KICKSTART_AUTHOR} ne '';
  $self->config->{email} = $ENV{KICKSTART_EMAIL}
    if $ENV{KICKSTART_EMAIL} and $ENV{KICKSTART_EMAIL} ne '';

  $self->Usage unless @$argv;
  my @config_filepaths = ( $ENV{HOME}.'/.kickstartrc.ini' );
  my $cfg = Config::Any->load_files( {
    files => \@config_filepaths,
    use_ext => 1
  } );
  for my $config_file ( @$cfg ) {
    my ( $filename, $config ) = %$config_file;
    for my $k ( keys %$config ) {
      $self->config->{$k} ||= $config->{$k};
    }
  }

  while ( @$argv and $argv->[0] =~ /^-/ ) {
    my $arg = shift @$argv;

    $self->Usage if $arg eq '-h' or $arg eq '--help';
    $self->Usage(
      $self->lh->maketext( q{Version: [_1]}, $VERSION )
    ) if $arg eq '-v' or $arg eq '--version';
    $self->config->{verbose} = 1 if $arg eq '--verbose';
    $self->config->{quiet} = 1 if $arg eq '-q' or $arg eq '--quiet';
  }
}

sub Usage {
  my $self = shift;
  my $message = shift;
  print $message."\n" if $message;
  print $self->lh->maketext( <<'_EOF_' );
usage:	project-kickstart ~[-h~] ~[--help~] ~[-q~] ~[--quiet~] ~[--verbose~] ~[-v~]
			~[--version~] <command> ~[args~]

Commands are:
_EOF_

  my $max_length = 0;
  for my $name ( keys %{$self->plugin} ) {
    my $name_len = length $name;
    $max_length = $name_len if $name_len > $max_length;
  }
  for my $name ( sort keys %{$self->plugin} ) {
    printf "  %-${max_length}s  %s\n",
           $name,
           $self->lh->maketext( $self->plugin->{$name} );
  }
  exit defined $message ? 1 : 0;
}

sub run_plugin {
  my $self = shift;
  my ( $mode, $args ) = @_;

  $self->Usage( $self->lh->maketext( q{Unknown mode '[_1]'!}, $mode ) )
    unless $self->plugin->{$mode};

  for my $plugin ( $self->plugins ) {
    next unless $plugin->name eq $mode;
    my $p = $plugin->new;
    $p->config( $self->config );
    $p->lh( $self->lh );
    $p->init( $args ) or die "Init for ".$plugin->name." failed!\n";
    $p->act;
  }
}

no Moose;
__PACKAGE__->meta->make_immutable;
