use strict;
use warnings;

use Poet::Script qw($conf $poet);
use Plack::Builder;
# use Plack::Session::Store::Cache;
# use CHI;
use Plack::Session::Store::DBI;


# Load modules configured in server.load_modules
# Don't edit
$poet->app_class('Server')->load_startup_modules();

builder {
    
    # Add Plack middleware here
    # default conf start - DO NOT EDIT
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
      )
    ;
    # end default conf

    # handle static files for any sub-project (group-related ones like wae99)
    enable "Plack::Middleware::Static", path => sub {s!/(wae\d+)/static!comps/$1/static!}, root => ".";
    # serve default-static files (like ckeditor specifics)
    enable "Plack::Middleware::Static", path => sub {s!/static!static!}, root => ".";
    
    sub {
        my $psgi_env = shift;

        # not sure why this is needed, but otherwise e.g. `/wae99` won't load css & `/wae99/` won't load index.mc
        if ($psgi_env->{PATH_INFO} =~ m{/$}) {
          $psgi_env->{PATH_INFO} = substr $psgi_env->{PATH_INFO}, 0, -1;
        }

        $poet->app_class('Mason')->handle_psgi($psgi_env);
    };
}; 