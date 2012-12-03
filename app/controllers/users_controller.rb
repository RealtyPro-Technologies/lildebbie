class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to root_url
		else
			render 'new'
		end
	end

	def autocomplete
		query = params[:q]
		@users =  User.select(:username).where("username LIKE '#{query}%'")
		@users.collect! do |u|
			u.username
		end
		render text: @users.join('|')
	end

	private

	def user_params
		params.required(:user).permit(:username, :email, :password, :password_confirmation)
	end
end