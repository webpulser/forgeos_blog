ActionController::Routing::Routes.draw do |map|
  map.namespace :blog do |blog|
    blog.resources :papers, :has_many => :comments, :only => [:show,:index], :as => :posts
    blog.paper_category 'categories/:blog_category_id', :controller => 'papers', :action => 'index'
    blog.root :controller => 'papers', :action => 'index'
  end

  map.namespace :admin do |admin|
    admin.resources :papers, :has_many => :comments
    admin.resources "paper_categories", :controller => 'categories', :requirements => { :type => "paper_category" }
  end
end
