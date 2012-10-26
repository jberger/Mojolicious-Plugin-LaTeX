use strict;
use warnings;

use Module::Build;

my $builder = Module::Build->new(
  module_name => 'Mojolicious::Plugin::LaTeX',
  dist_author => 'Joel A. Berger <joel.a.berger@gmail.com>',
  license => 'perl',
  configure_requires => {
    'Module::Build' => 0.36,
  },
  requires => {
    'Mojolicious' => 3.52,
    'TeX::Encode' => 0,
  },
  meta_merge => {
    resources  => {
      repository => "http://github.com/jberger/Mojolicious-Plugin-LaTeX",
      bugtracker => "http://github.com/jberger/Mojolicious-Plugin-LaTeX/issues",
    },
    no_index => {
      file      => [ 'README.pod' ],
      directory => [ 'examples', 't' ],
    },
  },
);

$builder->create_build_script;

