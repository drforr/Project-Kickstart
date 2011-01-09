package Project::Kickstart::Manifest;
use List::Util qw( min );
use Project::Kickstart::L10n;
use Moose;

has lh => ( is => 'rw' );
has filepath => ( is => 'rw', isa => 'Str' );
has pathnames => ( is => 'rw' );

sub init {
  my $self = shift;
  my ( $filepath ) = @_;
  $self->filepath( $filepath );
  my $lh = Project::Kickstart::L10n->get_handle( 'en_us' ) ||
    die "English translations not found!";
  $self->lh( $lh );
}

sub write {
  my $self = shift;

  open my $fh, '>', $self->filepath or die $!;
    die $self->lh->maketext( q{Could not write to '[_1]': [_2]!}, $self->filepath, $! ) . "\n";
  for my $filename ( $self->sort_manifest( $self->pathnames ) ) {
    print $fh join( '/', @$filename ) . "\n";
  }
  close $fh;
}

sub read {
  my $self = shift;
  -e $self->filepath or
    die $self->lh->maketext( q{Could not find '[_1]'!}, $self->filepath ) . "\n";

  my @paths;
  open my $fh, '<', $self->filepath or die $!;
  while ( my $line = <$fh> ) {
    next unless $line =~ m{ \S }x;
    next if $line =~ m{^ \s* #}x;
    chomp $line;
    $line =~ m{ \s* # .+ $}x;
    push @paths, [ split '/', $line ];
  }
  $self->pathnames( \@paths );
  close $fh;
}

sub sort {
  my $self = shift;

  my %seen;
  for my $pathname ( @{$self->pathnames} ) {
    $seen{join('/',@$pathname)}++;
  }

  $self->pathnames( [
    sort {
      my $max = min( scalar @$a, scalar @$b );
      for my $idx ( 0 .. $max ) {
        return $a->[$idx] cmp $b->[$idx] if ( $a->[$idx] cmp $b->[$idx] ) != 0;
      }
    } map { [ split '/', $_ ] } keys %seen
  ] );
}

sub add {
  my $self = shift;
  my ( $filename ) = @_;
  $self->pathnames( [
    @{$self->pathnames},
    [ split '/', $filename ]
  ] );
}

sub remove {
  my $self = shift;
  my ( $filename ) = @_;
  my @final_pathnames;
  for my $pathname ( @{$self->pathnames} ) {
    next if join( '/', @$pathname ) eq $filename;
    push @final_pathnames, $pathname;
  }
  $self->pathnames( \@final_pathnames );
}

sub tests {
  my $self = shift;
  my @tests;
  for my $pathname ( @{$self->pathnames} ) {
    next unless $pathname->[0] eq 't';
    push @tests, $pathname;
  }
  return @tests;
}

=pod

Manifest utilities

=cut

no Moose;
__PACKAGE__->meta->make_immutable;
