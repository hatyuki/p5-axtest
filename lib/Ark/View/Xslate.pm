package Ark::View::Xslate;
use Ark 'View';
use Text::Xslate ( );

has path => (
    is      => 'rw',
    isa     => 'ArrayRef',
    lazy    => 1,
    default => sub { [ shift->path_to('root')->stringify ] },
);

has cache => (
    is      => 'rw',
    isa     => 'Int',
    lazy    => 1,
    default => 1,
);

has cache_dir => (
    is      => 'rw',
    isa     => 'Str',
    lazy    => 1,
    default => sub { shift->path_to('tmp')->stringify },
);

has function => (
    is      => 'rw',
    isa     => 'HashRef',
    lazy    => 1,
    default => sub { +{ } },
);

has module => (
    is      => 'rw',
    isa     => 'ArrayRef',
    lazy    => 1,
    default => sub { [ ] },
);

has input_layer => (
    is      => 'rw',
    isa     => 'Str',
    lazy    => 1,
    default => ':utf8',
);

has suffix => (
    is      => 'rw',
    isa     => 'Str',
    lazy    => 1,
    default => '.tx',
);

has syntax => (
    is      => 'rw',
    isa     => 'Str',
    lazy    => 1,
    default => 'Kolon',
);

has options => (
    is      => 'rw',
    isa     => 'HashRef',
    lazy    => 1,
    default => sub { {} },
);

has xslate => (
    is      => 'rw',
    isa     => 'Text::Xslate',
    builder => '_build_xslate',
    lazy    => 1,
);

sub _build_xslate
{
    my $self  = shift;
    my $c     = sub { $self->context };
    my $stash = sub { $self->context->stash };

    Text::Xslate->new(
        path        => $self->path,
        cache       => $self->cache,
        cache_dir   => $self->cache_dir,
        function    => $self->function,
        module      => $self->module,
        input_layer => $self->input_layer,
        suffix      => $self->suffix,
        syntax      => $self->syntax,
        %{ $self->options },
    );
}

sub template
{
    my ($self, $template) = @_;
    $self->context->stash->{__view_xslate_template} = $template;
    #$self->xslate->load_file($template.$self->suffix);
    
    return $self;
}

sub render
{
    my $self     = shift;
    my $template = shift;
    my $context  = $self->context;

    $template ||= $self->context->stash->{__view_xslate_template}
              ||  $self->context->request->action->reverse
              ||  return;

    return $self->xslate->render(
        $template.$self->suffix, {
            %{ $context->stash },
            c => $self->context,
            @_,
        }
    );
}

sub process
{
    my ($self, $c) = @_;
    $c->response->body( $self->render );
}


__PACKAGE__->meta->make_immutable;
