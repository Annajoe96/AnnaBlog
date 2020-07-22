class WeeklyMailerService

  def articles_weekly
    @articles = Article.where("created_at >= ?", 1.week.ago.utc).select(:id).pluck(:id)

    if @articles.any?
      User.all.select(:id).pluck(:id).each do |user_id|
        WeekMailer.with(article_ids: @articles, user_id: user_id).new_weekly_mail.deliver_later
      end
    end
  end
end
