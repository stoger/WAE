has 'username';
has 'password';

use Ws24::DBI;
use Digest::SHA qw(sha512_hex);

method handle() {
  if (not defined $.username || not defined $.password) {
	  return $m->redirect("/wae18/login?msg=Invalid+username+or+password");
  }

  my $conn = Ws24::DBI->dbh();
  my $result = $conn->selectrow_hashref("SELECT id, password FROM group18_user WHERE username = ?;", {}, $.username);
  if (not defined $result) {
	  return $m->redirect("/wae18/login?msg=Invalid+username+or+password");
  }

  my @parts = split(/\$/, $result->{password});
  my $salted = pop(@parts);

  my $new_salted = join('', @parts) . $.password;
  my $hashed = sha512_hex($new_salted);

  if ($hashed eq $salted) {
	$m->session->{user_id} = $result->{id};	
	return $m->redirect("/wae18/");
  }

  return $m->redirect("/wae18/login?msg=Invalid+username+or+password");
}
