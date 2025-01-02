<%class>
 #has 'username';
 #has 'password';
 has 'msg';
</%class>
% if (defined $.msg) {
 <p><% $.msg %></p>
% }

<form action="user/auth" method="POST" class="login-form">
	<div class="login-container" name="login-container">
		<div class="flex-input">
			<label for="username" id="ulabel-login">Name</label>
			<input name="username" type="text" id="name-input-login" />
		</div>

		<div class="flex-input">
			<label for="password" id="plabel-login">Password</label>
			<input name="password" type="password" id="password-input-login" />
		</div>

		<div class="flex-button">
			<button type="submit" class="btn">Login</button>
		</div>
		<div class="flex-item">
			<span class="text-small">No account yet?&nbsp;<a href="/wae18/register">Register here!</a></span>
		</div>
	</div>
</form>

<script>
<!-- validate user input -->
$().ready(function() {
	$("form").validate({
		rules: {
			username: "required",
			password: {
				required: true,
				minlength: 4
			}	
		},
		messages: {
			username: "Please enter a username",
			password: {
				required: "Please enter a password",
				minlength: "Password must be at least 4 characters long"
			}
		}
	});
});
</script>

<%init>
# if user already logged in, redirect
if (defined $m->session->{user_id} && $m->session->{user_id} > 0) {
	return $m->redirect("/wae18/");
}
</%init>
