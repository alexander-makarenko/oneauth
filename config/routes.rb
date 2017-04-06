Rails.application.routes.draw do
  root 'static_pages#home'

  scope controller: :sessions do    
    get    'login'   => :new
    post   'login'   => :create
    delete 'signout' => :destroy
  end

  resources :users, except: [:new]

  scope controller: :users do
    get   'register' => :new, as: 'signup'   
    get   'account'  => :show
    get   'settings' => :edit
    patch 'account'  => :update
  end
end