namespace :forgeos do
  namespace :blog do
    task :sync do
      system "rsync -rvC #{File.join('vendor','plugins','forgeos_blog','public')} ."
    end

    task :install => [:sync]
  end
end
