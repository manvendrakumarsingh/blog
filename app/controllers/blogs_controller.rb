class BlogsController < ApplicationController
before_action :require_logged_in
	
# Blog List
  def index
    @blogs = Blog.includes(:user,:comments,:likes,)
		render :layout => "admin_application"
	end	
# Add New Blog
	def new_blog
	  image = upload_image(params[:image_url])
	  blog  = add_new_blog(image,params[:name],@user.id)  
  	if blog[:code] == 200
      flash[:success]="Blog Add successfully"
    else
      flash[:error] = blog[:message]
    end  
		redirect_to blog_list_path
	end	
# Like On blog 
  def like
    begin
       blog = get_blog(params[:blog_id])
      like = blog.likes.find_by_user_id(params[:user_id])
      if like
        like.destroy
      else
        blog.likes.create(blog_id: params[:blog_id],user_id: params[:user_id])
      end  
        responce_json ({code: 200,message: "successfully",count: blog.likes.count})
    rescue Exception => e
      
    end     
  end  
#comment on blog
  def comment
    begin
    blog = get_blog(params[:blog_id])
    if params[:comment].present?
      blog.comments.create(blog_id: params[:blog],blog_comment: params[:comment],user_id: @user.id)
    end 
    responce_json ({code: 200,message: "successfully",comments: blog.comments})
    rescue Exception => e
      
    end
    
  end  

   def reply
    begin
      comment = get_comment(params[:comment_id])
    if params[:reply_comment].present?
      comment.replies.create(comment_id: params[:comment_id],comment_reply: params[:reply_comment],user_id: @user.id)
    end 
    responce_json ({code: 200,message: "successfully",comments: comment.replies})
    rescue Exception => e
      
    end
  end
end
