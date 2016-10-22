class AddFieldsToVisitors < ActiveRecord::Migration
  def change
      add_column :visitors, :nome, :string
      add_column :visitors, :conome, :string
      add_column :visitors, :sesso, :string
      add_column :visitors, :dataNascita, :date
      add_column :visitors, :nazioneNascita, :string
      add_column :visitors, :luogoNascita, :string
      add_column :visitors, :nazioneResidenza, :string
      add_column :visitors, :cittaResidenza, :string
      add_column :visitors, :indirizzo, :string
      add_column :visitors, :matricola, :string
      add_column :visitors, :email, :string
      add_column :visitors, :regione, :string
      add_column :visitors, :regioneResidenza, :string
      add_column :visitors, :password_digest, :string
      
      add_index :visitors, :email, unique: true
      add_index :visitors, :matricola, unique: true
      
      
  end
end
