class CommentMailer < ApplicationMailer

  def new_comment_email
    @comment = params[:comment]
    mail(to: @comment.article.user.email, subject: "#{@comment.user.full_name} commented on your post")
  end

  def new_commenter_email
    @comment = params[:comment]
    @comment.article.comments.select(:user_id).uniq.each do |c|
      next if @comment.user_id == c.user_id
      mail(to: c.user.email, subject: "#{@comment.user.full_name} commented on the same post")
    end
  end
end
