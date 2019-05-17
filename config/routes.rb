Rails.application.routes.draw do
  root 'home#index'

  resources :employees
  devise_for :users, path: 'users', controllers: { registrations: 'users/registrations',
                                                   sessions: 'users/sessions' }
  devise_for :companies, path: 'companies', controllers: { registrations: 'companies/registrations',
                                                           sessions: 'companies/sessions' }
  namespace :employees do
    resources :sessions, only: %i[new create] do
      delete 'destroy', on: :collection
    end
  end
  resources :companies, only: %i[index show]
  resources :categories
  resources :products
  resources :suppliers
  resources :transaktions, only: %i[index show new create]
  resources :menus
  resources :boards, except: :show do
    get 'positions', to: 'boards#positions', on: :collection
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
