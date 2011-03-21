Kajoo::Application.routes.draw do
  
  resources :issues do 
    #resource :solution
    resources :suggestions, :as => 'solutions'
    #, :as => 's'
    #disabled for now
    #match 'suggestions/:id/new'
    #match 'solutions/:id/vote' => 'solutions#vote', :as => 'vote_for_solution'
    #resources :comments
  end

  match 'issues/:id/vote' => 'issues#vote', :as => 'vote_for_issue'

  resources :reports
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :sessions => "users/sessions" }
  match 'users/:userid' => 'users#show', :as => 'user'


  match 'index' => "pages#index", :as => 'index'
  match 'dashboard' => 'pages#dashboard', :as => 'dashboard'
  match 'home' => 'pages#home', :as => 'home'
  match 'contact' => 'pages#contact', :as => 'contact'
  match 'about' => 'pages#about', :as => 'about'
  match 'helpus' => 'pages#helpus', :as => 'helpus'
  match 'help' => 'pages#help', :as => 'help'

#  get "users/dashboard"
  
  resources :users
  
  match 'user/location' => 'users#location'
  match 'user/address' => 'users#address'
  
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "pages#index"

end
