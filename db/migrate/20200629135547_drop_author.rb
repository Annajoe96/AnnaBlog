class DropAuthor < ActiveRecord::Migration[6.0]
  def change
    remove_column :articles, :author, :string
  end
end
