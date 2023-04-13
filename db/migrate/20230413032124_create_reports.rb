class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.integer :contributor_id, null: false
      t.integer :comment_id, null: false
      t.string :reason, null: false

      t.timestamps
    end
  end
end
