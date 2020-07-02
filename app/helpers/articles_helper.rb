module ArticlesHelper

  def hello(name)
    "hello #{name}"
  end

  def can_edit?(article)
    user_signed_in? && current_user.id == article.user_id
  end

  def can_delete_comment?(comment)
    user_signed_in? && (current_user.id == @article.user_id || i.user_id == current_user.id)
  end

end
