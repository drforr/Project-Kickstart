package Project::Kickstart::Plugin::Global;
use Moose;
extends 'Project::Kickstart::Plugin';

has filenames => ( is => 'rw' );

our $VERSION = '0.01';

sub name { 'global' }
sub description { 'Set up project-kickstart globals' }

sub help { <<'_EOF_' }
usage: project-kickstart global

  Set up project-kickstart globals
_EOF_

sub init {
  my $self = shift;
  my ( $args ) = @_;
  $self->config( { renumber => 1 } );
  $self->filenames( [] );
  my %action = (
#    '--no-renumber' => sub { $self->config->{renumber} = undef },
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
  my %extension = (
    't' => sub { my $filename = shift; warn "Adding test file '$filename'\n" },
    'pm' => sub { my $filename = shift; warn "Adding module '$filename'\n" },
    '_binary_' => sub { my $filename = shift; warn "Adding binary '$filename'\n" },
  );

  for my $filename ( @{$self->filenames} ) {
    if ( $filename =~ /\.([^.]+)$/ ) {
      if ( $extension{$1} ) {
        $extension{$1}->($filename);
      }
      else {
warn "Don't know how to handle extension '.$1' for '$filename!\n";
      }
    }
    else {
      $extension{_binary_}->($filename);
    }
  }
}

no Moose;
__PACKAGE__->meta->make_immutable;