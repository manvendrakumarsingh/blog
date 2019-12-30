class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session  

  include ApplicationHelper


	def log_in?
  		@user = User.find(session[:user_id]) if session[:user_id].present?
	end

	def require_logged_in
		unless log_in?
			flash[:error]="You need to login first"
			redirect_to login_path
		end
	end

	def responce_json resultJson
	    respond_to do |format|
	      format.html { redirect_to root_path }
	      format.json { render :json => resultJson }
	    end
  	end

  	def model_errors modelName
	    fullerror = []
	    modelName.errors.map {|k,v| fullerror << "#{k} #{v}"}
	    fullerror.join(", ")
  	end

 
end
