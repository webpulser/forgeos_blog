class Blog::PapersController < ApplicationController
  before_filter :get_defaults
  caches_page :show, :if => Proc.new { |c| c.request.format != 'js' }

  def index
    if params[:tag_name]
      @tags = ActsAsTaggableOn::Tagging.all(:include => :tag, :conditions => { :tags => { :name => params[:tag_name].humanize }})
    else
      @category = PaperCategory.find_by_url(params[:blog_category_id]) || PaperCategory.find_by_id(params[:blog_category_id]) if params[:blog_category_id]
    end

    paginate_options = {:page => page, :per_page => per_page, :conditions => { :state => 'published'}}
    case params[:sort_by]
    when 'popularity'
      paginate_options[:order] = "sum(#{PaperViewedCounter.table_name}.counter) DESC, papers.id DESC"
      paginate_options[:include] = :viewed_counters
      paginate_options[:group] = "papers.id"
    when 'commented'
      paginate_options[:order] = "COUNT(#{Comment.table_name}.id) DESC, papers.id DESC"
      paginate_options[:include] = :comments
      paginate_options[:group] = "papers.id"
    else
      paginate_options[:order] = 'papers.published_at DESC, papers.id DESC'
    end

    if params[:tag_name]
      @paper = @tags.collect{ |t| t.papers }.paginate(paginate_options)
    else
      @papers = @category ? @category.elements.paginate(paginate_options) : Paper.paginate(paginate_options)
    end

    respond_to do |format|
      format.html
      format.atom
      format.xml
      format.rss
    end
  end

  def show
    unless @paper = Paper.find_by_url(params[:id])
      page_not_found
    end
  end

  private
  def get_defaults
    @last_comments = Comment.latest_paper_comments(:limit => 5)
    @last_papers = Paper.latest(:limit => 5)
    @categories = PaperCategory.all
  end

  def page
    params[:page].to_i > 0 ? params[:page] : 1
  end

  def per_page
    params[:per_page].to_i > 0 ? params[:per_page] : 5
  end
end
