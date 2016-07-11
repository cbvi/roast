use v6;
use Test;
plan 15;

# L<S02/"Infinity and C<NaN>" /Perl 6 by default makes standard IEEE floating point concepts visible>

{
    my $x = Inf;

    ok( $x == Inf  , 'numeric equal');
    ok( $x eq 'Inf', 'string equal');
}

{
    my $x = -Inf;
    ok( $x == -Inf,   'negative numeric equal' );
    ok( $x eq '-Inf', 'negative string equal' );
}

#?rakudo skip 'integer Inf RT #124451'
{
    my $x = Inf.Int;
    ok( $x == Inf,   'int numeric equal' );
    ok( $x eq 'Inf', 'int string equal' );
}

#?rakudo skip 'integer Inf RT #124452'
{
    my $x = ( -Inf ).Int;
    ok( $x == -Inf,   'int numeric equal' );
    ok( $x eq '-Inf', 'int string equal' );
}

# Inf should == Inf. Additionally, Inf's stringification (~Inf), "Inf", should
# eq to the stringification of other Infs.
# Thus:
#     Inf == Inf     # true
# and:
#     Inf  eq  Inf   # same as
#     ~Inf eq ~Inf   # true

ok truncate(Inf) ~~ Inf,    'truncate(Inf) ~~ Inf';
#?rakudo 3 todo 'Int conversion of NaN and Inf RT #124453'
ok NaN.Int === NaN,         'Inf.Int === Int';
ok Inf.Int === Inf,         'Inf.Int === Int';
ok (-Inf).Int === (-Inf),   'Inf.Int === Int';

# RT #70730
{
    ok ( rand * Inf ) === Inf, 'multiply rand by Inf without maximum recursion depth exceeded';
}

{
    #RT #126990
    throws-like { my Int $x = Inf }, X::TypeCheck::Assignment,
        message => /'expected Int but got Num (Inf)'/,
    "trying to assign Inf to Int gives a helpful error";

    my Num $x = Inf;
    is $x, Inf, 'assigning Inf to Num works without errors';
}


# vim: ft=perl6
