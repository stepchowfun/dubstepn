Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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

  # public routes
  root "home#posts_for_tag", :format => false
  get "/post/:post_id/*title" => "home#post", :format => false
  get "/post/:post_id" => "home#post", :format => false

  # for web crawlers and search engines
  get "/robots.txt" => "home#robots", :format => false
  get "/sitemap" => "home#sitemap", :format => false

  # syndication
  get "/rss/home" => redirect("/rss"), :format => false
  get "/rss" => "home#feed", :type => :rss, :format => false
  get "/rss/:tag" => "home#feed", :type => :rss, :format => false
  get "/atom/home" => redirect("/atom"), :format => false
  get "/atom" => "home#feed", :type => :atom, :format => false
  get "/atom/:tag" => "home#feed", :type => :atom, :format => false

  # admin panel
  get "/admin/index" => "home#admin", :format => false
  get "/admin/edit_post/:post_id" => "home#edit_post", :format => false
  post "/admin/create_post" => "home#create_post_action", :format => false
  post "/admin/move_up" => "home#move_up_action", :format => false
  post "/admin/move_down" => "home#move_down_action", :format => false
  post "/admin/move_top" => "home#move_top_action", :format => false
  post "/admin/move_bottom" => "home#move_bottom_action", :format => false
  post "/admin/edit_post" => "home#edit_post_action", :format => false
  post "/admin/delete_post" => "home#delete_post_action", :format => false
  post "/admin/create_redirect" => "home#create_redirect_action", :format => false
  post "/admin/delete_redirect" => "home#delete_redirect_action", :format => false

  # authentication
  get "/admin/login" => "home#login", :format => false
  post "/admin/login" => "home#login_action", :format => false
  post "/admin/logout" => "home#logout_action", :format => false

  # tags
  get "/home" => redirect("/")
  get "/home/1" => redirect("/")
  get "/:tag/:page" => "home#posts_for_tag", :format => false
  get "/*fullpath" => "home#catch_all", :format => false # used for tags and custom redirects
end
