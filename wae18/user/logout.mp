method handle() {
	if (defined $m->session && defined $m->session->{user_id}) {
		$m->session->{user_id} = undef;
	}

	# redirect to landing page
	return $m->redirect("/wae18/")
}
