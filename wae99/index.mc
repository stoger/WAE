<%class>
  has 'category_id';
  has 'search';
</%class>

<!-- <div id="contents">
	<div id="leftcontainer">
-->
		<section id="main">
			<& featured.mi &>
% # push(@{$m->session->{comp}}, { 'path' => $.cmeta->path, 'access_time' => time });
			<h2 class="mainheading">Latest from the blog</h2>
			<& newsList.mi, category_id => $.category_id, search => $.search &>
