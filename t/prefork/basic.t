use strict;
use warnings;
use Test::More;
use t::Util;

test('use prefork', <<'END', {prefork => 0, 'Test::More' => 0});
use prefork 'Test::More';
END

done_testing;
