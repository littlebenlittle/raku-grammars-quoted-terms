use v6;

use Test;
use Grammars::QuotedTerms;

class Unit {
    has $.term;
    has @.expects;
}

my @units = [
    Unit.new(
        term => 'this is a test',
        expects => « this is a test »,
    ),
    Unit.new(
        term => 'this "is" a \'test\'',
        expects => « this is a test »,
    ),
    Unit.new(
        term => '"this"',
        expects => « this »,
    ),
    Unit.new(
        term => '"this is" \'a test\'',
        expects => [ 'this is', 'a test' ],
    ),
    Unit.new(
        term => 'harness .',
        expects => « harness . »,
    ),
];

plan @units.elems;

for @units {
    say .term;
    say Grammars::QuotedTerms.parse(.term);
}

is-deeply
    Grammars::QuotedTerms.parse(.term).made,
    .expects,
    .term for @units;

done-testing;

