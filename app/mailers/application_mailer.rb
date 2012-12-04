class SendgridDeliveryMethod
	def initialize(values)

	end

	def deliver!(mail)
		Rails.logger.info "Sending to #{mail.to}\nfrom #{mail.from}\nsubject #{mail.subject}\nbody #{mail.body.to_s}"

		SendgridToolkit::Mail.new.send_mail(
			to: mail.to.join(','),
			from: mail.from.join(','),
			subject: mail.subject,
			html: mail.body.to_s
		)
	end
end

class ApplicationMailer < ActionMailer::Base
	default from: 'noreply@homeflareapi.com'
end