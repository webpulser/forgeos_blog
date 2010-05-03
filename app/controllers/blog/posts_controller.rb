class Blog::PostsController < ApplicationController
  before_filter :get_defaults
  def index
    @category = PostCategory.find_by_url(params[:blog_category_id])
    paginate_options = {:page => params[:page], :per_page => (params[:per_page] || 5), :order => 'posts.published_at ASC'}
    @posts = @category ? @category.elements.paginate(paginate_options) : Post.paginate(paginate_options)
    respond_to do |format|
      format.html
      format.atom
    end
  end

  def show
    @post = Post.find_by_url(params[:id])
  end

  private
  def get_defaults
    @last_posts = Post.all(:order => 'created_at DESC', :limit => 5)
    @categories = PostCategory.all
  end
end
