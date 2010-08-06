use inc::Module::Install;
name 'AXTest';
all_from 'lib/AXTest.pm';

requires 'Ark';

tests 't/*.t';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
