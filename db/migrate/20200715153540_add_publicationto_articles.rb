class AddPublicationtoArticles < ActiveRecord::Migration[6.0]
  def change
    add_reference :articles, :publication , index: true
  end
end
