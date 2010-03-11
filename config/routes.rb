ActionController::Routing::Routes.draw do |map|
  map.namespace :blog do |blog|
    blog.resources :posts, :has_many => :comments, :only => [:show,:index]
    blog.root :controller => 'posts', :action => 'index'
  end

  map.namespace :admin do |admin|
    admin.resources :posts, :has_many => :comments
  end
end
