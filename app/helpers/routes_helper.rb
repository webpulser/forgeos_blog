module RoutesHelper
  def seo_paper_path(*args)
    forgeos_blog.blog_paper_path extract_paper_options(args)
  end

  def seo_paper_url(*args)
    forgeos_blog.blog_paper_url extract_paper_options(args)
  end

  def extract_paper_options(args)
    options = args.extract_options!
    object = args.first
    if object.is_a?(Paper)
      return options.merge(:id => object.url)
    else
      args << options
    end
  end

  def seo_blog_paper_category_path(category, options={})
    forgeos_blog.blog_paper_category_path(options.merge(:blog_category_id => category.url))
  end
end
