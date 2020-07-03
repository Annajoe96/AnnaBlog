class ArticlePolicy < ApplicationPolicy

  def create?
    true
  end

  def update?
    @user.id == @record.user_id
  end

end
