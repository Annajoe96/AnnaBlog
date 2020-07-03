ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Recent Posts" do
          table_for Article.all.limit(10) do |t|
            t.column("Title") { |article|  link_to(article.title, admin_article_path(article)) }
            t.column("User") { |article| article.user }
            t.column("Created at") { |article| time_ago_in_words(article.created_at) +" "+ "ago" }
          end
        end
      end


      column do
        panel "Users" do
          table_for User.all.limit(10) do |t|
            t.column("Name") { |user| link_to(user.full_name,admin_user_path(user))}
            t.column("Signed up on"){ |user| time_ago_in_words(user.created_at) +" "+ "ago"}
            t.column("Email") { |user| user.email }
          end
        end
      end



    end
  end # content
end
