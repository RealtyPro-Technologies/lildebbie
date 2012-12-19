class Project < ActiveRecord::Base
	belongs_to :user, foreign_key: 'owner_id'
	has_many :project_grants
	has_many :targets

	attr_accessible :name

	def self.find(username, projectname)
		self.includes(:user).where('name = ? AND users.username = ?', projectname, username).first
	end

	def to_param
		self.name
	end

	def active_target(user = nil)
		user ||= self.user
		self.targets.where(user_id: user.id, active: true).first
	end
end