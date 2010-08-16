package AXTest::Controller::Xslate;
use Ark 'Controller';


sub index :Path :Args(0) {
    my ($self, $c) = @_;
    require Text::Xslate;

    $c->stash->{books} = {
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

    $c->stash->{html} = Text::Xslate::mark_raw(
        '<span style="color:red;">colored</span>'
    );
}

sub end :Private
{
    my ($self, $c) = @_;

    unless ($c->res->body || $c->res->status =~ /^3\d{2}$/) {
        $c->forward( $c->view('Tiffany::Xslate') );
    }
}

1;
