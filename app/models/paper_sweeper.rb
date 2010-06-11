class PaperSweeper < ActionController::Caching::Sweeper
  include BlogHelper
  observe Paper, Comment, PaperCategory

  def after_save(record)
    expire_cache_for(record)
  end

  def after_create(record)
    expire_cache_for(record)
  end

  def after_destroy(record)
    expire_cache_for(record)
  end

  private
  def expire_cache_for(record)
    case record
    when Paper
      expire_cache_for_paper(record)
    when PaperCategory
      expire_all_papers
    when Comment
      expire_cache_for_paper(record.commentable)
    else
      true
    end
  end

  def expire_cache_for_paper(paper)
    expire_page(seo_paper_path(paper))
  end

  def expire_all_papers
    Paper.all.each do |paper|
      expire_cache_for_paper(paper)
    end
  end
end
