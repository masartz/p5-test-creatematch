package Test::CreateMatch::Multi;

use strict;
use warnings;

use base qw/Test::CreateMatch/;
use IO::Prompt;
use Template;
use Path::Class;
use FindBin::Libs;
use File::Path;
use YAML;


sub create_test{
    my $self = shift;

    my $dir = $self->_check_dir();
    return if ! $dir;

    my $data_yaml = YAML::Load( join '' , <DATA> );

    my $method_list = $self->get_method_list();
    
    # create basic file
    {
        my $output = $self->_tmpl_output( $data_yaml->{basic_template} );
        
        $self->_write_file( $dir , '00_basic.t' , $output);
    }

    # create optional files
    my $cnt = 1;
    for my $method ( @{$method_list} ){
        
        my $output = $self->_tmpl_output( $data_yaml->{optional_template} );
        
        my $file_name = sprintf('%02d_%s.t',$cnt,$method);
        $self->_write_file( $dir , $file_name , $output);
        $cnt++;
    }
}

sub _tmpl_output{
    my ($self , $data) = @_;

    my $template = Template->new;
    my $output;
    $template->process(
        \$data,
        {
            'package' => $self->{target},
        },
        \$output
    );
    return $output;
}

sub _write_file{
    my ($self , $dir , $file_name , $output) = @_;

    my $file = $dir->file( $file_name );
    my $fh = $file->openw;
    $fh->print( $output );

    return ;
}

sub _check_dir{
    my $self = shift;

    my $path = $self->{target};
    $path =~ s/::/\//g;
    
    my $dir = Path::Class::Dir->new( "$FindBin::Bin/../t/lib/$path");

    if( -d $dir ){
        if( ! $self->{force} ){
            prompt "t/lib/$path dir is already exist.and not force option ON, so exit.";
            return;
        }
    }
    else{
        File::Path::make_path( $dir );
    }
    
    return $dir;
}

1;

__DATA__

basic_template: |
  use strict;
  use warnings;

  use Test::More tests=>1;

  use_ok('[% package %]');

optional_template: |
  use strict;
  use warnings;
  #use Test::More tests=>?;
  use [% package %];


