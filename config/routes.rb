Rails.application.routes.draw do
  root "main#index"

  resources :countries do
    resources :regions
  end

  resources :regions


end
