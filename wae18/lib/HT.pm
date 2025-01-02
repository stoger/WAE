package HT;

use Digest::SHA qw(sha512_hex);

sub enc {
  my $plain_pw = shift;

  print "encrypting '" . $plain_pw . "'<br>";

  return sha512_hex($plain_pw);
}

sub v {
  my ($plain_pw, $enc_pw) = shift;

  print "got plain '" . $plain_pw . "' and enc '" . $enc_pw . "'<br>";
  return sha512_hex($plain_pw) eq $enc_pw;
}

1;
