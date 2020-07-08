class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.page(params[:user_page])
    @comments = @user.comments.page(params[:comment_page])
  end

end
