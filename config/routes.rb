Forgeos::Blog::Engine.routes.draw do
  namespace :blog do
    root :to => 'papers#index'
    resources :papers, :only => [:show,:index], :path => 'posts' do
      resources :comments
    end
    match 'tags/:tag_name' => 'tags#index', :as => :tags
    match 'categories/:blog_category_id' => 'papers#index', :as => :paper_category
  end

  namespace :admin do
    resources :papers do
      resources :comments
    end
    resources :paper_categories, :controller => 'categories', :type => 'paper_category'
  end
end
