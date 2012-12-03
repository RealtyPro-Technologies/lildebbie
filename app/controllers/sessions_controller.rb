class SessionsController < ApplicationController
	def create
		if params[:user]
			user = User.authenticate(params[:user][:username], params[:user][:password])
			if user
				session[:user_id] = user.id
				redirect_to root_url, notice: 'Logged in!'
			else
				redirect_to root_url, notice: 'Invalid username or password.'
			end
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_url, notice: 'Logged out!'
	end
end