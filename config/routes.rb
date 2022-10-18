Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace 'api' do
    post 'authenticate', to: 'authentication#authenticate'
    resources :users, except: [:new, :edit]
    resources :todos, except: [:new, :edit]
  end
end
