class AddFieldsToIndirizzimacs < ActiveRecord::Migration
  def change
      add_column :indirizzimacs, :hostname, :string
      add_column :indirizzimacs, :macAddress, :string
      add_column :indirizzimacs, :dispositivo, :string
      add_column :indirizzimacs, :connessione, :string
      add_column :indirizzimacs, :employee_id, :integer
      add_column :indirizzimacs, :vlan_id, :integer
      
      add_index :indirizzimacs, [:employee_id, :created_at]
      add_index :indirizzimacs, :employee_id
      add_index :indirizzimacs, :vlan_id
  end
end
