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
    if @record.publication_id && @user
      @record.publication.user_publications.where(user_id: @user.id).any? && @record.user_id == @user.id
    elsif @user
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
