use strict;
use warnings;

use File::Basename qw/ dirname /;
my $base_dir;
BEGIN { $base_dir = dirname __FILE__ }

use lib "$base_dir/lib";
use local::lib "$base_dir/extlib";

use Plack::Builder;
use Plack::Middleware::Static;
use AXTest;


my $app = AXTest->new;
$app->setup;

builder {
    enable 'Plack::Middleware::Static',
        path => qr{^/static/},
        root => $app->path_to('root')->stringify;

    $app->handler;
};
