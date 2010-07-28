module BlogHelper
  def seo_paper_path(paper, options={})
    blog_paper_path(options.merge(:id => paper.url))
  end
end
