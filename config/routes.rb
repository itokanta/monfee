Rails.application.routes.draw do
  devise_for :users
  root to: "students#index"
  resources :students, only: [:new, :create, :show, :edit, :update]
end
