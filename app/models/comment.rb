load File.join(Gem.loaded_specs['forgeos_cms'].full_gem_path,'app','models','comment.rb')
class Comment < ActiveRecord::Base
  include Rakismet::Model
  validates :author_name, :unless => :skip_validates_presence_of_author_name?, :presence => true
  validates :author_email, :unless => :skip_validates_presence_of_author_email?, :presence => true
  validates :comment, :unless => :skip_validates_presence_of_comment?, :presence => true
  rakismet_attrs :content => :comment, :author => :author_name, :comment_type => 'comment'

  def author_name
    author ? author.fullname : super
  end

  def author_email
    author ? author.email : super
  end

  private
  def skip_validates_presence_of_author_name?
    author
  end

  def skip_validates_presence_of_author_email?
    author
  end

  def skip_validates_presence_of_comment?
    false
  end

  def self.latest_paper_comments(options = {})
    all(options.merge({:conditions => { :commentable_type => 'Paper' }, :order => 'created_at DESC'}))
  end

end
