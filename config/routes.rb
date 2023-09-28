Rails.application.routes.draw do
  root to: "tasks#index"
  resources :tasks, only: [:index, :new, :create, :destroy] do
    member do
      put :finish
    end
  end
end
