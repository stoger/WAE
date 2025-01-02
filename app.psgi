use strict;
use warnings;

use Poet::Script qw($conf $poet);
use Plack::Builder;
# use Plack::Session::Store::Cache;
# use CHI;
use Plack::Session::Store::DBI;


# Load modules configured in server.load_modules
#
$poet->app_class('Server')->load_startup_modules();

builder {

    # Add Plack middleware here
    #
    if ( $conf->is_development ) {
        enable "StackTrace";
        enable "Debug";
    }

    enable "ErrorDocument", map { $_ => $poet->static_path("errors/$_.html") } qw(401 403 404 500);

    if ( $conf->is_live ) {
        enable "HTTPExceptions", rethrow => 0;
    }

    enable "Session",
      store => Plack::Session::Store::DBI->new(
       get_dbh => sub { Ws24::DBI->session_dbh }
      );
      # store => Plack::Session::Store::Cache->new(
      #   cache => CHI->new(driver => "Memory", global => 1)
      # );

    enable "Plack::Middleware::Static", path => sub {s!/wae18/static!static/!}, root => "comps/wae18";
    enable "Plack::Middleware::Static", path => sub {s!/wae99/static!static/!}, root => "comps/wae99";
    enable "Plack::Middleware::Static", path => sub {s!/static!!}, root => "static/";
    
    sub {
        my $psgi_env = shift;

        if ($psgi_env->{PATH_INFO} =~ m{/$}) {
          $psgi_env->{PATH_INFO} = substr $psgi_env->{PATH_INFO}, 0, -1;
        }

        $poet->app_class('Mason')->handle_psgi($psgi_env);
    };
}; 