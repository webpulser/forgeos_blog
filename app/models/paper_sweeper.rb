class PaperSweeper < ActionController::Caching::Sweeper
  observe Paper

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
    #expire_cache blog_root_path
    #expire_cache blog_paper_path(record)
  end
end
