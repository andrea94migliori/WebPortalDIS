class AddCognomeToVisitors < ActiveRecord::Migration
  def change
      add_column :visitors, :cognome, :string
  end
end
