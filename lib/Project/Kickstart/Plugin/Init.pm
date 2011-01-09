package Project::Kickstart::Plugin::Init;
use Moose;
extends 'Project::Kickstart::Plugin';

has modules => ( is => 'rw' );

our $VERSION = '0.01';

sub name { 'init' }
sub description { 'Init the module repository' }
sub help { <<'_EOF_' }
usage: project-kickstart init <module-names>

  Init module repository
_EOF_

# Parses the remainder of @ARGV for 'project-kickstart init' and returns the
# module names it finds.
#
sub _get_module_names {
  my $self = shift;
  my ( $args ) = @_;
  my @modules;

  my %action = (
    '--module' => sub { push @modules, shift @$args },
    '--author' => sub { $self->config->{email} = shift @$args },
    '--email' => sub {
      my $arg = shift @$args;
      if ( $arg !~ /[@]/ ) {
        $self->Usage(
          $self->lh->maketext( q{Email '[_1]' does not have a '@'!}, $arg )
        );
      }
      $self->config->{email} = $arg;
    }
  );

  while ( my $arg = shift @$args ) {
    if ( $action{$arg} ) {
      $action{$arg}->();
    }
    elsif ( $arg =~ /^-/ ) {
      $self->Usage(
        $self->lh->maketext( q{Module name '[_1]' with leading hyphen!}, $arg )
      );
    }
    else {
      push @modules, $arg;
    }
  }

  return @modules;
}

sub _write_templates {
  my $self = shift;
  my ( $config ) = @_;
}

sub init {
  my $self = shift;
  my ( $args ) = @_;
  my %action = (
    '-h' => sub { print $self->help; exit 0 },
  );

  while ( my $arg = shift @$args ) {
    if ( $action{$arg} ) {
      $action{$arg}->();
    }
    else {
      push @{$self->filenames}, $arg;
    }
  }
  $self->modules( [ $self->_get_module_names( $args ) ] );
  return 1;
}

sub act {
  my $self = shift;
  my ( $args ) = @_;

  @{$self->modules} or
    $self->Usage(
      $self->lh->maketext( q{At least one module name required!} )
    );

  for my $module ( @{$self->modules} ) {
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

no Moose;
__PACKAGE__->meta->make_immutable;
