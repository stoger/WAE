use strict;
use warnings;
use Mason;

# Initialisiere Mason mit dem Pfad zu deinen Komponenten
my $mason = Mason->new(comp_root => '/app');

# Plack-App (Webserver)
return sub {
    my $env = shift;

    # Beispiel: Render die Startseite (index.mc)
    return [
        200,
        ['Content-Type' => 'text/html'],
        [$mason->run('/index')],
    ];
};
