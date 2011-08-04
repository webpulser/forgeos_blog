namespace :forgeos do
  namespace :blog do
    task :install => ['forgeos:cms:install'] do
      system "rake 'forgeos:core:generate:acl[#{Gem.loaded_specs['forgeos_blog'].full_gem_path}]'"
    end
  end
end
