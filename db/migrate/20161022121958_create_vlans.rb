class CreateVlans < ActiveRecord::Migration
  def change
    create_table :vlans do |t|

      t.timestamps null: false
    end
  end
end
