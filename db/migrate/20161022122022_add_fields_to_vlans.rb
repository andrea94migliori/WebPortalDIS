class AddFieldsToVlans < ActiveRecord::Migration
  def change
      add_column :vlans, :nome, :string
      add_column :vlans, :vlanID, :integer
  end
end
