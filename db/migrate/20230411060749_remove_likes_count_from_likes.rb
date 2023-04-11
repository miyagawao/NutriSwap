class RemoveLikesCountFromLikes < ActiveRecord::Migration[6.1]
  def change
    remove_column :likes, :likes_count, :integer
  end
end
