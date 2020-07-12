class LikesController < ApplicationController

  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :find_article

  def create
    @like = @article.likes.create(user: current_user)
    authorize @like
    if @like.save
      redirect_to @article
    else
      flash[:alert] = @like.errors.full_messages.join(', ')
      redirect_to @article
    end
  end

  def destroy
    @like = @article.likes.find(params[:id])
    authorize @like
    @like.destroy
    redirect_to @article
  end

  private

  def find_article
    @article = Article.find(params[:article_id])
  end

end
