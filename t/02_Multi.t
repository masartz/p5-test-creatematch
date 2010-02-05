use strict;
use warnings;
use Test::More tests=>3;

use_ok( 'Test::CreateMatch::Multi' );

my $target = 'strict';

my $obj = Test::CreateMatch->new(
    flavor => 'Multi',
    target => $target
);

{ # test for tmpl_output
    my $data = << "__EOF__";
[% package %]
__EOF__

    my $output = $obj->_tmpl_output( $data );

    $data =~ s/\[\% package \%\]/$target/;
    is $output , $data;
}

{ # test for write_file
    my $dir = Path::Class::Dir->new( '/tmp' );

    my $file = time().'.txt';

    $obj->_write_file( $dir , $file );

    is -f "$dir/$file" , 1;
    unlink( "$dir/$file" );
}


