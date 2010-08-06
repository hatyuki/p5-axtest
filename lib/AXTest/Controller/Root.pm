package AXTest::Controller::Root;
use Ark 'Controller';

has '+namespace' => default => '';

# default 404 handler
sub default :Path :Args {
    my ($self, $c) = @_;

    $c->res->status(404);
    $c->res->body('404 Not Found');
}

sub index :Path :Args(0) {
    my ($self, $c) = @_;

    my $books = {
        "978-0596520106" => {
            name  => "Learning Perl",
            pages => "352",
        },
        "978-0596000271" => {
            name  => "Programming Perl",
            pages => "1092",
        },
        "978-4873114279" => {
            name  => "初めてのPerl 第5版",
            pages => "424"
        },
        "978-4798119175" => {
            name  => "モダンPerl入門",
            pages => "344",
        },
    };

    my $html = '<span style="color:red;">colored</span>';

    $c->stash->{books} = $books;
    $c->stash->{html}  = Text::Xslate::mark_raw($html);
}

sub end :Private
{
    my ($self, $c) = @_;

    unless ($c->res->body || $c->res->status =~ /^3\d{2}$/) {
        $c->forward( $c->view('Xslate') );
    }
}

1;
