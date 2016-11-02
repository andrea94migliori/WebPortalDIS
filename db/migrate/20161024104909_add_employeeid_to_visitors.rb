class AddEmployeeidToVisitors < ActiveRecord::Migration
  def change
    add_column :visitors, :employee_id, :integer
  end
end
