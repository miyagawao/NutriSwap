class RemoveViewAndAddImpressionsCountToPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :view, :integer
    add_column :posts, :impressions_count, :integer
  end
end
