class Visitor < ActiveRecord::Base
    
    #Before actions
    before_save { self.email = email.downcase }
    
    #Pattern for email
    valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
    #Relations in db
    has_many    :visits,       dependent:      :destroy
    belongs_to  :employee
    
    #Validations
    validates :nome,                presence: true,         length: { minimum: 2 , maximum:20 }
    validates :cognome,             presence: true,         length: { minimum: 2 , maximum:20 }
    validates :sesso,               presence: true
    validates :dataNascita,         presence: true
    validates :nazioneNascita,      presence: true
    validates :luogoNascita,        presence: true,         length: { maximum: 60 }
    validates :nazioneResidenza,    presence: true
    validates :cittaResidenza,      presence: true,         length: { maximum: 60 }
    validates :indirizzo,           presence: true,         length: { minimum: 7 , maximum:60 }
    validates :matricola,           presence: true,         length: { maximum: 7 , minimum: 7 },                                            uniqueness: true
    validates :email,               presence: true,         length: { maximum: 243 },               format: { with: valid_email_regex },    uniqueness: { case_sensitive: false }
    validates :password,                                    length: { minimum: 6 }
    validates :employee_id,         presence: true
    
    #Bcrypt
    has_secure_password
    
    def Visitor.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
    
    def full_name
        "Nome: #{nome} Cognome: #{cognome} Matricola: #{matricola}"
    end
    
    
end
