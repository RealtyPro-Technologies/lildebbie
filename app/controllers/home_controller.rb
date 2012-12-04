class HomeController < ApplicationController
	def index
		if !current_user
			return render 'welcome'
		end
		@my_projects = ProjectDecorator.decorate(current_user.projects)
		@shared_projects = ProjectDecorator.decorate(current_user.shared_projects)
		@invitation = Invitation.new
	end
end