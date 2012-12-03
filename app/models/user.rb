class BlacklistValidator < ActiveModel::EachValidator
	BLACKLIST = %w(
		admin error readme about pricing prices explore
		account api blog cache changelog changes enterprise help
		jobs list lists login logout mine news plans popular
		projects security shop jobs translations signup status
		styleguide tour wiki stories organizations codereview better
		compare hosting preview future staging beta alpha next
		punches punch session users user app apps chris steph url about
		add config connect contact create delete downloads edit
		email faq favorites feed feeds follow followers following
		invite log logs map maps oauth oauth_clients auth openid
		privacy remove replies rss save search sessions settings
		sitemap ssl subscribe terms tos trends unfollow unsubscribe
		url widget widgets xfn xmpp auto autocomplete staff manage
		purchase checkout cart share url target targets
	)
	def validate_each(record, attribute, value)
		record.errors.add attribute, " is not available." if BLACKLIST.include?(value)
	end
end

class EmailValidator < ActiveModel::EachValidator
	def validate_each(record,attribute,value)
		record.errors[attribute] << (options[:message] || "is invalid") unless value =~ /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
	end
end

class User < ActiveRecord::Base
	has_many :projects, foreign_key: :owner_id
	has_many :invitations
	has_many :targets
	has_many :project_grants

	attr_accessor :password, :invitation_code
	attr_accessible :username, :email, :password, :password_confirmation, :invitation_code
	before_save :encrypt_password

	validates :username,
		presence: true,
		length: 3..16,
		uniqueness: true,
		blacklist: true,
		format: /^[a-zA-Z]\w+$/

	validates :email,
		presence: true,
		email: true,
		uniqueness: true

	validates :password,
		presence: {on: :create},
		confirmation: true

	def self.authenticate(username, password)
		user = User.where(:username => username).first
		if user.nil?
			return nil
		end

		expected = BCrypt::Engine.hash_secret(password, user.password_salt)
		if expected != user.password_hash
			return nil
		end

		user
	end

	def shared_projects
		self.project_grants.includes(:project).collect {|g| g.project }
	end

	def to_param
		self.username
	end

	def encrypt_password
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, self.password_salt)
		end
	end
end