class Project < ActiveRecord::Base
	belongs_to :user, foreign_key: 'owner_id'
	has_many :project_grants

	attr_accessible :name

	def self.find(username, projectname)
		self.includes(:user).where('name = ? AND users.username = ?', projectname, username).first
	end

	def to_param
		self.name
	end
end