module BlogHelper
  def tags
    # FIXME count taggable only if it state is 'published'
    ActsAsTaggableOn::Tag.count(:name, :joins => 'INNER JOIN taggings ON taggings.tag_id = tags.id' , :conditions => { :taggings => { :taggable_type => 'Paper'}}, :group => 'name', :select => 'name', :limit => 100 )
  end

  def tag_cloud(tags, classes)
    counts = tags.map(&:last)
    min = counts.min
    max = counts.max

    divisor = ((max - min) / classes.size) + 1

    tags.map do |t|
      yield t[0], classes[(t[1].to_i - min) / divisor]
    end
  end

  def resumer(content, options = {})
    truncate(content.gsub(/<\/?[^>]*>/, ""), { :length => 500 }.update(options))
  end
end
