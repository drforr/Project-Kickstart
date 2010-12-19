package Project::Kickstart;
use Moose;

has config => ( is => 'rw', isa => 'HashRef' );
has lh => ( is => 'rw' );

our $VERSION = '0.01';

sub Usage {
  my $self = shift;
  my $message = shift;
  print $message."\n" if $message;
  print $self->lh->maketext( <<'_EOF_' );
usage:	project-kickstart ~[-h~] ~[--help~] ~[-q~] ~[--quiet~] ~[--verbose~] ~[-v~]
			~[--version~] <command> ~[args~]

Commands are:
  add		Add a file to an existing module
  create	Create a new module
  delete	Delete a file from the current module
  init		Initialize the project-kickstarter repository
  rebuild-l10n	Rebuild the localization database from existing code
_EOF_
  exit defined $message ? 1 : 0;
}

sub add {
  my $self = shift;
  my $args = shift;
  my @filenames;

  while ( my $arg = shift @$args ) {
next if $arg =~ /^-/;
    push @filenames, $arg;
  }
}

sub _get_module_names {
  my $self = shift;
  my $args = shift;
  my @modules;

  while ( my $arg = shift @$args ) {
    if ( $arg eq '--module' or $arg eq '-m' ) {
      $arg = shift @$args;
      push @modules, $arg;
    }
    elsif ( $arg eq '--author' or $arg eq '-a' ) {
      $arg = shift @$args;
      $self->config->{email} = $arg;
    }
    elsif ( $arg eq '--email' or $arg eq '-e' ) {
      $arg = shift @$args;
      if ( $arg !~ /[@]/ ) {
        $self->Usage(
          $self->lh->maketext( q{Email '[_1]' does not have a '@'!}, $arg )
        );
      }
      $self->config->{email} = $arg;
    }
  }

  if ( @$args ) {
    unless( $self->config->{quiet} ) {
      print $self->lh->maketext( q{Ignoring unknown arguments '[_1]'}, @$args );
    }
  }

  return @modules;
}

sub _write_templates {
  my $self = shift;
  my $config = shift;
}


sub create {
  my $self = shift;
  my $args = shift;
  my @modules = $self->_get_module_names( $args );

  @modules or
    $self->Usage( $self->lh->maketext( q{At least one module name required!} ) );

  for my $module ( @modules ) {
    $module =~ s{\.pm$}{};
    my $canonical_perl_name = $module;
    $module =~ s{\::}{-}g;
    my $canonical_name = $module;
    my @path = split /-/, $module;
    my $file = pop @path;

    my %config = (
      author => $self->config->{author},
      email => $self->config->{email},
      canonical_perl_name => $canonical_perl_name,
      canonical_name => $canonical_name,
      module_name => $module,
      directory => join( '/', @path ),
      file => $file
    );

    $self->write_templates( \%config );
  }
}

sub delete {
  my $self = shift;
  my $args = shift;
}

sub init {
  my $self = shift;
  my $args = shift;
}

sub rebuild_l10n {
  my $self = shift;
  my $args = shift;
}

no Moose;
__PACKAGE__->meta->make_immutable;
