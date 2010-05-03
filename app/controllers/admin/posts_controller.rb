class Admin::PostsController < Admin::BaseController
  cache_sweeper :post_sweeper, :only => [:create, :update, :destroy]
  before_filter :get_post, :only => [:edit, :update, :destroy, :show]
  before_filter :new_post, :only => [:new, :create]
 
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

  # Create a Post
  # ==== Params
  # * post = Hash of Post's attributes
  #
  # The Post can be a child of another Post.
  def create
    if @post.save
      flash[:notice] = t('post.create.success').capitalize
      redirect_to(admin_posts_path)
    else
      flash[:error] = t('post.create.failed').capitalize
      render :action => 'new'
    end
  end

  # Edit a Post
  # ==== Params
  # * id = Post's id to edit
  # * post = Hash of Post's attributes
  #
  # The Post can be a child of another Post.
  def edit
  end
 
  def update
    if @post.update_attributes(params[:post])
      flash[:notice] = t('post.update.success').capitalize
      redirect_to(admin_posts_path)
    else
      flash[:error] = t('post.update.failed').capitalize
      render :action => 'edit'
    end
  end

  # Destroy a Post
  # ==== Params
  # * id = Post's id
  # ==== Output
  #  if destroy succed, return the Categories list
  def destroy
    if @post.destroy
      flash[:notice] = t('post.destroy.success').capitalize
    else
      flash[:error] = t('post.destroy.failed').capitalize
    end
    render :text => true
  end

private
  def get_post
    unless @post = Post.find_by_id(params[:id])
      flash[:error] = t('post.not_exist').capitalize
      return redirect_to(:action => :index)
    end
  end
  
  def new_post
    @post = Post.new(params[:post])
  end

  def sort
    columns = %w(post_translations.name post_translations.name people.lastname posts.state published_at)

    if params[:sSearch] && !params[:sSearch].blank?
      columns = %w(name name author)
    end

    per_page = params[:iDisplayLength].to_i
    offset =  params[:iDisplayStart].to_i
    page = (offset / per_page) + 1
    order_column = params[:iSortCol_0].to_i
    order = "#{columns[order_column]} #{params[:iSortDir_0].upcase}"

    conditions = {}
    includes = [:globalize_translations]
    options = { :page => page, :per_page => per_page }
    joins = [:globalize_translations]
    
    if params[:category_id]
      conditions[:categories_elements] = { :category_id => params[:category_id] }
      includes << :post_categories
      joins = []
    end

    if params[:ids]
      conditions[:posts] = { :id => params[:ids].split(',') }
    end

    options[:conditions] = conditions unless conditions.empty?
    options[:include] = includes unless includes.empty?
    options[:order] = order unless order.squeeze.blank?
    options[:joins] = joins

    if params[:sSearch] && !params[:sSearch].blank?
      options[:index] = "post_core.post_#{ActiveRecord::Base.locale}_core"
      options[:sql_order] = options.delete(:order)
      options[:joins] += options.delete(:include)
      @posts = Post.search(params[:sSearch],options)
    else
      options[:group] = :post_id
      @posts = Post.paginate(:all,options)
    end
  end
end
