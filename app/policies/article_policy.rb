class ArticlePolicy < ApplicationPolicy

  def new?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def edit?
    @user.id == @record.user_id
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

end
