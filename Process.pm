package Unix::Process;

# $Id: Process.pm,v 1.9 2003/08/04 13:32:17 jettero Exp $
# vi:fdm=marker fdl=0:

use strict;
use warnings;
use AutoLoader;
use Carp;
use IPC::System::Simple qw(capture);

use version;
our $VERSION    = qv('1.2.1');
our $PS_PROGRAM = $ENV{PS_PATH} || '/bin/ps';
our $AUTOLOAD;

1;

sub AUTOLOAD {
    my $this = shift;
    my $pid  = shift; $pid = $$ unless $pid and int($pid);
    my $sub  = $AUTOLOAD;

    $sub = $1 if $sub =~ m/::(\w+)$/;

    my $result = eval { capture($PS_PROGRAM, '-o', $sub, '-p', $pid) };
    croak $@ if $@;

    return $1 if $result =~ m/[\r\n](.+?)[\r\n]/ms;
    return;
}

__END__
# Below is stub documentation for your module. You better edit it!

=head1 NAME

    Unix::Process Perl extension to get pid info from (/bin/ps).

=head1 SYNOPSIS

  use Unix::Process;

    my $vsz = Unix::Process->vsz($$);
    my $pid = Unix::Process->pid;

=head1 DESCRIPTION

All fields from the ps command can be fetched by calling a function of their
name (see SYNOPSIS).  If the pid is not given as an argument to the function,
$$ (cur pid) is assumed.

BTW, this module is really just a giant AUTOLOAD to interact with the /bin/ps
command.  I suppose I could be talked into doing something real with it some
day.

You can manually set the C<$Unix::Process::PS_PROGRAM = "/opt/bin/ps"> by hand,
or you can set C<$ENV{PS_PATH} = "/usr/local/bin/ps">, but you must somehow 
instruct Unix::Process on the location of ps.  Otherwise, it will guess
C<"/bin/ps">.

=head1 AUTHOR

Paul Miller <paul@cpan.org>

I am using this software in my own projects...  If you find bugs, please
please please let me know. :) Actually, let me know if you find it handy at
all.  Half the fun of releasing this stuff is knowing that people use it.

=head1 COPYRIGHT

Copyright (c) 2007 Paul Miller -- LGPL [attached]

=head1 SEE ALSO

perl(1), ps

=cut
