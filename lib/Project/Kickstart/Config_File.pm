package Project::Kickstart::Config_File;
use Project::Kickstart::L10n;
use Config::Any;
use Moose;

has filepath => ( is => 'rw' );
has config => ( is => 'rw' );
has lh => ( is => 'rw' );

sub _set_filepath {
  my $self = shift;
  my $kickstart_path = '.kickstart';
  my $kickstart_file = 'config.ini';

  if ( $ENV{KICKSTART_CONFIG_DIR} ) {
    $self->filepath( $ENV{KICKSTART_CONFIG_DIR} . '/' . $kickstart_file );
  }
  else {
    $self->filepath( $ENV{HOME} . '/' . $kickstart_path . '/' . $kickstart_file  );
  }
}

sub init {
  my $self = shift;
  $self->_set_filepath;
  my $lh = Project::Kickstart::L10n->get_handle( 'en_us' ) ||
    die "English translations not found!";
  $self->lh( $lh );

  $self->config( { } );

  my $cfg = Config::Any->load_files( {
    files => [ $self->filepath ],
    use_ext => 1
  } );
  for my $config_file ( @$cfg ) {
    my ( $filename, $config ) = %$config_file;
    for my $section ( keys %$config ) {
      for my $k ( keys %{$config->{$section}} ) {
        $self->config->{$section}{$k} ||= $config->{$section}{$k};
      }
    }
  }
}

sub write {
  my $self = shift;

  open my $fh, '>', $self->filepath or
    die $self->lh->maketext(
      q{Could not write to '[_1]': [_2]!}, $self->filepath, $! ) . "\n";
  for my $section ( sort keys %{$self->config} ) {
    if ( ref $self->config->{$section} ) {
      print $fh "[$section]\n";
      for my $k ( sort keys %{$self->config->{$section}} ) {
        print $fh "\t$k = " . $self->config->{$section}{$k} . "\n";
      }
    }
    else {
      print $fh $section . ' = ' . $self->config->{$section} . "\n";
    }
  }
  close $fh;
}

=pod

Configuration file utilities

=cut

no Moose;
__PACKAGE__->meta->make_immutable;
