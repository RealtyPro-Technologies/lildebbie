class UserDecorator < ApplicationDecorator
	decorates :user
	decorates_association :projects

	def badge(options={})
		h.content_tag :span, class: 'user-badge' do
			if options[:nolink]
				h.gravatar_for(model.email, size: 24) + " #{model.username}"
			else
				h.link_to h.projects_path(model) do
					h.gravatar_for(model.email, size: 24) + " #{model.username}"
				end
			end
		end
	end

	def avatar
		h.gravatar_for(model.email, size: 128, class: 'img-polaroid')
	end
end