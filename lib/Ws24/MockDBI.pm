package Ws24::DBI;

use strict;
use warnings;

# Mock the dbh method
sub dbh {
    my $class = shift;
    print "Mock Ws24::DBI->dbh() called\n";

    # Return a mocked database handle or similar
    bless {}, $class;
    return Ws24::DBI::MockHandle->new();
}

sub conn {
  my $href = { "conn_details" => "mock conn-test" };
  return $href;
}
  
sub session_conn {
  my $href = { "conn_details" => "mock sconn-test" };
  return $href;
}

{
  # internal class definitions
  package Ws24::DBI::MockHandle;

  sub new {
    my $class = shift;
    return bless {}, $class;
  }

  sub prepare {
    print "Mock prepare called\n";
    return Ws24::DBI::MockStatement->new();
  }
}

{
  package Ws24::DBI::MockStatement;

  sub new {
    my $class = shift;
    return bless {}, $class;
  }

  sub execute {
    my $expr = shift;

    print "executing $expr\n";
    1;
  }

  sub fetchrow_hashref {
    return undef;
  }
}

1;