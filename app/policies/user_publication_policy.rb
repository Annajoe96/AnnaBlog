class UserPublicationPolicy < ApplicationPolicy

  def new?
    @record.publication.users.find(@user.id) != nil
  end

  def create?
    new?
  end

  def destroy?
    new? && @record.publication.users.count != 1
  end

end
