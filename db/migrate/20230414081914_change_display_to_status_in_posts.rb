class ChangeDisplayToStatusInPosts < ActiveRecord::Migration[6.1]
  def up
    remove_column :posts, :display
    add_column :posts, :status, :integer, default: 0, null: false
  end

  def down
    add_column :posts, :display, :string
    remove_column :posts, :status
  end
end
