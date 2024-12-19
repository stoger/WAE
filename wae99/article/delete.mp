has 'article_id' => (required => 1);

method handle() {
	my $dbh = Ws24::DBI->dbh();
	$dbh->do("DELETE FROM group99_article where article_id=?", undef, $.article_id);
	$m->redirect('/wae99/index');
}
