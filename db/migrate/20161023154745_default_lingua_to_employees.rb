class DefaultLinguaToEmployees < ActiveRecord::Migration
  def change
      change_column :employees, :lingua, :string, :default => "it"
  end
end
