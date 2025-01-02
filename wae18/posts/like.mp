
has 'post_id'; 

use Ws24::DBI;

method handle() {
    # Sicherstellen, dass der Benutzer angemeldet ist
    my $user_id = $m->session->{user_id};
    if (!$user_id) {
    return $m->redirect("/wae18/login?msg=Bitte+einloggen+um+liken+zu+können.");
    }

    my $dbh = Ws24::DBI->dbh();

    eval {
        # Likes für den Post um 1 erhöhen
        my $sth = $dbh->prepare("UPDATE group18_posts SET likes = likes + 1 WHERE id = ?");
        $sth->execute($.post_id);
    };

    if ($@) {
        return $m->redirect("/wae18/readPost?post_id=" . $.post_id . "&msg=Fehler beim Liken des Posts.");
    }

    # Weiterleitung zur Post-Ansicht
    return $m->redirect("/wae18/readPost?post_id=" . $.post_id);
}
