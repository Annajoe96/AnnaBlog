class LikePolicy < ApplicationPolicy

  def create?
    true
  end

  def destroy?
    @user.id == @record.user_id || @user.id == @record.article.user_id
  end

end
