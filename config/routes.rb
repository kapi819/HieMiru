Rails.application.routes.draw do
  get 'goals/index'
  get 'goals/new'
  get 'goals/edit'
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks",
    sessions: 'users/sessions'
  }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  root 'staticpages#top'
  resources :questions, only: [:index, :create] do
    collection do
      get 'result'
    end
  end
  resources :users, only: [:show]
  resources :goals, only: [:index, :new, :edit]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
