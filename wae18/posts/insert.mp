has 'title';
has 'content';
has 'category_id';

use Ws24::DBI;

method handle() {
    # user_id aus Session holen
    my $user_id = $m->session->{user_id};
    if (!$user_id) {
  return $m->redirect("/wae18/login?msg=Bitte+einloggen+um+posten+zu+können.");
}


    my $dbh = Ws24::DBI->dbh();

    # Insert in die DB in einem eval-Block, damit wir Fehler abfangen können
    eval {
        my $sth = $dbh->prepare("
            INSERT INTO group18_posts (title, content, user_id, category_id)
            VALUES (?, ?, ?, ?)
        ");
        $sth->execute($.title, $.content, $user_id, $.category_id);
    };

    # Falls ein Fehler beim Insert auftritt:
    if ($@) {
        my $msg = $m->esc_uri("DB-Fehler: $@");
        return $m->redirect("/wae18/login?msg=$msg");
    }

    return $m->redirect("/wae18/index?msg=Erfolgreich+gepostet!");
}
