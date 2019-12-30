class UsersController < ApplicationController
# before_action :require_logged_in,only:[]
	def login
		render :layout=> "blank"
	end

	def authenticate
		if params[:email].present? and params[:password].present?
			user = get_user_details(params[:email])
			if user && user.valid_password?(params[:password])
				session[:user_id]=user.id
				redirect_to blog_list_path
			else
				flash[:error]="Unauthorised Access !!"
				redirect_to login_path
			end
		else
			flash[:error]="Email and password can't be blank"
			redirect_to login_path
		end 
	end

	def sign_up
		user = add_new_user(params[:email],params[:password],params[:name])
		if user[:code] == 200
			responce_json ({code: 200,message: "Sign Up successfully"})
		else
			responce_json (user)
		end 	
	end	

	def logout
		session[:admin_user_id]=nil
		flash[:success]="You successfully signout"
		redirect_to login_path
	end
end
