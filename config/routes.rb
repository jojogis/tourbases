Rails.application.routes.draw do
  root "main#index"
  scope :admin do
    resources :countries do
      resources :regions
      resources :tour_bases
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

  namespace :view do
    resources :tour_bases, only: [:index]
    resources :countries,only: [] do
      resources :tour_bases, only: [:index]
      resources :regions,only: [] do
        resources :tour_bases, only: [:index]
        resources :cities,only: [] do
          resources :tour_bases, only: [:index]
        end
      end
    end
  end





end
