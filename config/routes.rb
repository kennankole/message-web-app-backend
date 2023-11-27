Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup',
    
  },
  controllers: {
    sessions: 'api/v1/users/sessions',
    registrations: 'api/v1/users/registrations'
  }


  namespace :api do
    namespace :v1 do
      resources :questions, only: [:index, :show, :create] do
        resources :users
        resources :answers, only: [:show, :create, :index]
      end
    end
  end
  get '/current_user', to: 'current_user#index'
end
