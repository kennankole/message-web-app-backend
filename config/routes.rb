Rails.application.routes.draw do
  get 'current_user/index'
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'api/v1/users/sessions',
    registrations: 'api/v1/users/registrations'
  }
  get 'current_user/index', to: 'current_user#index'
end
