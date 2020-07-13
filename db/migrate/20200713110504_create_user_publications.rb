class CreateUserPublications < ActiveRecord::Migration[6.0]
  def change
    create_table :user_publications do |t|
      t.references :user
      t.references :publication
      t.timestamps
    end
  end
end
