module BlogHelper
  def seo_paper_path(paper, options={})
    blog_paper_path(options.merge(:id => paper.url))
  end
  
  def seo_paper_cache_sweeper_path(url, options={})
    blog_paper_path(options.merge(:id => url))
  end
end
