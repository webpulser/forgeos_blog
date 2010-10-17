namespace :forgeos do
  namespace :blog do
    task :generate_acl, :roles => [:web, :app] do
      run "cd #{current_path}; rake forgeos:core:generate:acl[vendor/plugins/forgeos_blog] RAILS_ENV=production"
    end

    task :assets, :roles => [:web, :app] do
      run "cd #{release_path}; rake forgeos:blog:sync RAILS_ENV=production"
    end
  end
end

after 'forgeos:generate_acl', 'forgeos:blog:generate_acl'
after 'forgeos:assets', 'forgeos:blog:assets'
