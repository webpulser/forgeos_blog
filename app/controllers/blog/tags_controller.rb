class Blog::TagsController < ApplicationController
  before_filter :get_defaults
  
  def index
    if params[:tag_name]
     
      paginate_options = {
        :page => params[:page],
        :per_page => (params[:per_page] || 5),
        :conditions => { :state => 'published'}
      }
      
      tags = ActsAsTaggableOn::Tagging.all(
        :include => :tag,
        :conditions => { 
          :tags => { 
            :name => params[:tag_name].humanize 
          }
        }
      )
      papers = tags.collect{ |t| t.taggable }.uniq!
      unless papers.nil?
        @papers = papers.paginate(paginate_options)
      end
    end
  end
    
    
private
  def get_defaults
    @last_papers = Paper.all(:order => 'created_at DESC', :limit => 5)
    @categories = PaperCategory.all
  end
end