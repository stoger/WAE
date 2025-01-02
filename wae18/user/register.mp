has 'username';
has 'password';

use Ws24::DBI;
use Digest::SHA qw(sha512_hex);

method handle() {
  if (not defined $.username || not defined $.password) {
	  return $m->redirect("/wae18/register?msg=Please+specify+username+and+password");
  }

  my $conn = Ws24::DBI->dbh();
  my $result = $conn->selectrow_hashref("SELECT id FROM group18_user WHERE username = ?;", {}, $.username);
  if (defined $result) {
	  # abort if user with specified name is already in DB
	  return $m->redirect("/wae18/register?msg=User+already+exists, log in instead");
  }
 
  my $hashed = $.salt_and_hash_password($.password);  

  my $sth = $conn->prepare("INSERT INTO group18_user (username, password) VALUES (?,?);");
  my $cres = $sth->execute($.username, $hashed);

  if ($cres != 1) {
	return $m->redirect("/wae18/register?msg=Could+not+create+user");
  }

  $result = $conn->selectrow_hashref("SELECT id FROM group18_user WHERE username = ?;", {}, $.username);
  $m->session->{user_id} = $result->{id}; 
  return $m->redirect("/wae18/");
}

method salt_and_hash_password() {
	my $pw = shift;
	my $charset = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!\"#%&'()*+,-./:;<=>?@[\]^_`{|}~";

	my @seed = ();
	for my $i (0..2) {
		my $hlp = "";
		for my $x (0..8) {
			$hlp .= substr($charset, rand(length($charset)), 1);	
		}
		push(@seed, $hlp);
	}
	
	my $salted = join('', @seed) . $pw;
	my $hashed = sha512_hex($salted);
	return join('$', @seed, $hashed);
}
