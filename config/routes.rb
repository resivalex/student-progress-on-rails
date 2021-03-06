Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  resources :users

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  get '/login' => 'login#index'

  post '/session' => 'session#create'
  delete '/session' => 'session#destroy'

  get '/timetable' => 'welcome#timetable'
  get '/tables' => 'welcome#tables'
  get '/teacher' => 'welcome#teacher'

  resources :users

  resources :auditories

  resources :groups do
    resources :students
  end

  resources :subjects

  resources :students, only: [:index, :show, :create, :update]

  resources :lessons do
    resources :students, only: [:index]
  end

  resources :marks do
    member do
      get :tracks
    end
  end

  resources :teachers, only: [:index, :show] do
    resources :marks, only: [:index]
  end

  namespace :admin do
    resources :tables, only: [:index, :show]
  end

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
