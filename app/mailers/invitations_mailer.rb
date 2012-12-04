class InvitationsMailer < ApplicationMailer
	def invite(email, invitation)
		@invitation = invitation

		mail(to: email, subject: 'Invitation from LilDebbie')
	end
end

InvitationsMailer.delivery_method = SendgridDeliveryMethod