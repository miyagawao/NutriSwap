class AddDefaltToImpressionsCountInPosts < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :impressions_count, :integer, default: 0
  end
end
