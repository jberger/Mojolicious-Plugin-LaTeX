package MojoX::Template::LaTeX;
use Mojo::Base 'Mojo::Template';

use TeX::Encode;

my $escape = sub { TeX::Encode->encode($_[0]) };

has comment_mark  => '%';
has escape        => sub { $escape };
has [qw(line_start replace_mark)] => '@';
has namespace => 'Mojo::Template::SandBox::LaTeX';
has tag_start => '{@';
has tag_end   => '@}';

1;

=head1 NAME

MojoX::Template::LaTeX - Mojo::Template for especially for LaTeX

=head1 SYNOPSIS

 use strict;
 use warnings;

 use MojoX::Template::LaTeX;

 my $mt = MojoX::Template::LaTeX->new;
 print $mt->render(<<'END', 'jack & jill');
   @ my $name = shift;
   \documentclass{article}
   \begin{document}
     Hello {@== $name @}
   \end{document}
 END

=head1 DESCRIPTION

L<MojoX::Template::LaTeX> is a subclass of L<Mojo::Template> with default that are more appropriate for LaTeX use, including escaping.

=head1 SYNTAX

For all templates L<strict>, L<warnings> and Perl 5.10 features are
automatically enabled.

  {@ Perl code @}
  {@= Perl expression, replaced with result @}
  {@== Perl expression, replaced with TeX escaped result @}
  {@% Comment, useful for debugging @}
  {@@ Replaced with "{@", useful for generating templates @}
  @ Perl code line, treated as "{@ line =@}"
  @= Perl expression line, treated as "{@= line @}"
  @== Perl expression line, treated as "{@== line @}"
  @% Comment line, treated as "{@% line =@}"
  @@ Replaced with "@", useful for generating templates

Escaping behavior can be reversed with the C<auto_escape> attribute, this is
the default in L<Mojolicious> C<.ep> templates for example.

  {@= Perl expression, replaced with XML escaped result @}
  {@== Perl expression, replaced with result @}

L<Mojo::ByteStream> objects are always excluded from automatic escaping.

  {@= Mojo::ByteStream->new('\textbf{excluded!}') @}

Newline characters can be escaped with a backslash.

  This is {@= 1 + 1 @} a\
  single line

And a backslash in front of a newline character can be escaped with another
backslash.

  This will {@= 1 + 1 @} result\\
  in multiple\\
  lines

Whitespace characters around tags can be trimmed with a special tag ending.

  {@= All whitespace characters around this expression will be trimmed =@}

You can capture whole template blocks for reuse later with the C<begin> and
C<end> keywords.

  {@ my $block = begin @}
    {@ my $name = shift; =@}
    Hello {@= $name @}.
  {@ end @}
  {@= $block->('Baerbel') @}
  {@= $block->('Wolfgang') @}

Perl lines can also be indented freely.

  @ my $block = begin
    @ my $name = shift;
    Hello {@= $name @}.
  @ end
  @= $block->('Baerbel')
  @= $block->('Wolfgang')

L<Mojo::Template> templates get compiled to a Perl subroutine, that means you
can access arguments simply via C<@_>.

  @ my ($foo, $bar) = @_;
  @ my $x = shift;
  test 123 {@= $foo @}

The compilation of templates to Perl code can make debugging a bit tricky, but
L<Mojo::Template> will return L<Mojo::Exception> objects that stringify to
error messages with context.

  Bareword "xx" not allowed while "strict subs" in use at template line 4.
  2: \usepackage{graphicx}
  3: \begin{document}
  4: @ my $i = 2; xx
  5: @= $i * 2
  6: \end{document}

=head1 ATTRIBUTES

L<MojoX::Template::LaTeX> inherits all attributes from L<Mojo::Template>.

=head1 METHODS

L<MojoX::Template::LaTeX> inherits all methods from L<Mojo::Template>.

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicio.us>.

=cut
