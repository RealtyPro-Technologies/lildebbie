<% if @needs_reload %>
	window.location.replace("<%= project_path(@project.user, @project) %>")
<% end %>