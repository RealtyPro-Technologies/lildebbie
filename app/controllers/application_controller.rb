class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

	layout :user_layout

	protected

	def current_user
		@current_user ||= UserDecorator.find(session[:user_id]) if session[:user_id]
	end

	def logged_in?
		current_user.present?
	end

	def user_layout
		if logged_in?
			'application'
		else
			'no_user'
		end
	end

	def authenticate_user!
		if not logged_in?
			return redirect_to root_url
		end

		if params[:projectname].present?
			project = Project.find(params[:username], params[:projectname])
			if project.owner_id != current_user.id
				if project.project_grants.where(user_id: current_user.id).count == 0
					return redirect_to root_url
				end
			end
		end
	end
end
