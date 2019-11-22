Rails.application.routes.draw do
  # This line mounts Solidus's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Solidus relies on it being the default of "spree"
  mount Spree::Core::Engine, at: '/'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  Spree::Core::Engine.routes.draw do
    resources :products, only: [:index, :new, :create, :edit, :update, :destroy] do
       get :autocomplete, :on => :collection
      resources :reviews, only: [:index, :new, :create, :edit, :update, :destroy] do
      end
    end 
  end

  # Products api call for autosearch
   namespace :api do
    namespace :v1 do
      get '/products' => "products#index"
    end
  end


  devise_for(:spree_user, {
      class_name: 'Spree::User',
      controllers: {omniauth_callbacks: 'spree/user_omniauth_callbacks'}
  })
end

