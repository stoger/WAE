<%class>
    has 'msg';
</%class>

% if (defined $.msg) {
 <p><% $.msg %></p>
% }

<& category_list.mi, categories => \@categories, cb_url => "/wae18/categories/get_json" &>
<& post_list.mi, user => $uid, cid => $cid &>

<%init>
    # logged in user id & category id (if passed) [maybe control category id via javascript/jquery instead]
    my $uid = (defined $m->session && $m->session->{user_id} > 0) ? $m->session->{user_id} : 0;
    my $cid = (defined $m->req && defined $m->req->param('category_id')) ? $m->req->param('category_id') : 0;
	
    my $dbh = Ws24::DBI->dbh();
	my $sth = $dbh->prepare("SELECT id, name from group18_categories;");
	$sth->execute();
    my @categories;
    while (my $hr = $sth->fetchrow_hashref) {
        push(@categories, $hr);
    }
</%init>
