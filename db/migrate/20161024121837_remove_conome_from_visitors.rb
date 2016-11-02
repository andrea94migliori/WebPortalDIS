class RemoveConomeFromVisitors < ActiveRecord::Migration
  def change
      remove_column :visitors, :conome
  end
end
