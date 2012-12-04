$('.btn.cancel').live 'click', (e) ->
	$.modal.close()
	e.preventDefault()
	false