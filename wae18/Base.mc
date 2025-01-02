<%class>
has 'grp' => (default => ($m->request_path() =~ /wae(\d+)/)?(0+$1):'?');
has 'maintitle' => (default => '2Blog');
</%class>

<%augment wrap>
  <html>
    <head>
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <!-- CSS -->
      <link rel="stylesheet" type="text/css" media="screen" href="static/css/style.css">
      <link rel="stylesheet" type="text/css" media="screen" href="static/css/btn.css">
      <link rel="stylesheet" type="text/css" media="screen" href="static/css/header.css">
      <link rel="stylesheet" type="text/css" media="screen" href="static/css/md-chips.css">
      
      <!-- favicon -->
      <link rel="icon" type="image/x-icon" href="static/images/favicon.ico">

      <!-- scripts -->
      <script src="/static/js/ckeditor/ckeditor.js" type="text/javascript"></script>
      <script src="static/js/jquery.min.js" type="text/javascript"></script>
      <script src="static/js/jquery.validate.min.js" type="text/javascript"></script>
% $.Defer {{
      <title><% $.maintitle %> | Grp <% $.grp %></title>
% }}
    </head>
    <body>
      <div class="flex-header">
      	<& header.mi, authed => (defined $m->session && $m->session->{user_id} != 0) &>
      </div>
      <div class="flex-body growable">
        <% inner() %>
      </div>
      <div class="flex-footer">
        <& footer.mi, grp => $.grp &>
      </div>
    </body>
  </html>
</%augment>

<%flags>
extends => undef
</%flags>
