<%class>
	has 'article_id'  => (required => 1);
  has 'user';
  has 'comment';
  has 'comment_id';
</%class>
<!--
<div id="contents">
<div id="leftcontainer">
-->
<section id="main">
% if (@articles){

<h2>
<% $article->{'article_id'} %>. <% $article->{'title'} %>
</h2>

<article class="post">
<header>
% if (defined $m->session->{user_id} && $m->session->{user_id} > 0) {
<a href="insert?article_id=<% $.article_id %>" class="classname">Modify</a>
<a href="article/delete?article_id=<% $.article_id %>" class="classname">Delete</a>

% }
<p class="postinfo"> Published in <b><& fetchCategory.mi, category_id => $article->{'category_id'} &></b> on <% $article->{'timestamp'} %> </p>
</header>

<p>
<% $article->{'content'} %>
<footer>
Written by <& fetchAuthor.mi, user_id => $article->{'user_id'} &>

<span class="comments"><a href="javascript:void(0)" onclick="showComments(<% $article->{'article_id'} %>);"><& countcomments.mi, article_id=>$article->{'article_id'} &> Comment(s)</a></span>
</footer>
<& comments.mi, article_id => $article->{'article_id'} &>
% }
% else {
<h2>Sorry! There are no articles matching with your request.</h2>
% }
</article>

<%init>
	my $dbh = Ws24::DBI->dbh();
	my $sth = $dbh->prepare("SELECT article_id, title, category_id, user_id, excerpt, content, status, timestamp from group99_article where article_id=?");
	$sth->execute($.article_id);

  my @articles;
  while (my $hr = $sth->fetchrow_hashref) {
    push(@articles, $hr);
  }
  my $article = $articles[0];

  if ($.user && $.comment) {
  	$sth = $dbh->prepare("INSERT INTO group99_comment (article_id, user, comment) VALUES (?,?,?)");
  	$sth->execute($.article_id, $.user, $.comment);
  }

  if ($.comment_id && $m->session->{user_id} > 0) {
  	$dbh->do(q{DELETE FROM group99_comment WHERE comment_id = ?}, undef, $.comment_id) or die $dbh->errstr;
  }
</%init>
