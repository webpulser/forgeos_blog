Gem::Specification.new do |s|
  s.add_dependency 'forgeos_cms', '>= 1.9.4'
  s.add_dependency 'aasm', '>= 2.2.0'
  s.add_dependency 'rakismet', '>= 1.1.0'
  s.name = 'forgeos_blog'
  s.version = '1.9.2'
  s.date = '2011-08-05'

  s.summary = 'Blog engine of Forgeos plugins suite'
  s.description = 'Forgeos Blog provide papers (blog posts), comments and tags management'

  s.authors = ['Cyril LEPAGNOT']
  s.email = 'dev@webpulser.com'
  s.homepage = 'http://github.com/webpulser/forgeos_blog'

  s.files = Dir['{app,lib,config,db,recipes}/**/*', 'README*', 'LICENSE', 'COPYING*']
end
