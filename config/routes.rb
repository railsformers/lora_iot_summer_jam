Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end

  resources :projects, only: [:index] do
    resources :devices, only: [:index] do
      resources :messages, only: [:index], concerns: :paginatable
    end
  end
  root to: "projects#index"
end
