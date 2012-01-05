class User < ActiveRecord::Base
	attr_accessor :password

  has_attached_file :avatar, :styles => { :medium => '300x300>', :thumb => '100x100>' }
	
  validates :login, :presence => true, :length => { :minimum => 5 }
  validates :password, :presence => true, :length => { :minimum => 2 }


	def User.authenticate( login, password)
		if user = find_by_login( login )
			if user.hashed_password == encrypt_password( password, user.salt )
				user		# return user
			end
		end
	end
	
	def User.encrypt_password( password, salt )
		Digest::SHA2.hexdigest(password + 'wibble' + salt)
	end
	
	def generate_salt
		self.salt = self.object_id.to_s + rand.to_s
	end
	
	def password=( password )
		@password = password
		
		if password.present?
			generate_salt
			self.hashed_password = self.class.encrypt_password( password, salt )
		end
	end
	
end
