use strict;
use warnings;

use Test::More;
use MojoX::Template::LaTeX;

my $mt = MojoX::Template::LaTeX->new;
is $mt->render('{@== shift() =@}', 'jack & jill'), 'jack \& jill', 'tagged with escape';

done_testing;

