$.modal("<%= escape_javascript(render(partial: 'form', locals: {target: @target})) %>",
	overlayId: 'target-overlay',
	containerId: 'target-container'
)
