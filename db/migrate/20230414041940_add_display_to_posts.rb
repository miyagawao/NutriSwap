class AddDisplayToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :display, :string
  end
end
