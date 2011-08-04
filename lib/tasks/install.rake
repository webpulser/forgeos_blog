namespace :forgeos do
  namespace :blog do
    task :install => ['forgeos:cms:install'] do
      Rake::Task['forgeos:core:generate:acl'].invoke(Gem.loaded_specs['forgeos_blog'].full_gem_path)
    end
  end
end
