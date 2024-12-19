<%class>
 has 'article_id';
</%class>

<div id="contents">
	<div id="leftcontainer">

% if ($.article_id) {
% if ($flag==1) {

		<h2>Edit article n°<% $article->{'article_id'} %>: <em><% $article->{'title'} %></em></h2>
		<section id="main">
			<article class="post">
				<form id="insertform" action="article/update" method="post" class="form">
   				<p class="textfield">
	          <label for="title">Title (required)</label>
          	<input type="text" name="title" id="title" required="required" tabindex="4" value="<% $article->{'title'} %>">
					</p>
					<p>
						<label for="category">Category</label><br>
						<select name="category" autofocus id="combobox">
							<option></option>
% foreach my $category (@categories) {

%  if ($category->{'category_id'} ==  $article->{'category_id'}){
							<option value="<% $category->{'category_id'} %>" selected='selected'><% $category->{'title'} %></option>
%	}
% else{
							<option value="<% $category->{'category_id'} %>"><% $category->{'title'} %></option>
%	}
% }
						</select><br>
   				</p>
					<p>
						<label for="excerpt">Excerpt</label>
						<textarea name="excerpt" required="required" id="excerpt" cols="71" rows="3" tabindex="4"><% $article->{'excerpt'} %></textarea>
   				</p><br><br>
					<p>
						<textarea name="textarea" id="textarea"><% $article->{'content'} %></textarea>
					</p>

<script>
	// Replace the <textarea id="textarea"> with a CKEditor
	// instance, using default configuration.

	CKEDITOR.replace('textarea',{
		width   : '560px',
		height  : '400px'
	});
</script>
					<p>
						<input name="submit" id="submit" tabindex="5" type="image" src="static/images/submit.png">
						<input name="comment_post_ID" value="1" type="hidden">
						<input name="article_id" value="<% $article->{'article_id'} %>" type="hidden">
					</p>
					<div class="clear"></div>
				</form>
				<!--Important--><div class="clear"></div>
			</article>
	</section>
% }
% else{
	<h2>You do not own the rights of this article!</h2>
% }
% }
% else {
% if (defined $m->session->{user_id} && $m->session->{user_id} > 0) {
<section id= "main">
	<article class="post">
		<h2>Insert article</h2>
% $.FillInForm($form_data) {{
		<form id="insertform" action="/article/insert" method="post" class="form">
			<p class="textfield">
				<label for="title">Title (required)</label>
				<input type="text" name="title" id="title" tabindex="4" required="required">
			</p>
			<p>
				<label for="category">Category</label><br>
				<select name="category" autofocus id="combobox" required="required">
% foreach my $category (@categories) {
					<option value="<% $category->{'category_id'} %>"><% $category->{'title'} %></option>
% }
				</select><br><br>
			</p>
			<p>
				<label for="excerpt">Excerpt (max 50 words)</label>
				<textarea name="excerpt" id="excerpt" cols="71" rows="3" tabindex="4"></textarea>
			</p><br><br>
			<p>
				<label for="textarea">Content</label>
				<textarea name="textarea" id="textarea"></textarea>
			</p>

<script>
	// Replace the <textarea id="textarea"> with a CKEditor
	// instance, using default configuration.

	CKEDITOR.replace('textarea',{
		width   : '560px',
		height  : '400px'
	});
</script>
			<p>
				<input name="submit" id="submit" tabindex="5" type="image" src="static/images/submit.png">
				<input name="comment_post_ID" value="1" type="hidden">
			</p>
			<div class="clear"></div>
		</form>
% }}
		<!--Important--><div class="clear"></div>
	</article>
</section>

% }
% else {
</br>
<h2> You need to be logged in to insert an article.</h2>
% }
% }

<script>
  $(function() {
    $( "#combobox" ).combobox();
    $('#title')
      .button()
      .css({
            'font' : 'inherit',
            'color' : 'inherit',
            'text-align' : 'left',
            'outline' : 'none',
            'cursor' : 'text'
    });
    $("#insertform").validate();
  });
</script>

<%init>
	my $form_data = delete($m->session->{form_data});
	my $flag = 0;
	my $dbh = Ws24::DBI->dbh();
	my $sth;

	if (defined ($m->session->{user_id})) {
		if ($.article_id) {
			$sth = $dbh->prepare("SELECT user_id FROM group99_article WHERE article_id=?");
			$sth->execute($.article_id);

			my @users;
			while (my $hr = $sth->fetchrow_hashref) {
				push(@users, $hr);
			}

			my $user_id = $users[0]->{'user_id'};
			if ($user_id == $m->session->{user_id}){
				$flag = 1;
			}
		}
	}

	$sth = $dbh->prepare("SELECT title, category_id FROM group99_category");
	$sth->execute();

  my @categories;
  while (my $hr = $sth->fetchrow_hashref) {
    push(@categories, $hr);
  }

	$sth = $dbh->prepare("SELECT article_id, title, category_id, user_id, excerpt, content, status, timestamp FROM group99_article WHERE article_id=?");
	$sth->execute($.article_id);
	my @articles;
	while (my $hr1 = $sth->fetchrow_hashref) {
		push(@articles, $hr1);
	}
	my $article = $articles[0];
</%init>
