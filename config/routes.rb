Rails.application.routes.draw do
  root 'static_pages#home'

  post 'users/authenticate' => 'users#authenticate_remote'
  get  'users/get_info/:auth_token' => 'users#provide_info'

  resources :users, except: [:new, :destroy]
  resources :sites

  scope controller: :users do
    get   'register' => :new, as: 'signup'
    get   'account'  => :show
    get   'settings' => :edit
    patch 'account'  => :update
  end

  scope controller: :sessions do
    get    'login'        => :new
    get    'login_remote' => :new_remote
    post   'login'        => :create
    delete 'signout'      => :destroy
  end  
end