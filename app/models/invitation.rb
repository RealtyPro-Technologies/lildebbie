class Invitation < ActiveRecord::Base
	belongs_to :user
	before_create :generate_code

	attr_accessor :email
	attr_accessible :email

	def generate_code
		if self.code.nil?
			self.code = Digest::SHA1.hexdigest("#{DateTime.now.to_i}/#{Random.rand(99999)}").slice(4,6)
		end
	end
end