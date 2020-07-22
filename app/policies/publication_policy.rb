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

  def edit?
    update?
  end

  def update?
    if @user != nil
      @record.user_publications.where(user_id: @user.id).any?
    end
  end

  def destroy?
    update?
  end



end
