Rails.application.routes.draw do
  devise_for :users
  root to: "students#index"
  
  resources :fee_plans
  
  resources :students, only: [:new, :create, :show, :edit, :update, :destroy] do
    resources :attendances, only: [:new, :create, :edit, :update, :destroy]
  end
  post 'students/:id/edit' => 'students#edit' 
end
