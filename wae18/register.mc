<%class>
 has 'msg';
</%class>

% if (defined $.msg) {
 <p><% $.msg %></p>
% }

<form action="user/register" method="POST" class="login-form">
	<div class="register-container" name="register-container">
		<div class="flex-input">
			<label for="username" id="ulabel-register">Name</label>
			<input name="username" type="text" id="name-input-register" />
		</div>
		
		<div class="flex-input">
			<label for="password" id="plabel-register">Password</label>
			<input name="password" type="password" id="password-input-register" />
		</div>
		
		<div class="flex-input">
			<label for="password_retype" id="p2label-register">Confirm Password</label>
			<input name="password_retype" type="password" id="password-retype-input-register" />
		</div>

		<div class="flex-button">
			<button type="submit" class="btn">Register</button>
		</div>
		<div class="flex-item">
			<span class="text-small">Got an account?&nbsp;<a href="/wae18/login">Login instead!</a></span>
		</div>
	</div>
</form>

<script>
<!-- validate user input -->
function uname_trimmed() {
	return $("input[name='username']").val().trim().length > 0;
}

$().ready(function() {
	$("#name-input-register").on("change", function(x) {
		console.log(x);
		x.currentTarget.value = x.currentTarget.value.trim();
	});

	$("form").validate({
		rules: {
			username: {
				required: uname_trimmed
			},
			password: {
				required: true,
				minlength: 4
			},
			password_retype: {
				equalTo: "#password-input-register"
			}	
		},
		messages: {
			username: {
				required: "Please enter a username"
			},
			password: {
				required: "Please enter a password",
				minlength: "Password must be at least 4 characters long"
			},
			password_retype: {
				equalTo: "Passwords do not match"
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
