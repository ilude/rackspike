

class User
	def self.authenticate(username, password)
		if(username == "test" && password == "test")
			return User.new username
		else
			return nil
		end
	end
	
	def self.get(username)
		return User.new username
	end
	
	def initialize(username)
		@username = username
	end
	
	def id
		return @username
	end
end