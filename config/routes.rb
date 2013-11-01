Blog::Application.routes.draw do
  
  devise_for :users
  resources :posts do
    resources :comments
  end

  root 'welcome#index'

end
