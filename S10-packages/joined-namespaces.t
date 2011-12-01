use v6;
use Test;
BEGIN { @*INC.push: 't/spec/packages/' }

plan 2;

use Fancy::Utilities;
ok eval('class Fancy { }; 1'), 'can define a class A when module A::B has been used';

eval_lives_ok 'my class A::B { ... }; A::B.new(); class A::B { };',
    'can stub lexical classes with joined namespaces'
