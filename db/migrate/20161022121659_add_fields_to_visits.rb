class AddFieldsToVisits < ActiveRecord::Migration
  def change
      add_column :visits, :dal, :date
      add_column :visits, :al, :date
      add_column :visits, :idVisit, :integer
      add_column :visits, :employee_id, :integer
      add_column :visits, :visitor_id, :integer
      add_column :visits, :status, :string, default: "Confermata"
      
      add_index :visits, :idVisit, unique: true
  end
end
