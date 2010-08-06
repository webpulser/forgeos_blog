class Blog::PapersController < ApplicationController
  before_filter :get_defaults
  caches_page :show, :if => Proc.new { |c| c.request.format != 'js' }
  def index
    
    if params[:tag_name]
      @tags = ActsAsTaggableOn::Tagging.all(:include => :tag, :conditions => { :tags => { :name => params[:tag_name].humanize }})
    else
      @category = PaperCategory.find_by_url(params[:blog_category_id]) || PaperCategory.find_by_id(params[:blog_category_id]) if params[:blog_category_id]
    end
    
    paginate_options = {:page => params[:page], :per_page => (params[:per_page] || 5), :conditions => { :state => 'published'}}
    case params[:sort_by]
    when 'popularity'
      paginate_options[:order] = "sum(#{PaperViewedCounter.table_name}.counter) DESC"
      paginate_options[:include] = :viewed_counters
      paginate_options[:group] = "papers.id"
    else
      paginate_options[:order] = 'papers.published_at DESC'
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
    if @paper = Paper.find_by_url(params[:id])
      unless cookies[:paper_view_counter] && cookies[:paper_view_counter].include?(@paper.id)
        @paper.viewed_counters.new.increment_counter
        counter = cookies[:paper_view_counter] ? cookies[:paper_view_counter] :  []
        counter << @paper.id
        cookies[:paper_view_counter] = { :value => counter, :expires => 1.day.from_now }
      end
    else
      render(:nothing => true, :status => 404)
    end
  end

  private
  def get_defaults
    @last_papers = Paper.latest(:limit => 5)
    @categories = PaperCategory.all
  end
end
