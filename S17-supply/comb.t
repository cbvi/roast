use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Tap;

my @source = <old dog jumpso>;
my @schedulers = ThreadPoolScheduler.new, CurrentThreadScheduler;

plan @schedulers * 23;

for @schedulers -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.^name}";

    for \(), \(1), \(0), \(-1) -> \c {
        tap-ok Supply.from-list(@source).comb(|c),
          [<o l d d o g j u m p s o>],
          "comb a simple list of words with {c.raku.substr(1)}";
    }

    for \(2), \(/../) -> \c {
        tap-ok Supply.from-list(@source).comb(|c),
          [<ol dd og ju mp so>],
          "comb a simple list of words with {c.raku.substr(1)}";
    }

    for \(2,2), (/../,2) -> \c {
        tap-ok Supply.from-list(@source).comb(|c),
          [<ol dd>],
          "comb a simple list of words with {c.raku.substr(1)}";
    }

    for \(5), \(5,10) -> \c {
        tap-ok Supply.from-list(@source).comb(|c),
          [<olddo gjump so>],
          "comb a simple list of words with {c.raku.substr(1)}";
    }

    for \(/.**5/), \(/.**5/,10), \(/.**5/,:!match), \(/.**5/,10,:!match) -> \c {
        tap-ok Supply.from-list(@source).comb(|c),
          [<olddo gjump>],
          "comb a simple list of words with {c.raku.substr(1)}";
    }

    for \(20) -> \c {
        tap-ok Supply.from-list(@source).comb(|c),
          ['olddogjumpso'],
          "comb a simple list of words with {c.raku.substr(1)}";
    }

    for \("o"), \("o",Inf), \("o",*) -> \c {
        tap-ok Supply.from-list(@source).comb(|c),
          [<o o o>],
          "comb a simple list of words with {c.raku.substr(1)}";
    }

    for \('z'), \(/.**20/), \(/.**20/,:!match) -> \c {
        tap-ok Supply.from-list(@source).comb(|c),
          [],
          "comb a simple list of words with {c.raku.substr(1)}";
    }

    tap-ok Supply.from-list(@source).comb(/./, :match),
      [<o l d d o g j u m p s o>],
      "comb with (/./, :match)";

    tap-ok Supply.from-list(@source).comb(/./, 10, :match),
      [<o l d d o g j u m p>],
      "comb with (/./, 10, :match)";
}

# vim: ft=perl6 expandtab sw=4
