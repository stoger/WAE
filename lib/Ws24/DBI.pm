package Ws24::DBI;

use strict;
use DBIx::Connector;

my $CONN;
my $SESSION_CONN;

$CONN = DBIx::Connector->new('dbi:mysql:tuv;host=mysqldb;port=3306;dummy=$$', 'root', 'tuv24', {
# $CONN = DBIx::Connector->new('dbi:mysql:tuv;host=127.0.0.1;port=3306;dummy=$$', 'tuv', 'tuv23', {
	RaiseError => 1,
	AutoCommit => 1,
  mysql_ssl => 1
});

my $sth;

$sth = $CONN->dbh->prepare("SELECT current_user() as cu ,connection_id() as ci FROM dual");
$sth->execute();
while (my $hr = $sth->fetchrow_hashref) {
	$CONN->{'conn_details'} = { %$hr, ('established' => time, 'client_process' => $$) };
}

$SESSION_CONN = DBIx::Connector->new('dbi:mysql:sessiondb;host=mysqldb;port=3306;dummy=$$', 'mason', 'njumki', {
#$SESSION_CONN = DBIx::Connector->new('dbi:mysql:sessiondb;host=127.0.0.1;port=3306;dummy=$$', 'mason', 'njumki', {
	RaiseError => 1,
	AutoCommit => 1,
  mysql_ssl => 1
});

$sth = $SESSION_CONN->dbh->prepare("SELECT current_user() as cu,connection_id() as ci FROM dual");
$sth->execute();
while (my $hr = $sth->fetchrow_hashref) {
	$SESSION_CONN->{'conn_details'} = { %$hr, ('established' => time, 'client_process' => $$) };
}

print STDERR $$.'_'.scalar(localtime(time)).'_'.' habe mich zu DB connected, connection_ids sind:'. $CONN->{'conn_details'}->{'ci'}.','.$SESSION_CONN->{'conn_details'}->{'ci'}."\n";

sub conn {
	$CONN
}

sub dbh {
	$CONN->dbh
}

sub session_conn {
	$SESSION_CONN
}

sub session_dbh {
	$SESSION_CONN->dbh
}

1;
