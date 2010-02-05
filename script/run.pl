#!/usr/bin/env perl

use strict;
use warnings;

use Pod::Usage;
use Getopt::Long;

use FindBin;
use lib "$FindBin::Bin/../../lib";

use Test::CreateMatch;

my %args = (
    target => '',
    flavor => '',
    force  => 0,
);

GetOptions(
    'target=s'  => \$args{target},
    'flavor=s'  => \$args{flavor},
    'force=i'   => \$args{force},
) or pod2usage();

Test::CreateMatch->run(%args);


__END__

=head1 NAME

Test::CreateMatch run.pl - creating test file

=head1 SYNOPSIS

 $ perl run.pl [ --flavor=(Single|Multi) ] [ --target=MyApp::Hoge::Moge][ --force=(0|1) ]

=head1 DESCRIPTION

=cut
