module PublicationsHelper

  def can_edit?(publication)
    user_signed_in? && publication.user_publications.where(user_id: current_user.id).any?
  end

end
