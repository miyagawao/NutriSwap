class RemoveNotNullConstraintFromContributors < ActiveRecord::Migration[6.1]
  def change
    change_column_null :contributors, :is_deleted, true
    change_column_null :contributors, :introduce, true
  end
end
