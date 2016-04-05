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
    

  resources :user do
    resources :todo_lists, only: [:index, :show]
  end

    resources :todo_lists
  
end
