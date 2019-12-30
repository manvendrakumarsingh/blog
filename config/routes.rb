Rails.application.routes.draw do
  devise_for :users
  root :to => redirect('/login')
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	get 'login'=>"users#login", as: "login"
  	post 'user/auth'=>"users#authenticate"
 	get "logout"=>"users#logout",as: "logout"
 	post "sign/up"=>"users#sign_up"
 	get "index"=>"blogs#index",as: 'blog_list'
 	post 'blog'=>"blogs#new_blog"
 	post 'like'=>'blogs#like'
 	post 'comment'=>'blogs#comment'
 	post 'reply'=>'blogs#reply'
end
