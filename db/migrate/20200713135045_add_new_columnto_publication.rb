class AddNewColumntoPublication < ActiveRecord::Migration[6.0]
  def change
    add_column :publications, :description, :string
  end
end
