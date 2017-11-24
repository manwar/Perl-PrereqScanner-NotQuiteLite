use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../../";
use Test::More;
use t::Util;

test_cpanfile('no cpanfile', sub {
  my $tmpdir = shift;
  my $tmpfile = "$tmpdir/MyTest.pm";

  test_file("$tmpdir/MyTest.pm", <<'END');
use strict;
use warnings;
END
}, {}, <<'CPANFILE');
requires 'strict';
requires 'warnings';
CPANFILE

test_cpanfile('existing cpanfile', sub {
  my $tmpdir = shift;
  my $tmpfile = "$tmpdir/MyTest.pm";

  test_file("$tmpdir/MyTest.pm", <<'END');
use strict;
use warnings;
END

  test_file("$tmpdir/cpanfile", <<'END');
requires 'strict';
requires 'warnings';
END
}, {}, <<'CPANFILE');
requires 'strict';
requires 'warnings';
CPANFILE

test_cpanfile('cpanfile with extra requirements', sub {
  my $tmpdir = shift;
  my $tmpfile = "$tmpdir/MyTest.pm";

  test_file("$tmpdir/MyTest.pm", <<'END');
use strict;
use warnings;
END

  test_file("$tmpdir/cpanfile", <<'END');
requires 'strict';
requires 'warnings';
requires 'Something::Else';
END
}, {}, <<'CPANFILE');
requires 'Something::Else';
requires 'strict';
requires 'warnings';
CPANFILE

test_cpanfile('cpanfile with features', sub {
  my $tmpdir = shift;
  my $tmpfile = "$tmpdir/MyTest.pm";

  test_file("$tmpdir/MyTest.pm", <<'END');
use strict;
use warnings;
END

  test_file("$tmpdir/cpanfile", <<'END');
requires 'strict';
requires 'warnings';

feature 'foo', 'foo', sub {
  requires 'Something::Else';
};
END
}, {}, <<'CPANFILE');
requires 'strict';
requires 'warnings';
feature 'foo', 'foo' => sub {
    requires 'Something::Else';
};
CPANFILE

test_cpanfile('new feature', sub {
  my $tmpdir = shift;
  my $tmpfile = "$tmpdir/MyTest.pm";

  test_file("$tmpdir/MyTest.pm", <<'END');
use strict;
use warnings;
END
}, {features => 'foo:foo:MyTest.pm'}, <<'CPANFILE');
feature 'foo', 'foo' => sub {
    requires 'strict';
    requires 'warnings';
};
CPANFILE

test_cpanfile('merge feature', sub {
  my $tmpdir = shift;
  my $tmpfile = "$tmpdir/MyTest.pm";

  test_file("$tmpdir/MyTest.pm", <<'END');
use strict;
use warnings;
END

  test_file("$tmpdir/cpanfile", <<'END');
feature 'foo', 'foo', sub {
  requires 'Something::Else';
};
END
}, {features => 'foo:foo:MyTest.pm'}, <<'CPANFILE');
feature 'foo', 'foo' => sub {
    requires 'Something::Else';
    requires 'strict';
    requires 'warnings';
};
CPANFILE

test_cpanfile('x_phase', sub {
  my $tmpdir = shift;
  my $tmpfile = "$tmpdir/MyTest.pm";

  test_file("$tmpdir/MyTest.pm", <<'END');
use strict;
use warnings;
END

  test_file("$tmpdir/cpanfile", <<'END');
on "x_phase" => sub {
  requires 'Xtra';
};

feature 'foo', 'foo', sub {
  requires 'Something::Else';
};
END
}, {features => 'foo:foo:MyTest.pm'}, <<'CPANFILE');
on x_phase => sub {
    requires 'Xtra';
};
feature 'foo', 'foo' => sub {
    requires 'Something::Else';
    requires 'strict';
    requires 'warnings';
};
CPANFILE

done_testing;