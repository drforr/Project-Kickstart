package Project::Kickstart::Plugin::Init;
use Getopt::Long;
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

sub _write_templates {
  my $self = shift;
  my ( $config ) = @_;
}

sub init {
  my $self = shift;
  my ( $args ) = @_;
  my ( $help, @module, $author, $email );
  my $res = GetOptions(
    'h|help' => \$help,
    'module=s{,}' => \@module,
    'author=s' => \$author,
    'email=s' => \$email,
  );

  $help and do { print $self->help; exit 0 };
  $author and do { $self->config->{author} = $author };
  if ( $email =~ /[@]/ ) {
    $self->Usage(
      $self->lh->maketext( q{Email '[_1]' does not have a '@'!}, $email )
    );
  }
  else {
    $self->config->{email} = $email;
  }

  $self->modules( [ @module ] );

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
