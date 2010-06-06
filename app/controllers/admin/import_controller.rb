class Admin::ImportController < Admin::BaseController
  before_filter :blog_models, :only => :index

  map_fields :create_paper, (Paper.new.attributes.keys + Paper.new.translated_attributes.stringify_keys.keys).sort
  def create_paper
    create_model(Paper,nil)
  end

  private
  def blog_models
    @models << 'paper'
  end
end
