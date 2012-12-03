class ProjectsController < ApplicationController
	def index
		@user = UserDecorator.decorate(User.where(:username => params[:username]).first)
		@projects = ProjectDecorator.decorate(@user.projects)
	end

	def show
		@project = ProjectDecorator.find(params[:username], params[:projectname])
		
		unless @project.present?
			raise ActionController::RoutingError.new('Not Found')
		end
	end

	def admin
		@project = ProjectDecorator.find(params[:username], params[:projectname])
		@new_grant = ProjectGrant.new
	end

	def new
		@project = current_user.projects.new
	end

	def create
		@project = current_user.projects.create(project_params)

		if @project
			redirect_to project_path(current_user, @project)
		else
			render 'new'
		end
	end

	def update
		@project = Project.find(params[:username], params[:projectname])

		@needs_reload = project_params[:name] != params[:projectname]
		if @project.update_attributes(project_params)
		else
			render json: @project.errors, status_code: 403
		end
	end

	private

	def project_params
		params.required(:project).permit(:name)
	end
end