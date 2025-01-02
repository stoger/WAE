<%class>
    has 'post_id'  => (required => 1);
    has 'user';
</%class>

<link rel="stylesheet" type="text/css" media="screen" href="static/css/readPost.css">
  <section id="main">
   
    <div id="readPost-container">
    <div id="title-container">
% if (@posts) {
% if (defined $m->session->{user_id} && $m->session->{user_id} > 0 && $m->session->{user_id} == $posts->{'user_id'}) {
        <div id="button-container">
            <form action="editor" method="GET" style="display:inline;">
                <input type="hidden" name="post_id" value="<% $.post_id %>">
                <button type="submit" class="btn btn-primary">Post Bearbeiten</button>
            </form>
            <form action="posts/delete" method="POST" style="display:inline;" onsubmit="return confirm('Willst du diesen Post wirklich löschen?')">
                <input type="hidden" name="post_id" value="<% $.post_id %>">
                <button type="submit" class="btn btn-secondary">Post Löschen</button>
            </form>
        </div>
% }
        <h2 class="post-title">
            <% $posts->{'title'} %>
            <span class="likes-container">
            <span id="like-count"><% $posts->{'likes'} || 0 %></span>
                <form action="posts/like" method="POST" style="display:inline;">
                    <input type="hidden" name="post_id" value="<% $.post_id %>">
                    <button type="submit" class="like-button">
                        <img src="static/images/like-button.png" alt="Like">
                    </button>
                </form>
                
            </span>
        </h2>
    </div>
    <div id="author-date-container">
        Von <% $posts->{'author_name'} %> <% $posts->{'last_edited'} %> | Kategorie: <% $posts->{'category_name'} %>
    </div>

    <div id="content-container">
        <% $posts->{'content'} %>
    </div>
</div>


% } else {
        <h2>Kein Post mit dieser ID gefunden!</h2>

% }
  </section>
<%init>
    # Fetch Post itself
     my $dbh = Ws24::DBI->dbh();
    my $sth = $dbh->prepare(q{
        SELECT 
            posts.id,
            posts.title,
            posts.content,
            posts.last_edited,
            posts.likes,
            users.username AS author_name,
            categories.name AS category_name
        FROM group18_posts AS posts
        LEFT JOIN group18_user AS users
            ON posts.user_id = users.id
        LEFT JOIN group18_categories AS categories
            ON posts.category_id = categories.id
        WHERE posts.id = ?
    });
    $sth->execute($.post_id);

    my @posts;
    while (my $hr = $sth->fetchrow_hashref) {
        push(@posts, $hr);
    }
    my $posts = $posts[0];

</%init>
