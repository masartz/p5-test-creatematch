package Test::CreateMatch::Simple;

use strict;
use warnings;

use base qw/Test::CreateMatch/;
use IO::Prompt;
use Template;

sub create_test{
    my $self = shift;

    my $file = $self->_check_file();
    return if ! $file;

    my $data_yaml = join '' , <DATA> ;

    my $method_list = $self->get_method_list();
    
    my $template = Template->new;
    my $output;
    $template->process(
        \$data_yaml,
        {
            'package' => $self->{target},
            'methods' => $method_list
        },
        \$output
    );
        
    $self->_write_file( $file , $output);
}


sub _write_file{
    my ($self , $file , $output) = @_;

    open my $fh ,"> $file";
    print $fh $output || '';
    close $fh;

    return ;
}

sub _check_file{
    my $self = shift;

    my $target = $self->{target};
    $target =~ s/::/\//g;
    my $file = "$FindBin::Bin/../t/lib/$target.t";
    

    if( -f $file ){
        if( ! $self->{force} ){
            prompt "$file file is already exist.and not force option ON, so exit";
            return;
        }
    }
    return $file;
}

1;

__DATA__
use strict;
use warnings;
use Test::More tests=>2;

{
    use_ok('[% package %]');
    
    my @methods = (
        qw/ [% FOREACH m = methods %][% m %] [% END %]/
    );
    can_ok('[% package %]' , @methods);
}

[% FOREACH m = methods %]
{ # test_[% loop.count | format('%03d') %] for [% m %]{

}
[% END %]

