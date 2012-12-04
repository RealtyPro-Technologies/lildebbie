class InvitationsController < ApplicationController
	before_filter :authenticate_user!

	def create
		@invitation = current_user.invitations.create

		InvitationsMailer.invite(params[:invitation][:email], @invitation).deliver
	end
end