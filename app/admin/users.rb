ActiveAdmin.register User do

  index do
    selectable_column
    column :id
    column :email
    column :firstname
    column :lastname
    actions
  end

  show do

    attributes_table do
      row :id
      row :email
      row :firstname
      row :lastname
    end

    panel "Table of Contents" do
      table_for user.articles do
        column :id
        column "Title" do |article|
          link_to article.title, admin_article_path(article)
        end
        column :created_at
      end
    end

    active_admin_comments

  end


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :firstname, :lastname
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :firstname, :lastname]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
