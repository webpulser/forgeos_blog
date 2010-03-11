class Blog::CommentsController < ApplicationController
  include Rakismet::Controller
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params[:comment])
    @comment.save
    redirect_to @post
  end
end
