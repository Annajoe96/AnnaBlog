namespace :weekly_mailer do
  task :run => :environment do
    WeeklyMailerService.new.articles_weekly
  end
end
