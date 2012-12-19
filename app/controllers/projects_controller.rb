class ProjectsController < ApplicationController
	before_filter :authenticate_user!

	def index
		@user = UserDecorator.decorate(User.where(:username => params[:username]).first)

		unless @user.present?
			raise ActionController::RoutingError.new('Not Found')
		end

		@projects = ProjectDecorator.decorate(@user.projects)
	end

	def show
		@project = ProjectDecorator.find(params[:username], params[:projectname])
		
		unless @project.present?
			raise ActionController::RoutingError.new('Not Found')
		end

		@targets = @project.model.targets.where(user_id: current_user.id)
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

	def auth
		@project = Project.find(params[:username], params[:projectname])

		@target = @project.active_target(current_user)

		url = @target.url

		if request.query_parameters.size > 0
			url += "?#{request.query_parameters.to_param}"
		end

		redirect_to url
	end

	private

	def project_params
		params.required(:project).permit(:name)
	end
end