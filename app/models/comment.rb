require 'rakismet/model'
class Comment < ActiveRecord::Base
  include Rakismet::Model
  rakismet_attrs :content => :comment
end
