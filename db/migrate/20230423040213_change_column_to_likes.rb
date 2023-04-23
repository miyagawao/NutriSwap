class ChangeColumnToLikes < ActiveRecord::Migration[6.1]
  def change
    change_column_null :likes, :contributor_id, true
    change_column_null :likes, :post_id, true
  end
end
