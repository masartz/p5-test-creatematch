package Test::CreateMatch;

use strict;
use warnings;
our $VERSION = '0.01';

use Carp;
use Class::Inspector;
use UNIVERSAL::require;

sub run{
    my $class = shift;

    my $flavor = $class->new( @_ );

    $flavor->check_target();

    $flavor->create_test();
}

sub new{
    my $class = shift;
    my %args  = @_;

    my $path  = delete $args{flavor};
    my $flavor = sprintf('%s::%s',$class , $path);
    $flavor->require or croak 'flavor module is not found';

    my $self = { %args };

    return bless $self , $flavor;
}

sub check_target{
    my $self = shift;

    $self->{target}->require or croak;

    return 1;
}

sub get_method_list{
    my $self = shift;

    my @ret_list;
    for my $m ( @{ Class::Inspector->functions($self->{target}) } ){
        push @ret_list , $m;
    }
    return \@ret_list;
}

1;

__END__

=head1 NAME

Test::CreateMatch - creating target Name Space's Module test file

=head1 SYNOPSIS

  use Test::CreateMatch;

=head1 DESCRIPTION

Test::CreateMatch is

=head1 AUTHOR

Masartz E<lt>masartz {at} gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
