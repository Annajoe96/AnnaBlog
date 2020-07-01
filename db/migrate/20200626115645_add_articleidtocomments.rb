class AddArticleidtocomments < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :article, index: true
  end
end
