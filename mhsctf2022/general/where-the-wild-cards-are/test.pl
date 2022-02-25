use warnings 'all';
use strict;
use feature qw(say);

my $path="3920d9a1f126c1ae8c6e559234e62e7d.txt";

open my $fh, "<", $path  or die "Can't open $path: $!";

while (my $line = <$fh>)
{
    my @matches = $line =~ /[a-z,0-9,{,},_](?=[0-D][T-Z]{7,14})/g;

    say "@matches";
}

close $fh;