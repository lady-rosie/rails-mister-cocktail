Rails.application.routes.draw do
  root to: "cocktails#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :cocktails, only: [:index, :show, :new, :create, :destroy] do
    resources :doses, only: [:new, :create]
    resources :reviews, only: [:create]
  end
  resources :doses, only: [:destroy]
end
