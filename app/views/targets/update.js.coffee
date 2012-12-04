$.modal.close()
$('#target_list tr[data-id="<%= @target.id %>"]').replaceWith("<%= escape_javascript(render @target) %>")