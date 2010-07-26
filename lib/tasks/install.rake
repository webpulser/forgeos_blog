namespace :forgeos do
  namespace :blog do
    task :sync do
      system "rsync -rvC #{File.join('vendor','plugins','forgeos_blog','public')} ."
    end

    task :initialize => :environment do
      system "rake 'forgeos:core:generate:acl[#{File.join('vendor','plugins','forgeos_blog')}]'"
    end

    task :install => [:initialize,:sync]
  end

end
