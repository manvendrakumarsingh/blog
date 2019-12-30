module BlogsHelper

	def add_new_blog image,description,id
		Blog.create_blog(image,description,id) 
	end 

	def upload_image image
		begin
			File.open(Rails.root.join('app', 'assets', 'images', image.original_filename), 'wb') do |file|
          		data = file.write(image.read)
          		image = '/assets/'+image.original_filename     
          		p image   	
        	end	
		rescue Exception => e
			image = ''
		end		
    end   

    def get_blog blog_id
    	Blog.find_by_id(blog_id)
    end 

    def get_comment id 
    	Comment.find_by_id(id)
    end	
end
