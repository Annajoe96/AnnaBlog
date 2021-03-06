class ArticlePolicy < ApplicationPolicy

  def new?
    true
  end

  def show?
    true
  end

  def create?
    if @record.publication_id
      @record.publication.user_publications.where(user_id: @user.id).any?
    else
      @record.user_id == @user.id
    end
  end

  def edit?
    return false unless @user

    if @record.publication_id
      @record.publication.user_publications.where(user_id: @user.id).any? && @record.user_id == @user.id
    else
      @user.id == @record.user_id
    end
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

end
