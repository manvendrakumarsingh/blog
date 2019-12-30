module UsersHelper
	def get_user_details email
		User.find_email(email)
	end	

	def add_new_user email,password,name
		User.create_new_user(email,password,name)
	end	
end
