Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :projects, only: [:index] do
    resources :devices, only: [:index] do
      resources :messages, only: [:index]
    end
  end
  root to: "projects#index"
end
