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

