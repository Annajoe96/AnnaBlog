class ArticleMailer < ApplicationMailer
  def new_article_email
    @article = params[:article]

    mail(to: @article.user.email, subject: "Thank you for submitting an article")
  end
end
