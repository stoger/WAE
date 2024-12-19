use strict;
use warnings;
use Mason;

# Initialisiere Mason
my $mason = Mason->new(comp_root => '/app');  # Prüfe, ob /app stimmt

return sub {
    my $env = shift;

    return [204, [], []] if $env->{PATH_INFO} eq '/favicon.ico';

    my $result = $mason->run($env->{PATH_INFO});

    return [
        200,
        ['Content-Type' => 'text/html'],
        [$result->output], # Hier nutzen wir nun ->output
    ];
};
