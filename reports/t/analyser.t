use strict;
use warnings;
use Test::More;

use FindBin;
use DateTime;
use Path::Class;
use DateTime;
use DateTime::Duration;
use DateTime::Format::Mail;

use TPF::SoC;

my $students_list = dir($FindBin::Bin)->parent->file('students');

my $c = TPF::SoC->new({
    students_fh            => $students_list->openr,
    reports_fh             => \*DATA,
    reporting_period_start => DateTime->new(
        year      => 2011,
        month     => 5,
        day       => 23,
        time_zone => 'UTC',
    ),
    reporting_period_end => DateTime->new(
        year      => 2011,
        month     => 8,
        day       => 22,
        time_zone => 'UTC',
    ),
    reporting_interval => DateTime::Duration->new(weeks => 1),
    analysis_time      => DateTime::Format::Mail->parse_datetime('Fri, 03 Jun 2011 02:39:45 +0200'),
});

$c->report_analyser->analyse(
    @{ $c->student_reports->{$_} }
) for keys %{ $c->students };

#diag explain [map { $c->student_reports->{$_} } keys %{ $c->students }];

done_testing;

__DATA__
# Even though this is based on the actual data as of June 3, this is fake data
# to trigger some corner cases

| marcg       | Tue, 17 May 2011 00:29:57 -0400 | http://groups.google.com/group/tpf-gsoc-students/browse_thread/thread/ce20c2a82d81baae# |
| gnusosa     | Tue, 24 May 2011 10:28:31 -0700 | http://groups.google.com/group/tpf-gsoc-students/browse_thread/thread/dd1407956d333e95# |
| marcg       | Thu, 26 May 2011 17:52:15 -0400 | http://groups.google.com/group/tpf-gsoc-students/browse_thread/thread/665d16ad938721c2# |
| andrewalker | Sat, 28 May 2011 11:44:30 -0300 | http://groups.google.com/group/tpf-gsoc-students/browse_thread/thread/feadee4d20b87a29# |
| Hugmeir     | Tue, 24 May 2011 15:52:56 -0300 | http://groups.google.com/group/tpf-gsoc-students/browse_thread/thread/8a709f906be321d5# |
| mo          | Mon, 30 May 2011 10:46:55 +0200 | http://groups.google.com/group/tpf-gsoc-students/browse_thread/thread/571df8d546362d85# |
| tadzik      | Mon, 30 May 2011 14:51:46 +0200 | http://groups.google.com/group/tpf-gsoc-students/browse_thread/thread/a63f7c9eddf12dd2# |
| Hugmeir     | Mon, 30 May 2011 18:12:35 -0300 | http://groups.google.com/group/tpf-gsoc-students/browse_thread/thread/50e6c5eae3752e75# |
| gnusosa     | Tue, 31 May 2011 01:23:13 -0700 | http://groups.google.com/group/tpf-gsoc-students/browse_thread/thread/d7f9828554e1cdfe# |
| tadzik      | Tue, 31 May 2011 22:52:40 +0200 | http://groups.google.com/group/tpf-gsoc-students/browse_thread/thread/3322531de06de289# |
| andrewalker | Thu, 02 Jun 2011 17:48:46 -0300 | http://groups.google.com/group/tpf-gsoc-students/browse_thread/thread/feadee4d20b87a29# |

# Local Variables:
# mode: org
# End:
