has 'filter';

use Ws24::DBI;
use JSON; # qw(encode_json);
use Data::Dumper;
use Encode;


method handle() {
    my $bool_adds = defined $.filter && $.filter =~ m{^(?:\d+,)*?\d+$};

    my $stmt = qq{
        SELECT 
            posts.id,
            posts.title,
            posts.content,
            posts.last_edited,
            users.username,
            categories.name AS categoryname
        FROM group18_posts AS posts
        LEFT JOIN group18_user AS users
            ON posts.user_id = users.id
        LEFT JOIN group18_categories AS categories
            ON posts.category_id = categories.id
    };

    # WHERE-Bedingungen hinzufügen, falls nötig
    my @items = ();
    if ($bool_adds) {
        @items = split(/,/, $.filter);
        my $itemslen = scalar @items;
        $stmt .= " WHERE posts.category_id IN (". join(",", ("?") x $itemslen) . ")";
    } 
    $stmt .= " ORDER BY posts.last_edited DESC;"; # Optional: Sortierung hinzufügen

    my $dbh = Ws24::DBI->dbh();
    my $sth = $dbh->prepare($stmt);

    if ($bool_adds) {
        $sth->execute(@items);
    } else {
        $sth->execute();
    }


    my @results;
    while (my $x = $sth->fetchrow_hashref) {
        $x->{categoryname} = decode("utf8", $x->{categoryname});
        $x->{title} = decode("utf8", $x->{title});
        $x->{username} = decode("utf8", $x->{username});
        $x->{content} = decode("utf8", $x->{content});
        push(@results, $x);
    }

    # prepare response
    $m->clear_buffer();
    
    my $encoded = (JSON->new->utf8)->encode(\@results);

    #print Dumper($m->res);
    #$r->content_type('application/json; charset=UTF-8');

    #print Dumper(\@results);
    #print encode_json(\@results);
    #binmode(STDOUT, ":utf8");
    #print $encoded;

    #print Dumper($encoded);
    #return $res->finalize;
    $m->print($encoded);
    $m->res->content_type("application/json; charset=UTF-8");
    $m->abort();
    #$m->send_json(\@results);
}