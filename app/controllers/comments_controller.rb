class CommentsController < ApplicationController

  before_action :find_article, only: [:create ,:destroy]
  before_action :authenticate_user!, only: [:create, :destroy]

  def create

    @comment = @article.comments.new(params[:comment].permit(:comment))
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to @article
    else
      flash[:alert] = @comment.errors.full_messages.join(', ')
      redirect_to @article
    end

  end

  def destroy
    if current_user.id == @article.user_id || @comment.user_id == current_user.id
      @comment = @article.comments.find(params[:id])
      @comment.destroy
      redirect_to @article
    else
      flash[:alert] = "You can't delete this comment"
      redirect_to @article
    end
  end

  private

  def find_article
    @article = Article.find(params[:article_id])
  end

end
