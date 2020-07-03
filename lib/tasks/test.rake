namespace :test do
  task :new_task => :environment do
    puts Article.all.count
  end
end
