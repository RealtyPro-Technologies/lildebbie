class Target < ActiveRecord::Base
	belongs_to :project
	belongs_to :user

	attr_accessible :url
end