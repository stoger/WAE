package MyLib::HTool;

use strict;
use warnings;
use Digest::SHA qw(sha512_hex);

sub enc {
  my $plain_pw = shift;

  #$handle->reset();
  # TODO: add salting
  
  #$handle->add($plain_pw);
  #
  #return $handle->hexdigest;
  return sha512_hex($plain_pw);
}

sub ver {
  my ($user, $plain_pw) = @_;
  print "verifying " . $plain_pw . " for " . $user;
  return 1;
}

1;
