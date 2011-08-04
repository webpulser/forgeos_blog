load File.join(Gem.loaded_specs['forgeos_core'].full_gem_path, 'app', 'controllers', 'admin', 'categories_controller.rb')
class Admin::CategoriesController < Admin::BaseController
  cache_sweeper :paper_sweeper, :only => [:create,:update,:destroy,:add_element]
end
