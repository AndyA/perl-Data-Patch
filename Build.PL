use strict;
use warnings;

use lib 'inc';

use Module::Build;
use MyBuilder;

my $builder = MyBuilder->new(
  module_name       => 'Data::Patch',
  license           => 'perl',
  dist_author       => 'Andy Armstrong <andy@hexten.net>',
  dist_version_from => 'lib/Data/Patch.pm',
  requires          => { 'Test::More' => 0, },
  add_to_cleanup    => ['Data-Patch-*'],
);

$builder->create_build_script();
