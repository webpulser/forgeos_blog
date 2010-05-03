class Admin::ImportController < Admin::BaseController
  before_filter :blog_models, :only => :index

  map_fields :create_post, (Post.new.attributes.keys + Post.new.translated_attributes.stringify_keys.keys).sort
  def create_post
    create_model(Post,nil)
  end

  private
  def blog_models
    @models << 'post'
  end
end
