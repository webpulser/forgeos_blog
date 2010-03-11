class Blog::PostsController < ApplicationController
  def index
    @category = PostCategory.find_by_url(params[:blog_category_id])
    @posts = @category ? @category.elements.paginate(:page => params[:page]) : Post.paginate(:page => params[:page])
    @categories = PostCategory.all
    respond_to do |format|
      format.html
      format.atom
    end
  end

  def show
    @post = Post.find_by_url(params[:id])
    @categories = PostCategory.all
  end
end
