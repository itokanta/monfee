Rails.application.routes.draw do
  devise_for :users
  root to: "students#index"
  resources :students, only: [:new, :create, :show, :edit, :update, :destroy] do
    resources :attendances, only: [:index]
  end
  post 'students/:id/edit' => 'students#edit' 
end
