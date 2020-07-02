ActiveAdmin.register Article do

  index do
    selectable_column
    column :title
    column :user
    column :created_at
    column :updated_at
    column :comments_count do |article|
      article.comments.count
    end
    actions
  end

  show do
    attributes_table do
      row :title
      row :body
      row :created_at
      row :updated_at
      row :user

      row :word_count do |article|
        article.word_count
      end

      row :comment_count do |article|
        article.comments.count
      end
    end
    active_admin_comments
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :body, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :body, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
