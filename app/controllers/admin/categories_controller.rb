class Admin::CategoriesController < Admin::BaseController
  cache_sweeper :paper_sweeper, :only => [:create,:update,:destroy,:add_element]
end
