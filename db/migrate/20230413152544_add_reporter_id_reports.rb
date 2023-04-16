class AddReporterIdReports < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :reporter_id, :integer
  end
end
