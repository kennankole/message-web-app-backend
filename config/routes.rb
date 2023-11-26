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
  get 'current_user/index'

  namespace :api do
    namespace :v1 do
      resources :questions, only: [:index, :show]
    end
  end
end
