require 'rakismet/controller'
class Blog::CommentsController < ApplicationController
  include Rakismet::Controller
  include BlogHelper
  rakismet_filter :only => :create
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params[:comment])
    unless @comment.spam?
      if @comment.valid?
        @comment.save
      else
        @comment.spam!
      end
    else
      flash[:notice] = @comment.akismet_response
    end
    redirect_to(seo_post_path(@post))
  end
end
