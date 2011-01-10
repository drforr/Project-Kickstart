package Project::Kickstart::Plugin::Mv;
use Getopt::Long;
use Moose;
extends 'Project::Kickstart::Plugin';

has filenames => ( is => 'rw' );

our $VERSION = '0.01';

sub alias { 'rename' }
sub name { 'mv' }
sub description { 'Rename a file in an existing module' }

sub help { <<'_EOF_' }
usage: project-kickstart mv ~[--no-renumber~] <src> <dest>

  Rename file from <src> to <dest>

	--no-renumber	Do not renumber test files
_EOF_

sub init {
  my $self = shift;
  my ( $args ) = @_;
  my ( $help, $no_renumber );
  my $res = GetOptions(
    'h|help' => \$help,
    'no-renumber' => \$no_renumber
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
    't' => sub { my $filename = shift; warn "Renaming test file '$filename'\n" },
    'pm' => sub { my $filename = shift; warn "Renaming module '$filename'\n" },
    '_binary_' => sub { my $filename = shift; warn "Renaming binary '$filename'\n" },
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
