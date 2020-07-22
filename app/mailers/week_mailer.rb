class WeekMailer < ApplicationMailer

  def new_weekly_mail
    @articles = Article.where(id: params[:article_ids])
    @user = User.find(params[:user_id])

    mail(to: @user.email, subject: "Weekly article update")
  end

end
