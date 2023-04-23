class RemoveReffenceFromComments < ActiveRecord::Migration[6.1]
  def change
    remove_reference :comments, :parent, foreign_key: { to_table: :comments }
  end
end
