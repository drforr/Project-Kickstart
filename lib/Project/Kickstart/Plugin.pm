package Project::Kickstart::Plugin;
use Moose;

has config => ( is => 'rw', isa => 'HashRef' );
has lh => ( is => 'rw' );

sub maketext {
  my $self = shift;
  return $self->lh->maketext( @_ );
}

=pod

All Project::Kickstart plugins should be a subclass of this plugin class.
The global configuration is already set up for you in C<$self->config>, and
a localization handle is in C<$self->lh>, although it's not yet really clear
to me how custom plugins will add their own localization strings to the
hash without directly munging the L10n:: handles.

All Project::Kickstart plugins must implement the following methods:

=over

=item name

This class method must return the name by which the user will invoke your
plugin, like 'munge' in:

$ project-kickstart munge examples/widget.pl

=cut

=item description

This class method must return the ASCII description that will appear in the
'project-kickstart -h' list of methods available.

=cut

=item help

This class method returns the help text that will appear for
C<project-kickstart help your-module>.

=cut

=item init

This object method is called with your plugin parameters. Please note that you
will not get the full @ARGV as passed in.

=back

=item act

This object method is called with no parameters when it's time for your plugin
to do its thing.

=back

=cut

no Moose;
__PACKAGE__->meta->make_immutable;
