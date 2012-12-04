class TargetsController < ApplicationController
	before_filter :authenticate_user!

	def new
		@project = Project.find(params[:username], params[:projectname])

		@target = @project.targets.new
	end

	def edit
		@project = Project.find(params[:username], params[:projectname])

		@target = Target.find(params[:id])
	end

	def create
		@project = Project.find(params[:username], params[:projectname])

		@target = @project.targets.new(target_params)
		@target.user_id = current_user.id

		if @project.targets.size == 1
			@target.active = true
		end

		@target.save
	end

	def update
		@target = Target.find(params[:id])
		@target.update_attributes(target_params)
	end

	def activate
		@project = Project.find(params[:username], params[:projectname])
		@project.targets.update_all("active = 0")

		@target = Target.find(params[:id])
		@target.active = true
		@target.save
	end

	def destroy
		@target = Target.find(params[:id])
		@target.destroy
	end

	private

	def target_params
		params.required(:target).permit(:url)
	end
end