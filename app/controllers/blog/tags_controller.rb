class Blog::TagsController < ApplicationController
  before_filter :get_defaults

  def index
    if params[:tag_name]

      paginate_options = {
        :page => params[:page],
        :per_page => (params[:per_page] || 5),
      }

      # OPTIMIZE
      tags = ActsAsTaggableOn::Tagging.all(
        :include => :tag,
        :conditions => {
          :tags => {
            :name => params[:tag_name].humanize
          },
          :taggable_type => 'Paper'
        }
      )
      papers = tags.map(&:taggable).uniq.select{ |p| p.state == 'published' }
      unless papers.nil?
        @papers = papers.paginate(paginate_options)
      end
    end
  end


private
  def get_defaults
    @last_papers = Paper.latest(:limit => 5)
    @categories = PaperCategory.all
  end
end
