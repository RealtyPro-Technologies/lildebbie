class ProjectGrantsController < ApplicationController
	def create
		@project = ProjectDecorator.find(params[:username], params[:projectname])
		@user = User.where(username: params[:project_grant][:user]).first
		if @user
			@grant = @project.project_grants.new
			@grant.user = @user
			@grant.save

			return render json: @grant
		end

		render text: 'error', status: 403
	end

	def update

	end

	def destroy

	end
end