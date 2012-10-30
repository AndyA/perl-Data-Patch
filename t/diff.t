#!perl

use strict;
use warnings;

use Data::Dumper;
use Test::More;

use Data::Patch qw( data_diff );

my @case = (
  {
    name => 'Hash',
    a    => { foo => 1, bar => 'two' },
    b    => { foo => 1, bar => 'three' },
    want => [
      { op => 'remove', path => '$.bar' },
      { op => 'add', path => '$', element => 'bar', value => 'three' },
    ],
  },
  {
    name => 'Array',
    a    => [ 1, 2, 3 ],
    b    => [ 1, 3, 2 ],
    want => [
      { op => 'remove', path => '$.1' },
      { op => 'add',    path => '$', element => 1, value => 3 },
      { op => 'remove', path => '$.2' },
      { op => 'add',    path => '$', element => 2, value => 2 },
    ],
  },
  {
    name => 'Root scalar',
    a    => 'One',
    b    => 2,
    want => [
      { op => 'remove', path    => '$' },
      { op => 'add',    element => '$', value => 2 },
    ],
  },
  {
    name => 'Type change/hash',
    a    => { foo => 1, bar => 'two' },
    b    => { foo => 1, bar => [ 1, 2, 3 ] },
    want => [
      { op => 'remove', path => '$.bar' },
      {
        op      => 'add',
        path    => '$',
        element => 'bar',
        value   => [ 1, 2, 3 ]
      },
    ],
  },
);

plan tests => 1 * @case;

for my $tc ( @case ) {
  my $got = data_diff( $tc->{a}, $tc->{b} );
  is_deeply $got, $tc->{want}, "$tc->{name}: diff OK"
   or diag Dumper( $got );
}

# vim:ts=2:sw=2:et:ft=perl

