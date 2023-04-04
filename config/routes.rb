Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users do
    member do
      get :profile_pic
      get :profile_pic_thumb
      get :profile_intro
    end
  end
end
