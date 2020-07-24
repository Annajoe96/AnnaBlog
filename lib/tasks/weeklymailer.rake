namespace :weekly_mailer do
  task :run => :environment do
    if Date.today.sunday?
      WeeklyMailerService.new.articles_weekly
    end
  end
end
