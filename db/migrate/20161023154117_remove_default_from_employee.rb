class RemoveDefaultFromEmployee < ActiveRecord::Migration
  def change
      change_column :employees, :lingua, :string, :default => nil
  end
end
