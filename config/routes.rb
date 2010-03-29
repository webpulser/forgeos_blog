ActionController::Routing::Routes.draw do |map|
  map.namespace :blog do |blog|
    blog.resources :posts, :has_many => :comments, :only => [:show,:index]
    blog.post_category 'categories/:blog_category_id', :controller => 'posts', :action => 'index'
    blog.root :controller => 'posts', :action => 'index'
  end

  map.namespace :admin do |admin|
    admin.resources :posts, :has_many => :comments
    admin.resources "post_categories", :controller => 'categories', :requirements => { :type => "post_category" }
  end
end
