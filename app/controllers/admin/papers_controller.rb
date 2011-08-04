class Admin::PapersController < Admin::BaseController
  cache_sweeper :paper_sweeper, :only => [:create, :update, :destroy]
  before_filter :get_paper, :only => [:edit, :update, :destroy, :show]
  before_filter :new_paper, :only => [:new, :create]
  before_filter :get_tags, :only => [:update, :create]

  def url
    render :text => Forgeos::url_generator(params[:url])
  end

  # List Categories
  def index
    respond_to do |format|
      format.html
      format.json do
        sort
        render :layout => false
      end
    end
  end

  def new
  end

  def show
  end

  # Create a Paper
  # ==== Params
  # * paper = Hash of Paper's attributes
  #
  # The Paper can be a child of another Paper.
  def create
    if @paper.save
      flash[:notice] = t('paper.create.success').capitalize
      redirect_to([forgeos_blog, :admin, :papers])
    else
      flash[:error] = t('paper.create.failed').capitalize
      render :action => 'new'
    end
  end

  # Edit a Paper
  # ==== Params
  # * id = Paper's id to edit
  # * paper = Hash of Paper's attributes
  #
  # The Paper can be a child of another Paper.
  def edit
  end

  def update
    if @paper.update_attributes(params[:paper])
      flash[:notice] = t('paper.update.success').capitalize
      redirect_to([forgeos_blog, :admin, :papers])
    else
      flash[:error] = t('paper.update.failed').capitalize
      render :action => 'edit'
    end
  end

  # Destroy a Paper
  # ==== Params
  # * id = Paper's id
  # ==== Output
  #  if destroy succed, return the Categories list
  def destroy
    #set page_url for cache sweeper
    @paper.paper_url = @paper.paper_urls.dup
    if @paper.destroy
      flash[:notice] = t('paper.destroy.success').capitalize
    else
      flash[:error] = t('paper.destroy.failed').capitalize
    end
  end

private
  def get_paper
    unless @paper = Paper.find_by_id(params[:id])
      flash[:error] = t('paper.not_exist').capitalize
      return redirect_to([forgeos_blog, :admin, :papers])
    end
  end

  def new_paper
    @paper = Paper.new(params[:paper])
  end

  def get_tags
    params[:paper][:tag_list]= params[:tag_list].join(',')
  end

  def sort
    columns = %w(paper_translations.name paper_translations.name people.lastname papers.state published_at)

    if params[:sSearch] && !params[:sSearch].blank?
      columns = %w(name name author)
    end

    per_page = params[:iDisplayLength].to_i
    offset =  params[:iDisplayStart].to_i
    page = (offset / per_page) + 1
    order_column = params[:iSortCol_0].to_i
    order = "#{columns[order_column]} #{params[:sSortDir_0].upcase}"

    conditions = {}
    includes = [:translations]
    options = { :page => page, :per_page => per_page }
    joins = [:translations]

    if params[:category_id]
      conditions[:categories_elements] = { :category_id => params[:category_id] }
      includes << :categories
      joins = []
    end

    if params[:ids]
      conditions[:papers] = { :id => params[:ids].split(',') }
    end

    options[:conditions] = conditions unless conditions.empty?
    options[:include] = includes unless includes.empty?
    options[:order] = order unless order.squeeze.blank?
    options[:joins] = joins

    if params[:sSearch] && !params[:sSearch].blank?
      options[:index] = "paper_core.paper_#{ActiveRecord::Base.locale}_core"
      options[:sql_order] = options.delete(:order)
      options[:joins] += options.delete(:include)
      @papers = Paper.search(params[:sSearch],options)
    else
      @papers = Paper.paginate(options)
    end
  end
end
