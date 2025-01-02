has 'post_id';
has 'title';
has 'content';
has 'category_id';

use Ws24::DBI;

method handle() {
    # user_id könnte man für Zugriffsprüfung nutzen
    my $user_id = $m->session->{user_id} || 0;

    my $dbh = Ws24::DBI->dbh();

    eval {
        my $sth = $dbh->prepare("
            UPDATE group18_posts
               SET title = ?, 
                   content = ?, 
                   category_id = ?, 
                   last_edited = CURRENT_TIMESTAMP
             WHERE id = ?
        ");
        $sth->execute($.title, $.content, $.category_id, $.post_id);
    };

    if ($@) {
        my $msg = $m->esc_uri("DB-Fehler: $@");
        return $m->redirect("/wae18/login?msg=$msg");
    }

    # Weiterleitung zur Seite readpost mit der entsprechenden post_id
    return $m->redirect("/wae18/readPost?post_id=" . $.post_id);
}
