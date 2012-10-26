package Mojolicious::Plugin::LaTeX;
use Mojo::Base 'Mojolicious::Plugin';

our $VERSION = '0.01';

use TeX::Encode;

sub register {
  my ($self, $app, $conf) = @_;

  $app->plugin('EPRenderer' => {
    name => 'eptex', 
    template => {
      comment_mark  => '%',
      escape        => sub { TeX::Encode->encode($_[0]) }, 
      line_start    => '@',
      namespace     => 'Mojo::Template::SandBox::LaTeX';
      replace_mark  => '@',
      tag_start     => '{@',
      tag_end       => '@}',
    }, 
    %{ $conf->{template} || {} },
  });

  $app->types->type( tex => 'application/x-latex' );
}

1;
__END__

=head1 NAME

Mojolicious::Plugin::LaTeX - Mojolicious Plugin

=head1 SYNOPSIS

  # Mojolicious
  $self->plugin('LaTeX');

  # Mojolicious::Lite
  plugin 'LaTeX';

=head1 DESCRIPTION

L<Mojolicious::Plugin::LaTeX> is a L<Mojolicious> plugin.

=head1 METHODS

L<Mojolicious::Plugin::LaTeX> inherits all methods from
L<Mojolicious::Plugin> and implements the following new ones.

=head2 C<register>

  $plugin->register(Mojolicious->new);

Register plugin in L<Mojolicious> application.

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicio.us>.

=cut
