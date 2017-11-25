requires 'CPAN::Meta::Prereqs', '2.113640';
requires 'CPAN::Meta::Requirements', '2.113640';
requires 'Exporter', '5.57';
requires 'Module::CPANfile';
requires 'Module::Find';
requires 'Regexp::Trie';
requires 'parent';
requires 'perl', '5.008001';
recommends 'Data::Dump';
suggests 'JSON::PP';
suggests 'Module::CoreList', '2.99';

on configure => sub {
    requires 'ExtUtils::MakeMaker::CPANfile', '0.06';
};

on test => sub {
    requires 'Test::More', '0.98';
    requires 'Test::UseAllModules', '0.17';
};

on develop => sub {
    requires 'Archive::Any::Lite';
    requires 'CPAN::DistnameInfo';
    requires 'Data::Dump';
    requires 'Exporter', '5.57';
    requires 'JSON::XS';
    requires 'Log::Handler';
    requires 'Module::ExtractUse';
    requires 'Package::Abbreviate';
    requires 'Path::Tiny';
    requires 'Perl::PrereqScanner';
    requires 'Test::More', '0.88';
    requires 'Time::Piece';
    suggests 'Perl::PrereqScanner::Lite';
    suggests 'Test::Pod', '1.18';
};
