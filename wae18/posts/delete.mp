has 'post_id';

use Ws24::DBI;

method handle() {
    my $user_id = $m->session->{user_id} || 0;

    my $dbh = Ws24::DBI->dbh();

    eval {
        my $sth = $dbh->prepare("DELETE FROM group18_posts WHERE id = ?");
        $sth->execute($.post_id);
    };

    if ($@) {
        my $msg = $m->esc_uri("DB-Fehler: $@");
        return $m->redirect("/wae18/login?msg=$msg");
    }

    # Weiterleitung zur Startseite nach dem Löschen
    return $m->redirect("/wae18/index?msg=Post erfolgreich gelöscht");
}
