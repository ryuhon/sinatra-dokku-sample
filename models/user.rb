class User
	include DataMapper::Resource

	property :seq, 				Serial
	property :email,			String, :key => true,:format => :email_address,:required => true
	property :hashed_password,	String
	property :salt,				String
	property :first_name,		String  
	property :last_name,		String
	property :user_id,			String, :required => true
	property :reg_date,			DateTime, :default => DateTime.now

	# attr_accessor :password
	validates_presence_of :user_id, :email

	def password=(pass)
	    @password = pass
	    self.salt = Helpers::random_string(10) unless self.salt
	    self.hashed_password = User.encrypt(@password, self.salt)
  	end

  	def self.encrypt(pass, salt)
    	Digest::SHA1.hexdigest(pass + salt)
  	end

  	def self.authenticate(email, pass)
	    u = User.first(:email => email)
	    # binding.pry
	    return nil if u.nil?
	    return u if User.encrypt(pass, u.salt) == u.hashed_password
	    nil
  	end

end