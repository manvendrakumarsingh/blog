class SuperAdminsController < ApplicationController
	before_action :require_admin_logged_in, only:[:dashboard,:admin_profile]
	before_action :check_user,only: [:update_admin_profile]
	def login
		render :layout=> "blank"
	end

	def dashboard
		@admin
		render :layout => "admin_application"
  	end

  	def admin_auth
			if params[:email].present? and params[:password].present?
				admin =SuperAdmin.find_by_email(params[:email])
				if admin && admin.authenticate(params[:password])
					session[:admin_user_id]=admin.id
					redirect_to dashboard_path
				else
					flash[:error]="Unauthorised Access !!"
					redirect_to admin_login_path
				end
			else
				flash[:error]="Email and password can't be blank"
				redirect_to admin_login_path
			end 
		end

	def admin_profile
		render :layout => "admin_application"
	end	

	def update_admin_profile
		if @admin_details
			image = params[:admin_image].present? ? upload_multipart_image(params[:admin_image],"user_image") : @admin_details.image
			@admin_details.update_attributes(admin_name: params[:user_name],image: image)
			flash[:success]="Profile update successfully"
			redirect_to admin_profile_path
		else
			flash[:error]="Unauthorised Access !!"
			redirect_to admin_profile_path
		end						
	end	

	def admin_logout
		session[:admin_user_id]=nil
		flash[:success]="You successfully signout from Admin Panel !"
		redirect_to admin_login_path
	end

	private

	def check_user
		@admin_details = admin_details(params[:admin_user])
		unless @admin_details
			flash[:error]="Unauthorised Access !!"
			redirect_to admin_profile_path
		end

	end	
end
