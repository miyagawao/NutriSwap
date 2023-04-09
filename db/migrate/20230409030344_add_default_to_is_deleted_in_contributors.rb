class AddDefaultToIsDeletedInContributors < ActiveRecord::Migration[6.1]
  def change
    change_column_default :contributors, :is_deleted, false
  end
end
