use warnings 'all';
use strict;
use feature qw(say);

my $test="abdKH996ii_\\a";

say $test =~ /\w/g;
say $test =~ /[a-z]+(?=[A-Z]{2}[A-Z]*[0-9]{3}[0-9]*)/g;
