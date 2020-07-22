module ArticlesHelper

  def hello(name)
    "hello #{name}"
  end

  

  def can_delete_comment?(comment)
    user_signed_in? && (current_user.id == @article.user_id || comment.user_id == current_user.id)
  end

end
