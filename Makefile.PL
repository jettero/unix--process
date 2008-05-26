# vi:set syntax=perl:

use ExtUtils::MakeMaker;

my $ps = $ENV{PS_PATH} || "/bin/ps";

unless( -x $ps ) {
    warn "this module assumes you have a ps program in /bin/ps\n";
    warn "you can override it by setting an environment variable,\n";
    warn "  e.g. PS_PATH=/usr/local/bin/ps; export PS_PATH\n";
    exit 0;
}

WriteMakefile(
    'NAME'	      	=> 'Unix::Process',
    'VERSION_FROM'	=> 'Process.pm',
    'PREREQ_PM'     => { 
        'IPC::System::Simple' => 0,
        version               => 0,
    },
);
