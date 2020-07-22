class UserPublicationPolicy < ApplicationPolicy

  def new?
    @record.publication.users.where(id: @user.id).any?
  end

  def create?
    new?
  end

  def destroy?
    new? && @record.publication.users.count != 1
  end

end
