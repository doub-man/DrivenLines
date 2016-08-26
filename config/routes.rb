Rails.application.routes.draw do
  root 'home#index'

  # Devise
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
end
