package Project::Kickstart::Plugin::Add;
use Moose;
extends 'Project::Kickstart::Plugin';

has filenames => ( is => 'rw' );

our $VERSION = '0.01';

sub name { 'add' }
sub description { 'Add a file to an existing module' }

sub init {
  my $self = shift;
  my ( $args ) = @_;
  $self->config( { renumber => 1 } );
  $self->filenames( [] );
  my %action = (
    '--no-renumber' => sub { $self->config->{renumber} = undef },
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
use YAML;die "Filenames" .Dump($self->filenames);
}

no Moose;
__PACKAGE__->meta->make_immutable;
