class RemoveForeignKeyFromComments < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :comments, column: :contributor_id
  end
end
