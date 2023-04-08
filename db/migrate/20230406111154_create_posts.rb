class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :contributor_id, null: false
      t.integer :genre_id, null: false
      t.string :title, null: false
      t.text :content, null: false
      t.integer :view

      t.timestamps
    end
  end
end
