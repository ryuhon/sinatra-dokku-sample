class AuthService
	def self.existUser (email,password)
		user = User.all(:email => email , :password =>password)
		user
	end
end