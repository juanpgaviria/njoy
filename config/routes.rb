Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, path: 'users', controllers: { registrations: 'users/registrations',
                                                   sessions: 'users/sessions' }
  devise_for :companies, path: 'companies', controllers: { registrations: 'companies/registrations',
                                                           sessions: 'companies/sessions' }
  resources :companies, only: %i[index show]
  resources :categories
  resources :products
  resources :suppliers

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
