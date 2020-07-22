Rails.application.routes.draw do

  concern :content_fields do
    namespace :content_field do
      resources :addresses
      resources :booleans
      resources :decimals
      resources :documents
      resources :images
      resources :integers
      resources :long_texts
      resources :short_texts
      resources :times
      resources :videos
    end
  end

  use_doorkeeper scope: 'api/customers/v1' do
    # it accepts :authorizations, :tokens, :applications and :authorized_applications
    skip_controllers :applications, :authorized_applications
  end

  use_doorkeeper scope: 'api/screens/v1' do
    # it accepts :authorizations, :tokens, :applications and :authorized_applications
    skip_controllers :applications, :authorized_applications
  end


  namespace :api, defaults: { format: 'json' } do
    namespace :customers do
      namespace :v1 do
        resources :content_types do
          resources :contents
        end
        resources :contents, only: [:index, :show, :update, :destroy] do
          resources :images do
            collection do
              delete :destroy_all
            end
          end
        end
        resource  :customer, only: [:show]
      end
    end

    namespace :screens do
      namespace :v1 do
        # resources :content_types do
        #   resources :contents
        # end
        resources :contents, only: [:index, :show]
        resource  :customer, only: [:show]
        resource  :screen,   only: [:show]
      end
    end
  end

  resources :global_content_types, concerns: [:content_fields]

  get '/customers/:customer_id/contents/new/content_type/:content_type_id' => 'contents#new', as: :new_customer_content

  resources :contents

  # get "/customers/:customer_id/contents/:content_id/images/:id/:version" => "content_images#show", as: :image, version: :s

  resources :customers do
    get :logo, on: :member
    # get "/contents/:content_id/images/:id/:version" => "content_images#show", as: :image, version: :s

    resources :content_lists

    resources :content_types, concerns: [:content_fields]
    resources :contents do
      collection do
        get :search
        post :sort
      end
      member do
        get :releases
        patch :releases
        post :releases
        put :releases
      end
      resources :raw_data_sets, only: [:index, :show]
    end
    resources :screens
    resources :users do
      resources :roles
    end
  end

  resources :pages do
    get :homepage
  end

  devise_for :users, controllers: { sessions: "sessions", passwords: "passwords" }

  resources :users do
    resources :roles
  end

  root to: "customers#index"

end
