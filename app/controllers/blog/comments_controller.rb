class Blog::CommentsController < ApplicationController
  include Rakismet::Controller
  include BlogHelper
  rakismet_filter :only => :create
  cache_sweeper :paper_sweeper, :only => :create
  skip_before_filter :verify_authenticity_token
  def create
    @paper = Paper.find(params[:paper_id])
    @comment = @paper.comments.build(params[:comment])
    unless @comment.spam?
      if @comment.valid?
        @comment.save
      else
        @comment.spam!
      end
    else
      flash[:notice] = @comment.akismet_response
    end
    redirect_to([:seo, @paper])
  end
end
