use Mojolicious::Lite;
use Test::More;
use Test::Mojo;

plugin 'LaTeX';

get '/helper';

my $t = Test::Mojo->new;

$t->get_ok('/helper.tex')
  ->status_is(200)
  ->content_is(<<'END');
\begin{equation}
  E = m c^2
\end{equation}
END

done_testing;

__DATA__

@@ helper.tex.eptex
@= ltx_env equation => begin
  E = m c^2
@= end
