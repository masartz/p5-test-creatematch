use strict;
use warnings;
use Test::More tests=>2;

use_ok( 'Test::CreateMatch::Simple' );

my $target = 'strict';

my $obj = Test::CreateMatch->new(
    flavor => 'Simple',
    target => $target
);

{ # test for write_file
    my $file = sprintf( '/tmp/%s.txt',time() );

    $obj->_write_file( $file );

    is -f "$file" , 1;
    unlink( "$file" );
}

