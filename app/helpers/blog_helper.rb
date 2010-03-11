module BlogHelper
  def seo_post_path(post)
    blog_post_path(:id => post.url) 
  end
end
