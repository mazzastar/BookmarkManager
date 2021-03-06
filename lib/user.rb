require 'bcrypt'

class User
	include DataMapper::Resource

	property :id, Serial
	property :email, String, :unique => true, :message => "This email is already taken"
	property :password_digest, Text
	property :username, String

	property :password_token, Text
	property :password_token_timestamp, DateTime

	attr_reader :password
	attr_accessor :password_confirmation

	validates_uniqueness_of :email
	validates_confirmation_of :password
	has n, :links

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

	def self.authenticate(email, password)
		user = first(:email => email)
				
		if user && BCrypt::Password.new(user.password_digest)==password
			user
		else
			nil
		end
	end

	def self.recover_password(email)   
		user = first(:email => email)
		if user
			user.password_token = SecureRandom.hex(32)
			user.password_token_timestamp = Time.now
			user.save
			user
		else
			nil
		end
	end

end