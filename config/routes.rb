Rails.application.routes.draw do
  root "main#index"

  resources :countries do
    resources :regions
  end

  resources :regions do
    resources :cities
  end

  resources :cities


end
