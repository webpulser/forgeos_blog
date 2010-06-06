module BlogHelper
  def seo_paper_path(paper)
    blog_paper_path(:id => paper.url) 
  end
end
