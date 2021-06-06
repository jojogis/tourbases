Rails.application.routes.draw do
  root "main#index"

  resources :countries do
    resources :regions
  end

  resources :regions do
    resources :cities
    resources :tour_bases
  end

  resources :cities do
    resources :tour_bases
  end

  resources :tour_bases


end
