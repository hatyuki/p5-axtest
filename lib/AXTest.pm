package AXTest;
use Ark;
our $VERSION = '0.01';

use_model 'AXTest::Models';
my $home = AXTest::Models->get('home');


config 'View::Xslate' => {
    path => [ $home->subdir('root', 'tmpl') ],
};

config 'View::Tiffany::Xslate' => {
    view      => 'Text::Xslate',
    extension => '.tx',
    options   => {
        path      => $home->subdir('root', 'tmpl'),
        cache_dir => $home->subdir('tmp', 'xslate_cache'),
    },
};

config 'View::Tiffany::MT' => {
    view    => 'Text::MicroTemplate::Extended',
    options => {
        include_path => [ $home->subdir('root', 'tmpl') ],
        extension => '',
        template_args => {
            c     => sub { __PACKAGE__->context },
            s     => sub { __PACKAGE__->context->stash },
            stash => sub { __PACKAGE__->context->stash },
        },
        macro => {
            dump => sub {
                require Data::Dumper;
                local $Data::Dumper::Terse = 1;
                Data::Dumper::Dumper(@_);
            },
        },
    },
};


1;
