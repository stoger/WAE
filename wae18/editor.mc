<%class>
  # Mason-Attribute für unser Formular
  has 'post_id';      # wird bei einem bestehenden Post gesetzt
  has 'title';
  has 'content' => (default => "<p>Bitte hier den Inhalt eingeben.</p>\n");
  has 'category_id';

  # Interne Variable für Feedback
  has 'msg' => (default => '');
</%class>

<script>
    function validateForm() {
        const title = document.querySelector('input[name="title"]').value.trim();
        const editorContent = CKEDITOR.instances.content.getData().trim();
        if (title.length === 0) {
            alert("Der Titel darf nicht leer sein.");
            return false; 
        }
        if (editorContent == "<p>Bitte hier den Inhalt eingeben.</p>") {
          alert("Bitte ändern Sie den Text.");
          return false;
        }
        if (editorContent.length === 0) {
          alert("Bitte Text einfügen!");
          return false;
        }
        return true; 
    }
</script>

<head>
  <title>Edit Post</title>
  <link rel="stylesheet" type="text/css" media="screen" href="static/css/editor.css">
</head>

<div class="flex-container">
<h2>
% my $pid = $.post_id || '';
% if ($pid) {
  Post (ID <% $pid %>) bearbeiten
% } else {
  Neuen Post anlegen
% }
</h2>

% if (length($.msg)) {
<p style="color:red;font-size:10px;"><% $.msg %></p>
% }

<form name="editform" method="POST"
  action="<% $.post_id ? 'posts/update' : 'posts/insert' %>"
  enctype="application/x-www-form-urlencoded"
>
  <!-- ID mitgeben, falls vorhanden -->
  <input type="hidden" name="post_id" value="<% $.post_id %>">
<div class="flex-item">
  <table width="100%" cellspacing="1" cellpadding="4" border="0">
    <colgroup>
      <col align="right" valign="top">
      <col align="left">
    </colgroup>

    <!-- Titel -->
    <tr>
      <td><b>Titel:</b></td>
      <td>
        <input type="text" name="title" value="<% $.title %>" size="50" />
      </td>
    </tr>

    <!-- Kategorie-Auswahl (Dropdown) -->
    <tr>
      <td>Kategorie:</td>
      <td>
        <% $cgi->popup_menu(
          -name    => 'category_id',
          -values  => [ sort {$a <=> $b} keys %categories ],
          -default => $.category_id,
          -labels  => \%categories
        ) %>
      </td>
    </tr>

    <!-- Content -->
    <tr>
      <td colspan="2">
    <div class="editor-wrapper">
        <textarea name="content" id="content"><% $.content %></textarea>
        <script>
            CKEDITOR.replace('content', {
              toolbar: [
                  { name: 'basicstyles', items: ['Bold', 'Italic', 'Underline', 'Strike'] },
                  { name: 'paragraph', items: ['Format', 'Styles'] },
                  { name: 'insert', items: ['Image'] }
              ],
              uiColor: '#E3F2FD',
              height: 480,
              width: '100%',
              contentsCss: '/static/css/editor-content.css' // Pfad zur CSS-Datei
            });
        </script>
    </div>
</td>
    </tr>
    <!-- Absende-Buttons -->
    <tr>
      <td colspan="2">
        <br>
        <button type="submit" name="Save" class="btn btn-primary" onclick="return validateForm();">Speichern</button>
        &nbsp;&nbsp;&nbsp;
        <button type="button" name="Cancel" class="btn btn-secondary" onclick="history.back();">Verwerfen</button>
        <br><br>
      </td>
    </tr>
  </table>
</div>
</form>

</div>
<%init>
# if user not logged in, cannot create/edit blog
unless (defined $m->session && $m->session->{user_id} > 0) {
    my $msg = "Sie müssen eingeloggt sein, um posten zu können.";
    return $m->redirect("/wae18/login?msg=$msg");
}

use CGI;
my $cgi = CGI->new;
my $dbh = Ws24::DBI->dbh();

# 1) Kategorien für Dropdown laden
my %categories;
{
  my $sth = $dbh->prepare("SELECT id, name FROM group18_categories");
  $sth->execute();
  while (my $row = $sth->fetchrow_hashref) {
    $categories{$row->{id}} = $row->{name};
  }
}

# 2) Wenn post_id übergeben wurde => Post aus DB lesen
if ($.post_id) {
  my $sth = $dbh->prepare(
    "SELECT id, title, content, category_id
     FROM group18_posts
     WHERE id = ?"
  );
  $sth->execute($.post_id);
  my $res = $sth->fetchrow_hashref();
  if ($res) {
    $.title($res->{title});
    $.content($res->{content});
    $.category_id($res->{category_id});
    #$.msg("Post $res->{id} wurde aus DB gelesen.");
  } else {
    #$.msg("Post mit ID $.post_id nicht gefunden.");
  }
} else {
  # Kein post_id
  #$.msg("Neuer Post (ID wird automatisch vergeben) kann jetzt angelegt werden.");
}
</%init>
