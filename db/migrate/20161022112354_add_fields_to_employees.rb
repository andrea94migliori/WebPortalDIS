class AddFieldsToEmployees < ActiveRecord::Migration
  def change
      add_column :employees, :new, :string
      add_column :employees, :nome, :string
      add_column :employees, :cognome, :string
      add_column :employees, :sesso, :string
      add_column :employees, :dataNascita, :date
      add_column :employees, :nazioneNascita, :string
      add_column :employees, :luogoNascita, :string
      add_column :employees, :nazioneResidenza, :string
      add_column :employees, :cittaResidenza, :string
      add_column :employees, :indirizzo, :string
      add_column :employees, :tipoAccount, :string, default: "Dipendente"
      add_column :employees, :email, :string
      add_column :employees, :password_digest, :string
      add_column :employees, :regione, :string
      add_column :employees, :regioneResidenza, :string
      add_column :employees, :email_confirmed, :boolean
      add_column :employees, :confirm_token, :string
      add_column :employees, :lingua, :string, default: "it"
      
      add_index :employees, :email, unique: true
      
  end
end
