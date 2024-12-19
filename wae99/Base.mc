<%flags>
# entspricht inherit => undef aus Mason1
  extends => undef
</%flags>

<%class>
  has 'category_id';
  use Data::Dumper;
</%class>

<%augment wrap>
<!DOCTYPE html>
	<html>
		<& head.mi &>
		<body>
			<& top.mi, category_id => $.category_id &>
% if (my $message = delete($m->session->{message})) {
			<div class="message"><% $message %></div>
% }
<div id="contents">
	<div id="leftcontainer">
% #		<section id="main">
			<% inner() %>
    </section>
			<& side_panel.mi &>
    <div class="clear"></div>
  </div>
</div>
			<& footer.mi &>
			<div>
<% Dumper($$,$conn->{'conn_details'}) %>
<br/>
<% Dumper($$,$sconn->{'conn_details'}) %>
			</div>
		</body>
	</html>
<%init>
  my $conn = Ws24::DBI->conn();
  my $sconn = Ws24::DBI->session_conn();
</%init>
</%augment>
