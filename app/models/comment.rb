require File.join(Rails.root,'vendor','plugins','forgeos_cms','app','models','comment')
require 'rakismet/model'
class Comment < ActiveRecord::Base
  include Rakismet::Model
  validates_presence_of :author_name, :unless => :skip_validates_presence_of_author_name?
  validates_presence_of :author_email, :unless => :skip_validates_presence_of_author_email?
  validates_presence_of :comment, :unless => :skip_validates_presence_of_comment?
  rakismet_attrs :content => :comment, :author => :author_name, :comment_type => 'comment'

  private
  def skip_validates_presence_of_author_name?
    false
  end

  def skip_validates_presence_of_author_email?
    false
  end

  def skip_validates_presence_of_comment?
    false
  end
end
