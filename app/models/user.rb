class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  extend Devise::Models
  # has_secure_password
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    validates :email,:presence => true, uniqueness: { scope: :email }
    validates :password,:presence => true 
    validates :name,:presence => true     
    has_many :blogs,:dependent=>:destroy
    has_many :likes, dependent: :destroy
    has_many :comments, dependent: :destroy

    def self.find_email email
    	find_by_email(email)
    end	

    def self.create_new_user email,password,name
    	user = new(name: name,email: email,password: password)
  		user.save
  		user.id != nil ? {:code=>200,:result=>user} : {:code=>400,:message=>user.errors.full_messages.join(', ')}
    end	
end
