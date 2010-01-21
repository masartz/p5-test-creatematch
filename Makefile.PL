use inc::Module::Install;
name 'Test-CreateMatch';
all_from 'lib/Test/CreateMatch.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
