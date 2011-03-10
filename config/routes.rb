FixIt::Application.routes.draw do
  
  resources :issues do 
    resources :solutions
    #disabled for now
    #match 'solutions/:id/vote' => 'solutions#vote', :as => 'vote_for_solution'
    #resources :comments
  end

  match 'issues/:id/vote' => 'issues#vote', :as => 'vote_for_issue'

  resources :reports

  match 'index' => "pages#index"
  match 'dashboard' => 'pages#dashboard'
  match 'home' => 'pages#home'  
  match 'contact' => 'pages#contact'
  match 'about' => 'pages#about'

  resources :users
  get "users/dashboard"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "pages#index"

end
