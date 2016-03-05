Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
      authenticated :user do
      root to: 'todo_lists#index', as: :authenticated_root
    end
  end

  devise_scope :user do
    unauthenticated :user do
      root to: "devise/sessions#new", as: :unauthenticated_root
    end
  end
    

  resources :user, only: [:index, :show] do
      resources :todo_items, only: [:index, :show]
    end

    resources :todo_lists do
      resources :todo_items
    end

    resources :todo_items
  
end
