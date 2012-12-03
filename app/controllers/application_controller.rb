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
end
