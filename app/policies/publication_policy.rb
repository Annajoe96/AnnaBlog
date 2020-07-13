class PublicationPolicy < ApplicationPolicy
  def new?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def destroy?
    @user.id == @record.user_id || @user.id == @record.article.user_id
  end
end
