class CommentsController < ApplicationController

  before_action :find_article, only: [:create ,:destroy]
  before_action :authenticate_user!, only: [:create, :destroy]

  def create

    @comment = @article.comments.new(params[:comment].permit(:comment))
    @comment.user_id = current_user.id
    authorize @comment
    if @comment.save
      CommentMailer.with(comment: @comment).new_comment_email.deliver_now
      CommentMailer.with(comment: @comment).new_commenter_email.deliver_now
      redirect_to @article
    else
      flash[:alert] = @comment.errors.full_messages.join(', ')
      redirect_to @article
    end

  end

  def destroy
    @comment = @article.comments.find(params[:id])
    authorize @comment
    @comment.destroy
    redirect_to @article
  end

  private

  def find_article
    @article = Article.find(params[:article_id])
  end

end
