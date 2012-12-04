class ProjectGrantsController < ApplicationController
	before_filter :authenticate_user!

	def create
		@project = ProjectDecorator.find(params[:username], params[:projectname])
		@user = User.where(username: params[:project_grant][:user]).first
		if @user
			@grant = @project.project_grants.new
			@grant.user = @user
			@grant.save
			@grant = ProjectGrantDecorator.decorate(@grant)
		end
	end

	def update

	end

	def destroy

	end
end