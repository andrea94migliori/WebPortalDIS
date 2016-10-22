class CreateIndirizzimacs < ActiveRecord::Migration
  def change
    create_table :indirizzimacs do |t|

      t.timestamps null: false
    end
  end
end
