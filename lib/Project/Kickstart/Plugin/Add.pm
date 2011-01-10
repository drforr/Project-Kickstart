package Project::Kickstart::Plugin::Add;
use Project::Kickstart::Manifest;
use Getopt::Long;
use Moose;
extends 'Project::Kickstart::Plugin';

has filenames => ( is => 'rw' );

our $VERSION = '0.01';

sub name { 'add' }
sub description { 'Add a file to an existing module' }

sub help { <<'_EOF_' }
usage: project-kickstart add ~[--no-renumber~] <files>

  Add file(s) to the project repository.

	--no-renumber	Do not renumber test files
_EOF_

sub init {
  my $self = shift;
  my ( $args ) = @_;
  my ( $help, $no_renumber );
  my $res = GetOptions(
    'h|help' => \$help,
    'no-renumber' => \$no_renumber,
  );

  $self->config( { renumber => 1 } );
  $self->filenames( [] );

  $help and do { print $self->help; exit 0 };
  $no_renumber and do { $self->config->{renumber} = undef };

  push @{$self->filenames}, @ARGV;

  return 1;
}

sub act {
  my $self = shift;
  my $manifest = Project::Kickstart::Manifest->new;
  $manifest->init( 'MANIFEST' );
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
