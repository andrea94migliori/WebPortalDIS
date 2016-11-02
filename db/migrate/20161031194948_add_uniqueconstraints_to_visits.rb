class AddUniqueconstraintsToVisits < ActiveRecord::Migration
  def change
      add_index :visits, [:dal, :al, :visitor_id], unique: true
  end
end
