class Blog < ApplicationRecord
	belongs_to :user
	has_many :likes, dependent: :destroy
	has_many :comments, dependent: :destroy
 	validates :description,:presence => true
	def self.create_blog image,description,id
		blog = new(description: description,image_url: image,user_id: id)
  		blog.save
  		blog.id != nil ? {:code=>200,:result=>blog} : {:code=>400,:message=>blog.errors.full_messages.join(', ')}
	end	
end
