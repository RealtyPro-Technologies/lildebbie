class ProjectGrant < ActiveRecord::Base
	belongs_to :project
	belongs_to :user

	attr_accessible :user

	def accepted?
		accepted_at.present?
	end

	def declined?
		declined_at.present?
	end

	def status
		if accepted?
			
		elsif declined?
			:declined
		else
			:pending
		end
	end
end