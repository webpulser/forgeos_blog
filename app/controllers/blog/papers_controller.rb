class Blog::PapersController < ApplicationController
  before_filter :get_defaults
  def index
    @category = PaperCategory.find_by_url(params[:blog_category_id]) || PaperCategory.find_by_id(params[:blog_category_id]) if params[:blog_category_id]
    paginate_options = {:page => params[:page], :per_page => (params[:per_page] || 5), :order => 'papers.published_at DESC', :conditions => { :state => 'published'}}
    @papers = @category ? @category.elements.paginate(paginate_options) : Paper.paginate(paginate_options)
    respond_to do |format|
      format.html
      format.atom
      format.xml
      format.rss
    end
  end

  def show
    @paper = Paper.find_by_url(params[:id])
  end

  private
  def get_defaults
    @last_papers = Paper.all(:order => 'created_at DESC', :limit => 5)
    @categories = PaperCategory.all
  end
end
